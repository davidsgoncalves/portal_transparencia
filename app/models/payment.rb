# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ActiveRecord::Base
  validates_presence_of :player_id, :match_id

  belongs_to :match
  belongs_to :player
end
