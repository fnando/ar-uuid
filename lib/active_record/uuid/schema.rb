# frozen_string_literal: true

module ActiveRecord
  module UUID
    module Schema
      def create_table(table_name, options = {}, &block)
        options[:id] = :uuid unless options.key?(:id)
        super(table_name, options, &block)
      end

      def add_reference(table_name, ref_name, options = {})
        options[:type] = :uuid unless options.key?(:type)
        super(table_name, ref_name, options)
      end
    end
  end
end
