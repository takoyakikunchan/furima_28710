class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true

  validates :password, { presence: true, confirmation: true, length: { minimum: 6 } }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX
  NAME_REGEX =  /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  with_options presence: true, format: { with: NAME_REGEX  } do
    validates :given_name
    validates :family_name
  end
  KATAKANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/.freeze
  with_options presence: true, format: { with: KATAKANA_REGEX } do
    validates :read_fam_name
    validates :read_given_name
  end

  validates :birthday, presence: true
end
