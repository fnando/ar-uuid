# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection "postgres:///test"
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = nil

# Apply a migration directly from your tests:
#
#   test "do something" do
#     schema do
#       drop_table :users if table_exists?(:users)
#
#       create_table :users do |t|
#         t.text :name, null: false
#       end
#     end
#   end
#
def schema(&block)
  ActiveRecord::Schema.define(version: 0, &block)
end

# Create a new migration, which can be executed up and down.
#
#   test "do something" do
#     migration = with_migration do
#       def up
#         # do something
#       end
#
#       def down
#         # undo something
#       end
#     end
#
#     migration.up
#     migration.down
#   end
#
def with_migration(&block)
  migration_class = ActiveRecord::Migration[
    ActiveRecord::Migration.current_version
  ]

  Class.new(migration_class, &block).new
end
