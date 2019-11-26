# frozen_string_literal: true

module ActiveRecord
  module UUID
    MissingExtensionError = Class.new(StandardError) do
      def initialize
        super(%[Use either `enable_extension "uuid-ossp"` or `enable_extension "pgcrypto"`])
      end
    end

    module Utils
      EXTENSIONS_SQL = <<-SQL
        select
          extname
        from pg_extension
        where
          extname in ('uuid-ossp', 'pgcrypto')
        order by 1
        limit 1
      SQL

      FUNCTION_NAMES = {
        "uuid-ossp" => "uuid_generate_v4()",
        "pgcrypto" => "gen_random_uuid()"
      }.freeze

      def self.uuid_extname
        connection = ::ActiveRecord::Base.connection
        result = connection.execute(EXTENSIONS_SQL).first
        raise MissingExtensionError unless result

        result.fetch("extname")
      end

      def self.uuid_default_function
        FUNCTION_NAMES.fetch(uuid_extname)
      end

      def self.belongs_to_required_by_default
        if ::ActiveRecord::Base.respond_to?(:belongs_to_required_by_default)
          ::ActiveRecord::Base.belongs_to_required_by_default
        else
          false
        end
      end
    end
  end
end
