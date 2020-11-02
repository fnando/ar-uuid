# ActiveRecord::UUID

[![Tests](https://github.com/fnando/ar-uuid/workflows/Tests/badge.svg)](https://github.com/fnando/ar-uuid/actions?query=workflow%3ATests)
[![Code Climate](https://codeclimate.com/github/fnando/ar-uuid/badges/gpa.svg)](https://codeclimate.com/github/fnando/ar-uuid)
[![Gem](https://img.shields.io/gem/v/ar-uuid.svg)](https://rubygems.org/gems/ar-uuid)
[![Gem](https://img.shields.io/gem/dt/ar-uuid.svg)](https://rubygems.org/gems/ar-uuid)

Override migration methods to support UUID columns without having to be explicit
about it.

What this gem will do for you:

- When creating new tables, will set the `id` column as `uuid`.
- When creating associations with `t.belongs_to`, `t.references` or
  `add_reference`, will set the column type as `uuid`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ar-uuid"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar-uuid

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment. 4 To
install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git commits
and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/fnando/ar-uuid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
