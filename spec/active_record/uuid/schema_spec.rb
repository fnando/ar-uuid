require 'spec_helper'

describe ActiveRecord::UUID::Schema do
  context 'default column type' do
    it 'creates primary key as uuid column' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample
      end

      model_class = create_model

      expect(model_class).to have_uuid_column(:id)
    end

    it 'creates reference as uuid column' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample do |t|
          t.references :user
        end
      end

      model_class = create_model { has_many :users }

      expect(model_class).to have_uuid_column(:user_id)
    end

    it 'creates reference as uuid column (belongs_to)' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample do |t|
          t.belongs_to :user
        end
      end

      model_class = create_model { has_many :users }

      expect(model_class).to have_uuid_column(:user_id)
    end

    it 'creates reference as uuid (add_reference)' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample
        add_reference :sample, :user
      end

      model_class = create_model
      expect(model_class).to have_uuid_column(:user_id)
    end
  end

  context 'with column type specified' do
    it 'creates primary key as integer column' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample, id: :primary_key
      end

      model_class = create_model

      expect(model_class).to have_integer_column(:id)
    end

    it 'creates reference as integer column' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample do |t|
          t.references :user, type: :integer
        end
      end

      model_class = create_model { has_many :users }

      expect(model_class).to have_integer_column(:user_id)
    end

    it 'creates reference as integer column (belongs_to)' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample do |t|
          t.belongs_to :user, type: :integer
        end
      end

      model_class = create_model { has_many :users }

      expect(model_class).to have_integer_column(:user_id)
    end

    it 'creates reference as integer column (add_reference)' do
      schema do
        drop_table :sample if table_exists?(:sample)
        create_table :sample
        add_reference :sample, :user, type: :integer
      end

      model_class = create_model
      expect(model_class).to have_integer_column(:user_id)
    end
  end
end
