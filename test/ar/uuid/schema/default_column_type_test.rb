# frozen_string_literal: true

require "test_helper"

class DefaultColumnTypeTest < Minitest::Test
  setup do
    schema do
      enable_extension "pgcrypto"
    end
  end

  test "creates primary key as uuid column" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample
    end

    model_class = create_model

    assert_uuid_column model_class, :id
  end

  test "creates reference as uuid column" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.references :user
      end
    end

    model_class = create_model { has_many :users }

    assert_uuid_column model_class, :user_id
  end

  test "creates reference as uuid column (belongs_to)" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.belongs_to :user
      end
    end

    model_class = create_model { has_many :users }

    assert_uuid_column model_class, :user_id
  end

  test "creates reference as uuid (add_reference)" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample
      add_reference :sample, :user
    end

    model_class = create_model
    assert_uuid_column model_class, :user_id
  end
end
