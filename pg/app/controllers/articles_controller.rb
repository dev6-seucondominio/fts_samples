class ArticlesController < ApplicationController
  def index
    @articles = Article.buscar(params[:q])
                       .paginate(page: params[:page], per_page: 2)
                       .order('name asc')
  end
end
