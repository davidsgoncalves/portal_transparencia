# == Schema Information
#
# Table name: matches
#
#  id   :integer          not null, primary key
#  date :date
#

class Match < ActiveRecord::Base
  validates_presence_of :date
  validates_uniqueness_of :date

  has_many :payments

  def get_all_fridays(month, next_year)
    year = Date.today.year

    year = Date.today.year + 1 if next_year != '0'

    first_day = Date.new(year, month.to_i)
    last_day = (first_day + 1.months) - 1.days

    (first_day..last_day).group_by(&:wday)[5]
  end

  def create_months_matches(month, next_year)
    dates = get_all_fridays(month, next_year)

    dates.each do |date|
      Match.create date: date
    end
  end
end
