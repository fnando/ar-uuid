# ar-uuid

[![Tests](https://github.com/fnando/ar-uuid/workflows/Tests/badge.svg)](https://github.com/fnando/ar-uuid)
[![Code Climate](https://codeclimate.com/github/fnando/ar-uuid/badges/gpa.svg)](https://codeclimate.com/github/fnando/ar-uuid)
[![Gem](https://img.shields.io/gem/v/ar-uuid.svg)](https://rubygems.org/gems/ar-uuid)
[![Gem](https://img.shields.io/gem/dt/ar-uuid.svg)](https://rubygems.org/gems/ar-uuid)

Add UUID support for ActiveRecord. It also enforces uuid as primary keys.

## Installation

```bash
gem install ar-uuid
```

Or add the following line to your project's Gemfile:

```ruby
gem "ar-uuid"
```

## Usage

There's no setup. Just adding the gem to your Gemfile is enough. When you create
a new table, the `id` column will be defined as `uuid`. This is also true for
references.

```ruby
create_table :users
add_reference :posts, :users

create_table :posts do |t|
  t.belongs_to :user
  # or
  t.references :user
end
```

If you need a serial column, AR's PostgreSQL supports the `bigserial` column
type.

```ruby
create_table :users do |t|
  t.column :position, :bigserial, null: false
end
```

### Sorting

#### Rails 6.0 or newer

If you're using Rails 6.0 or newer, you can set a default sorting with
[ActiveRecord::ModelSchema.implicit_order_column](https://api.rubyonrails.org/classes/ActiveRecord/ModelSchema.html#method-c-implicit_order_column),
so methods like `ActiveRecord::FinderMethods::InstanceMethods#first` and
`ActiveRecord::FinderMethods::InstanceMethods#last` will work transparently, as
long as you define another column for sorting, such as `created_at` (you may
need to add an index).

The following example sets a default behavior to always sort using `created_at`
(when available). On your abstract model, add the following lines:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.inherited(child_class)
    super

    return unless child_class.columns.any? {|col| col.name == "created_at" }

    child_class.implicit_order_column ||= "created_at"
  end
end
```

#### Older Rails versions

For older Rails versions, you can't use methods like
`ActiveRecord::FinderMethods::InstanceMethods#first` and
`ActiveRecord::FinderMethods::InstanceMethods#last`, since they are scoped to
the sequential id.

The easiest alternative is ordering results and calling `first`/`last`. You can
either create a sequence, or use the `created_at`/`updated_at` columns:

```ruby
# Get first record
User.order(created_at: :asc).first

# Get last record
User.order(created_at: :desc).first

# Use scopes
class User < ApplicationRecord
  scope :newer, -> { order(created_at: :desc) }
  scope :older, -> { order(created_at: :asc) }
end

User.older.first
User.newer.first
```

You can also replace `.first` with
[ActiveRecord::FinderMethods::InstanceMethods#take](https://github.com/rails/rails/blob/f52354ad1d15120dcc5284714bee7ee3f052986c/activerecord/lib/active_record/relation/finder_methods.rb#L104),
which will use the order implemented by the database.

There's no alternative to `.last`.

## Maintainer

- [Nando Vieira](https://github.com/fnando)

## Contributors

- https://github.com/fnando/ar-uuid/contributors

## Contributing

For more details about how to contribute, please read
https://github.com/fnando/ar-uuid/blob/main/CONTRIBUTING.md.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT). A copy of the license can be
found at https://github.com/fnando/ar-uuid/blob/main/LICENSE.md.

## Code of Conduct

Everyone interacting in the ar-uuid project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/ar-uuid/blob/main/CODE_OF_CONDUCT.md).
