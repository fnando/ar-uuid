module ActiveRecord
  module UUID
    module TableDefinition
      def references(*args)
        options = args.extract_options!
        options[:type] = :uuid unless options.include?(:type)
        options[:null] = !::ActiveRecord::UUID::Utils.belongs_to_required_by_default unless options.include?(:null)
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
