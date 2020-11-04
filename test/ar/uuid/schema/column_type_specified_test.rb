# frozen_string_literal: true

require "test_helper"

class ColumnTypeSpecifiedTest < Minitest::Test
  setup do
    schema do
      enable_extension "pgcrypto"
    end
  end

  test "creates primary key as integer column" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample, id: :primary_key
    end

    model_class = create_model

    assert_integer_column model_class, :id
  end

  test "creates reference as integer column" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.references :user, type: :integer
      end
    end

    model_class = create_model { has_many :users }

    assert_integer_column model_class, :user_id
  end

  test "creates reference as integer column (belongs_to)" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.belongs_to :user, type: :integer
      end
    end

    model_class = create_model { has_many :users }

    assert_integer_column model_class, :user_id
  end

  test "creates reference as integer column (add_reference)" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample
      add_reference :sample, :user, type: :integer
    end

    model_class = create_model
    assert_integer_column model_class, :user_id
  end
end
