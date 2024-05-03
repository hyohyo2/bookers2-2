class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

    if @range == "user"
      @records = User.search_for(@search, @word)
    else
      @records = Book.search_for(@search,@word)
    end
  end
end
