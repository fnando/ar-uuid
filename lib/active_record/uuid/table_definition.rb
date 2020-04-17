# frozen_string_literal: true

module ActiveRecord
  module UUID
    module TableDefinition
      def references(*args)
        options = args.extract_options!
        options[:type] = :uuid unless options.include?(:type)

        unless options.include?(:null)
          options[:null] =
            !::ActiveRecord::UUID::Utils.belongs_to_required_by_default
        end

        args << options

        super(*args)
      end
      alias belongs_to references

      def primary_key(name, type = :primary_key, **options)
        options[:default] = ::ActiveRecord::UUID::Utils.uuid_default_function
        super(name, type, **options)
      end
    end
  end
end
