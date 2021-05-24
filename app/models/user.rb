class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates_presence_of :name # required
  has_many :orders
  has_one :store
  has_one :wishlist, dependent: :destroy
  has_one_attached :avatar  
  after_create :send_admin_mail, :create_wishlist

  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
  end

  def create_wishlist
    @wishlist = Wishlist.new
    @wishlist.user_id = self.id
    @wishlist.save
  end

end