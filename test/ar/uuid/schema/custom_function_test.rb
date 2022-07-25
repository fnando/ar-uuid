# frozen_string_literal: true

require "test_helper"

class CustomFunctionTest < Minitest::Test
  setup do
    schema do
      enable_extension "pgcrypto"

      connection.execute <<~SQL
        CREATE OR REPLACE FUNCTION my_custom_uuid() RETURNS uuid
          AS $$
            SELECT gen_random_uuid();
          $$ LANGUAGE SQL;
      SQL

      AR::UUID::Utils::FUNCTION_NAMES["pgcrypto"] = "my_custom_uuid()"
    end
  end

  teardown do
    AR::UUID::Utils::FUNCTION_NAMES["pgcrypto"] = "gen_random_uuid()"
  end

  test "uses custom function for column default's value" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample
    end

    model_class = create_model

    assert_equal "my_custom_uuid()",
                 model_class.columns_hash["id"].default_function
  end
end
