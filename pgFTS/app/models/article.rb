class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  include PgSearch

  # multisearchable against: %i(name content)

  # pg_search_scope :pg_search, against: [:name]
  # pg_search_scope :pg_search, lambda { |q|
  #   {
  #     query: q,
  #     ignoring: :accents,
  #     against: %i(name content),
  #     associated_against: {
  #       author: :name,
  #       comments: [:name, :content]
  #     },
  #     using: {
  #       tsearch: {
  #         prefix: true,
  #         dictionary: 'english'
  #       }
  #     }
  #   }
  # }

  scope :buscar, lambda { |q|
    scope = all
    if q.present?
      # scope = scope.multisearch(q)
      # scope = scope.pg_search(q)
      scope = scope.where(
        "to_tsvector(articles.name) @@ to_tsquery(:q) OR content @@ to_tsquery(:q)",
        q: q
      )
    end
    scope
  }
end
