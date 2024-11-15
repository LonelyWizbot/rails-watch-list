class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id]) # Find the specific list
    @bookmarks = Bookmark.where(list: @list).index_by(&:movie_id) # Preload bookmarks for efficiency
    @bookmark = Bookmark.new(list: @list) # Create a new bookmark associated with the current list
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list), notice: 'List created successfully.'
    else
      render :new, alert: 'Error creating list.'
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
