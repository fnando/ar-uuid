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
    end
  end
end
