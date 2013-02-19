class Contact < ActiveRecord::Base

  # We need to add '_attributes' to be accessible so it can be set on the forms
  attr_accessible :dob, :first_name, :last_name, :emails, :emails_attributes, :addresses, :addresses_attributes, :_delete, :_destroy

  has_many :emails, :dependent => :destroy
  has_many :addresses, :dependent => :destroy

  accepts_nested_attributes_for :emails,    :allow_destroy => true, :reject_if => proc { |attributes| attributes['address'].blank? }
  accepts_nested_attributes_for :addresses, :allow_destroy => true, :reject_if => proc { |attributes| attributes['street_1'].blank? }

  validates :last_name, :presence => true
  validates :first_name, :presence => true

  validates_associated :emails, :addresses


end
