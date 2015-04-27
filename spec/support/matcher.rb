RSpec::Matchers.define :have_uuid_column do |column_name|
  match do |model_class|
    model_class.reset_column_information
    column = model_class.columns.find {|col| col.name == column_name.to_s }
    column.sql_type == 'uuid'
  end

  failure_message do |model_class|
    "expected #{model_class.inspect} to have #{column_name.inspect} as uuid column"
  end

  description do
    "expect #{column_name.inspect} to be uuid"
  end
end

RSpec::Matchers.define :have_integer_column do |column_name|
  match do |model_class|
    model_class.reset_column_information
    column = model_class.columns.find {|col| col.name == column_name.to_s }
    column.sql_type == 'integer'
  end

  failure_message do |model_class|
    "expected #{model_class.inspect} to have #{column_name.inspect} as integer column"
  end

  description do
    "expect #{column_name.inspect} to be integer"
  end
end
