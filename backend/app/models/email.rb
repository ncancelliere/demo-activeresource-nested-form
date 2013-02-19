class Email < ActiveRecord::Base
  attr_accessible :address, :contact_id, :contact

  belongs_to :contact

  validates :address, :presence => true

end
