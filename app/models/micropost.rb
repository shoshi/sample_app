class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
end
