class ItemsController < ApplicationController
  def create
    @wedding = WeddingRequest.find(params[:item][:wedding_id])
    if @wedding.user_id == current_user.id
      params[:item][:wedding_id] = @wedding.id
      @item = ItemRequest.create(params[:item])
      if @item.success?
        redirect_to wedding_path(@wedding.id), notice: "Successfully created item!"
      else
        @items = ItemRequest.find_all_by_wedding(@wedding.id)
        render "/weddings/show", notice: "Unable to save item."
      end
    else
      @items = ItemRequest.find_all_by_wedding(@wedding.id)
      render "/weddings/show", notice: "Unauthorized to create items for this wedding"
    end
  end

  def edit
    @item = ItemRequest.find(params[:id])
  end

  def update
    @wedding = WeddingRequest.find(params[:item][:wedding_id])
    if @wedding.user_id == current_user.id
      @item = ItemRequest.update(params[:id], params[:item])
      @wedding_id = params[:item][:wedding_id]
      if @item.success?
        redirect_to wedding_path(@wedding_id), notice: "Successfully updated item!"
      else
        redirect_to wedding_path(@wedding_id), notice: "Couldn't update"
      end
    else
      @items = ItemRequest.find_all_by_wedding(@wedding.id)
      render "/weddings/show", notice: "Unauthorized to create items for this wedding"
    end
  end

  def destroy
    @item = ItemRequest.find(params[:id])
    @wedding = WeddingRequest.find(@item.wedding_id)
    if @wedding.user_id == current_user.id
      @item = ItemRequest.destroy(params[:id])
      if @item.success?
        redirect_to wedding_path(@wedding.id), notice: "Successfully updated item!"
      else
        redirect_to wedding_path(@wedding.id), notice: "Couldn't delete this wedding item."
      end
    else
      @items = ItemRequest.find_all_by_wedding(@wedding.id)
      render "/weddings/show", notice: "Unauthorized to delete items for this wedding"
    end
  end
end