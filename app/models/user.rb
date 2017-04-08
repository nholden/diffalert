class User < ApplicationRecord

  has_many :triggers
  has_many :alerts, through: :triggers

end
