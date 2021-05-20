class Store < ApplicationRecord
    belongs_to :user
    has_many :products
    validates :name, presence: true
    after_create do
        self.user.seller_role = true  #after creating store go and make this assign user seller4
        self.user.save
    end
end