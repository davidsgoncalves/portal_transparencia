# == Schema Information
#
# Table name: payments
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  match_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :decimal(8, 2)
#  description :string
#

class Payment < ActiveRecord::Base
  belongs_to :match, optional: true
  belongs_to :player, optional: true

  with_options on: :create_credit do |v|
    v.validates_presence_of :description, :value
  end

  with_options on: :create_match_payment do |v|
    v.validates_presence_of :value, :match_id, :player_id
  end

  def self.pay_month(month_number, year, value, player)
    transaction do
      first_day = Date.new(year.to_i, month_number.to_i)
      last_day = (first_day + 1.months) - 1.days

      matches = (first_day..last_day).group_by(&:wday)[5]

      each_value = value.to_f / matches.count.to_f

      matches.each do |match|
        match_obj = Match.find_by_date(match)

        raise "some match may not exist!" unless match_obj

        payment = Payment.new match: match_obj, player: player, value: each_value, description: 'Mensal'
        payment.save!(context: :create_match_payment)
      end

      true
    end
  rescue
    false
  end

  def self.money_on_hand
    Payment.sum(:value)
  end
end
