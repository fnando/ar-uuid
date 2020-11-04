# frozen_string_literal: true

ActiveSupport.on_load(:active_record) do
  require "active_record/connection_adapters/postgresql_adapter"

  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.include(
    AR::UUID::Schema
  )

  ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition.include(
    AR::UUID::TableDefinition
  )
end
