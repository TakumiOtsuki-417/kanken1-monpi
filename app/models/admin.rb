class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

         attr_accessor :code1, :code2, :code3, :code4
  # バリデーション
  with_options presence: true do
    validates :email
    validates :password
    validates :nickname
    validates :code1
    validates :code2
    validates :code3
    validates :code4
  end
  validate :add_errors


  def add_errors
    correct_codes = [ENV['MONPI_ADMIN_AUTH_CODE1'], ENV['MONPI_ADMIN_AUTH_CODE2'], ENV['MONPI_ADMIN_AUTH_CODE3'], ENV['MONPI_ADMIN_AUTH_CODE4']]
    collect_flag = true
    codes = [code1, code2, code3, code4]
    4.times do |i|
      if correct_codes[i] != codes[i]
        collect_flag = false
      end
    end
    if !collect_flag
      errors[:base] << "One of the four codes is wrong." 
    end
  end
end
