class Address < ActiveRecord::Base
  attr_accessible :city, :contact_id, :contact, :state, :street_1, :street_2, :zip

  belongs_to :contact

  validates :street_1, :presence => true
  validates :state, :length => { :is => 2 }
end
