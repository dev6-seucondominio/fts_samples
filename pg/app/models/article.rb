class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  scope :buscar, lambda { |q|
    scope = all
    if q.present?
      scope = scope.joins(:author).where("
        authors.name LIKE :q OR articles.name LIKE :q OR articles.content LIKE :q",
        q: "%#{q}%")
    end
    scope
  }
end
