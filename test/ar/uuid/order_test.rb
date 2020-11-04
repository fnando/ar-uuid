# frozen_string_literal: true

require "test_helper"

if ActiveRecord::Base.respond_to?(:implicit_order_column)
  class OrderTest < Minitest::Test
    setup do
      schema do
        enable_extension "pgcrypto"
      end
    end

    teardown do
      ActiveRecord::Base.logger = nil
      User.implicit_order_column = nil
    end

    test "finds first using updated_at" do
      schema do
        drop_table :users if data_source_exists?(:users)
        create_table :users do |t|
          t.text :username
          t.timestamps
        end
      end

      logger = StringIO.new
      ActiveRecord::Base.logger = Logger.new(logger)

      model = create_model("users") do
        self.implicit_order_column = "updated_at"
      end

      model.first

      assert_includes logger.tap(&:rewind).read,
                      %[ORDER BY "users"."updated_at"]
    end

    test "finds last using updated_at" do
      schema do
        drop_table :users if data_source_exists?(:users)
        create_table :users do |t|
          t.text :username
          t.timestamps
        end
      end

      logger = StringIO.new
      ActiveRecord::Base.logger = Logger.new(logger)

      model = create_model("users") do
        self.implicit_order_column = "updated_at"
      end

      model.last

      assert_includes logger.tap(&:rewind).read,
                      %[ORDER BY "users"."updated_at"]
    end

    test "respects inheritance" do
      schema do
        drop_table :users if data_source_exists?(:users)
        create_table :users do |t|
          t.text :username
          t.timestamps
        end
      end

      model_a = Class.new(ActiveRecord::Base) do
        self.table_name = "users"
        self.implicit_order_column = "updated_at"

        def self.name
          "ModelA"
        end
      end

      model_b = Class.new(model_a) do
        def self.name
          "ModelB"
        end
      end

      assert_equal "updated_at", model_b.implicit_order_column
    end
  end
end
