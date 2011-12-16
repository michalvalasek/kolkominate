class Expense < ActiveRecord::Base
	validates :value, :date, :presence => true
	validates :value, :numericality => { greater_than_or_equal_to: 0.01 }
	validates :description, :length => { maximum: 500 }

	attr_accessible :value, :date, :description

	belongs_to :user
	belongs_to :currency
end
