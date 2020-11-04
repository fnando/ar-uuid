# frozen_string_literal: true

module AR
  module UUID
    module TableDefinition
      def references(*args)
        options = args.extract_options!
        options[:type] = :uuid unless options.include?(:type)

        unless options.include?(:null)
          options[:null] =
            !::AR::UUID::Utils.belongs_to_required_by_default
        end

        super(*args, **options)
      end
      alias belongs_to references

      def primary_key(name, type = :primary_key, **options)
        options[:default] = ::AR::UUID::Utils.uuid_default_function
        super(name, type, **options)
      end
    end
  end
end
