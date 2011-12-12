# encoding: utf-8

class Tag < ActiveRecord::Base
	validates :name, :presence => true
	validates :name, :length => { :in => 1..50 }

	attr_accessible :name

	has_and_belongs_to_many :expenses

	before_destroy :not_referenced_by_any_expense

	private

		def not_referenced_by_any_expense
			if expenses.empty?
				return true
			else
				errors.add(:base, "Existujú výdaje s týmto tagom.")
			end
		end
end
