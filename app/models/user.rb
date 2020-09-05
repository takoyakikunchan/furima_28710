class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :nickname, presence: true

  validates :password, { presence: true, confirmation: true, length: { minimum: 6 } }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX
  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  with_options presence: true, format: { with: NAME_REGEX } do
    validates :given_name
    validates :family_name
  end
  KATAKANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/.freeze
  with_options presence: true, format: { with: KATAKANA_REGEX } do
    validates :read_fam_name
    validates :read_given_name
  end

  validates :birthday, presence: true
  has_many :items
  has_many :orders
  has_one :card, dependent: :destroy
  has_one :address
  has_many :comments
  has_one :profile
  has_many :sns_credentials
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
