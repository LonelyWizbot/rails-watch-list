class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmarks_params)
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark.movie = @movie
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    redirect_to list_path(@list), status: :see_other
  end

  private

  def bookmarks_params
    params.require(:bookmark).permit(:comment)
  end

end
