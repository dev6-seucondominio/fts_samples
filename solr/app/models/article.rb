class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  scope :buscar, lambda { |q|
    scope = all
    scope
  }
end
