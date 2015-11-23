require 'spec_helper'

describe ActiveRecord::UUID, 'finders' do
  it 'returns records' do
    schema do
      drop_table :users if table_exists?(:users)
      create_table :users
    end

    records = 5.times.map { User.create! }

    expect(User.take(3)).to eq(records.take(3))
  end
end
