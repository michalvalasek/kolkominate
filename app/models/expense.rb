class Expense < ActiveRecord::Base
	validates :value, :date, :presence => true
	validates :value, :numericality => { greater_than_or_equal_to: 0.01 }
	validates :description, :length => { maximum: 500 }

	attr_accessible :value, :date, :description

	belongs_to :user
	belongs_to :currency

	attr_taggable :categories

	def value=(value)
		write_attribute(:value,value.sub(",","."))
	end

	def self.date_between(from,to)
		from = '01.01.2012' if from.blank?
		to = Time.now.strftime("%d.%m.%Y") if to.blank?
		where(date: (from.to_date..to.to_date))
	end
end
