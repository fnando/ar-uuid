ActiveSupport.on_load(:active_record) do
  require 'active_record/connection_adapters/postgresql_adapter'

  ActiveRecord::Schema.include ActiveRecord::UUID::Schema
  ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition.include ActiveRecord::UUID::TableDefinition
end
