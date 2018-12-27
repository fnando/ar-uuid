def schema(uuid: true, &block)
  ActiveRecord::Schema.define(version: 0) do
    enable_extension "uuid-ossp" if uuid
    instance_eval(&block) if block
  end
end

def create_model(table_name = "sample", &block)
  Class.new(ActiveRecord::Base) do
    self.table_name = table_name
    reset_column_information

    instance_eval(&block) if block

    def self.name
      "Sample"
    end
  end
end
