# frozen_string_literal: true

require "test_helper"

if ActiveRecord::VERSION::STRING >= "5.1.0"
  class ExtensionTest < Minitest::Test
    setup do
      schema do
        enable_extension "pgcrypto"
      end
    end

    test "raises exception for missing extension" do
      assert_raises(AR::UUID::MissingExtensionError) do
        schema do
          disable_extension "uuid-ossp"
          disable_extension "pgcrypto"

          drop_table :sample if data_source_exists?(:sample)
          create_table :sample
        end
      end
    end

    test "uses uuid-ossp" do
      schema do
        disable_extension "pgcrypto"
        enable_extension "uuid-ossp"

        drop_table :sample if data_source_exists?(:sample)
        create_table :sample
      end

      model_class = create_model

      assert_equal "uuid_generate_v4()",
                   model_class.columns_hash["id"].default_function
    end

    test "uses pgcrypto" do
      schema do
        disable_extension "uuid-ossp"
        enable_extension "pgcrypto"

        drop_table :sample if data_source_exists?(:sample)
        create_table :sample
      end

      model_class = create_model

      assert_equal "gen_random_uuid()",
                   model_class.columns_hash["id"].default_function
    end

    test "works with both extensions enabled" do
      schema do
        enable_extension "uuid-ossp"
        enable_extension "pgcrypto"

        drop_table :sample if data_source_exists?(:sample)
        create_table :sample
      end

      model_class = create_model

      assert_equal "gen_random_uuid()",
                   model_class.columns_hash["id"].default_function
    end
  end
end
