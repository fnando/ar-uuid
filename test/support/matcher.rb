# frozen_string_literal: true

module Minitest
  class Test
    def assert_uuid_column(model_class, column_name)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert "uuid", column.sql_type
    end

    def assert_integer_column(model_class, column_name)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert "integer", column.sql_type
    end
  end
end
