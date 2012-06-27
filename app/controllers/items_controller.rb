class ItemsController < ApplicationController
  def create
    @wedding = WeddingRequest.find(params[:wedding_id])
    if @wedding.user_id == current_user.id
      params[:item][:wedding_id] = @wedding.id
      @item = ItemRequest.create(params[:item])
      if @item.success?
        redirect_to user_wedding_path(current_user.id, @wedding.id), notice: "Successfully created item!"
      else
        @items = ItemRequest.find_all_by_wedding(@wedding.id)
        render "/weddings/show"
      end
    else
      render "/weddings/show", notice: "no"
    end
  end
end