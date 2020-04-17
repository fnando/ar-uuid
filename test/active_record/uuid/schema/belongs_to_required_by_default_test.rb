# frozen_string_literal: true

require "test_helper"

if ActiveRecord::Base.respond_to?(:belongs_to_required_by_default)
  class BelongsToRequiredByDefaultTest < Minitest::Test
    test "requires association" do
      ActiveRecord::Base.belongs_to_required_by_default = true

      schema do
        drop_table :sample if data_source_exists?(:sample)
        create_table :sample do |t|
          t.belongs_to :user
        end
      end

      sql = <<~SQL
        SELECT is_nullable
        FROM information_schema.columns
        WHERE table_name = 'sample' AND column_name = 'user_id'
      SQL

      column = ActiveRecord::Base.connection.execute(sql).first
      assert_equal "NO", column["is_nullable"]

      model_class = create_model { belongs_to :user }
      instance = model_class.create

      assert instance.errors[:user].any?
    end

    test "ignores association requirement" do
      ActiveRecord::Base.belongs_to_required_by_default = false

      schema do
        drop_table :sample if data_source_exists?(:sample)
        create_table :sample do |t|
          t.belongs_to :user
        end
      end

      sql = <<~SQL
        SELECT is_nullable
        FROM information_schema.columns
        WHERE table_name = 'sample' AND column_name = 'user_id'
      SQL

      column = ActiveRecord::Base.connection.execute(sql).first
      assert_equal "YES", column["is_nullable"]

      model_class = create_model { belongs_to :user }
      instance = model_class.create

      assert instance.errors[:user].empty?
    end

    test "respects given option" do
      ActiveRecord::Base.belongs_to_required_by_default = true

      schema do
        drop_table :sample if data_source_exists?(:sample)
        create_table :sample do |t|
          t.belongs_to :user, null: true
        end
      end

      sql = <<~SQL
        SELECT is_nullable
        FROM information_schema.columns
        WHERE table_name = 'sample' AND column_name = 'user_id'
      SQL

      column = ActiveRecord::Base.connection.execute(sql).first
      assert_equal "YES", column["is_nullable"]
    end
  end
end
