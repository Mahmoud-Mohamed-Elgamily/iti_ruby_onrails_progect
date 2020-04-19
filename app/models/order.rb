class Order < ApplicationRecord
    has_one_attached :image
    has_many:orderdetails
    belongs_to :user
    has_one :notification 
end
