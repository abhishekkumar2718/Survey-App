class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.seed(count)
    count.times do
      User.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
    end
  end
end
