class ItemsController < ApplicationController

  before_filter :set_key, only: [:edit, :update, :create, :destroy]

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
        if params[:item][:description].blank?
          params[:item][:description] = "Search Results"
        end
        @item = ItemRequest.create(params[:item])
        if @item.success?
          flash[:notice] = "Successfully saved idea!"
          redirect_to wedding_path(@wedding.id)
        else
          @items = ItemRequest.find_all_by_wedding(@wedding.id)
          flash[:error] = "Unable to save this idea."
          redirect_to :back
        end
      else
        @items = ItemRequest.find_all_by_wedding(@wedding.id)
        flash[:error] = "You are not authorized to save ideas to this wedding."
        redirect_to :back
      end
    else
      flash[:error] = "Please login to save ideas."
      redirect_to root_path # This is repeated, put it in a before filter and call it on certain actions
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
          flash[:notice] = "Successfully updated idea!"
          redirect_to wedding_path(@wedding_id)
        else
          flash[:error] = "Couldn't update this idea."
          redirect_to wedding_path(@wedding_id)
        end
      else
        @items = ItemRequest.find_all_by_wedding(@wedding.id)
        flash[:error] = "You are not authorized to save ideas to this wedding."
        redirect_to weddings_path(current_user.id)
      end
    else
      flash[:error] = "Please login to save ideas."
      redirect_to root_path # This is repeated, put it in a before filter and call it on certain actions
    end
  end

  def destroy
    if current_user
      @item = ItemRequest.find(params[:id])
      @wedding = WeddingRequest.find(@item.wedding_id)
      if @wedding.user_id == current_user.id
        @item = ItemRequest.destroy(params[:id])
        if @item.success?
          flash[:notice] = "Successfully deleted idea."
          redirect_to wedding_path(@wedding.id)
        else
          flash[:notice] = "Couldn't delete this wedding item."
          redirect_to wedding_path(@wedding.id)
        end
      else
        @items = ItemRequest.find_all_by_wedding(@wedding.id)
        flash[:error] = "You are not authorized to delete ideas for this wedding."
        redirect_to weddings_path(current_user.id)
      end
    else
      flash[:error] = "Please login to delete ideas."
      redirect_to root_path # This is repeated, put it in a before filter and call it on certain actions
    end
  end
end