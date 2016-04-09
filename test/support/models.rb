class User < ActiveRecord::Base
end

class Group < ActiveRecord::Base
  has_many :users
end
