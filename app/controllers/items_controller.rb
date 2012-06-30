class ItemsController < ApplicationController

  def create
    # TODO Refactor to:

    # @response = ItemRequest.create(params[:item])
    # if @response.success?
    #   redirect_to wedding_path(@wedding.id), notice: "Successfully created item!"
    # else
    #   render "/weddings/show", notice: @response[:error]
    # end

    if current_user
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
    else redirect_to root_path # This is repeated, put it in a before filter and call it on certain actions
    end
  end

  def edit
    @item = ItemRequest.find(params[:id])
  end

  def update
    if current_user
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
    else redirect_to root_path # This is repeated, put it in a before filter and call it on certain actions
    end
  end

  def destroy
    if current_user
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
    else redirect_to root_path # This is repeated, put it in a before filter and call it on certain actions
    end
  end
end