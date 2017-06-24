module ActiveRecord
  module UUID
    module TableDefinition
      def references(*args)
        options = args.extract_options!
        options[:type] = :uuid unless options.include?(:type)
        args << options

        super(*args)
      end

      alias_method :belongs_to, :references

      def primary_key(name, type = :primary_key, **options)
        options[:default] = ::ActiveRecord::UUID::Utils.uuid_default_function
        super(name, type, **options)
      end
    end
  end
end
