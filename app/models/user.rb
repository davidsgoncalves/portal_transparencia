# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates_presence_of :name, :password
end
