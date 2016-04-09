require "test_helper"

class FindersTest < Minitest::Test
  test "returns records" do
    schema do
      drop_table :users if table_exists?(:users)
      create_table :users
    end

    records = 5.times.map { User.create! }

    assert_equal records.take(3), User.take(3)
  end
end
