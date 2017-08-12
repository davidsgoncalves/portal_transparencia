# == Schema Information
#
# Table name: matches
#
#  id   :integer          not null, primary key
#  date :date
#

class Match < ActiveRecord::Base
  validates_presence_of :date

  has_many :payments
end
