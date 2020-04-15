class Merchant::ItemsController < Merchant::BaseController

  def new
    @merchant = Merchant.find(current_user.merchant_id)
    # @item = @merchant.items.new(item_params)
    @item = @merchant.items.new
    # @item = Item.new
    # binding.pry
  end
    
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if @item.save
      redirect_to "/merchant/items"
    else
      # flash[:error] = @item.errors.full_messages.to_sentence
      flash.now[:error] = @item.errors.full_messages.to_sentence
      # redirect_to "/merchant/items/new"
      render "/merchant/items/new"
    end
  end
  
  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def update
    item = Item.find(params[:id])
    item.update(active?: !item.active?)
    if item.active?
      flash[:success] = "'#{item.name}' has been marked active and is now for sale"
    else
      flash[:success] = "'#{item.name}' has been marked inactive and is no longer for sale"
    end
    redirect_to("/merchant/items")
  end

  def destroy
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:success] = "Item has been deleted!"

    redirect_to "/merchant/items"
  end

  private

  # def item_params
  #   params.permit(:name,:description,:price,:inventory,:image)
  # end

  def item_params
    params.require(:item).permit(:name,:description,:price,:inventory,:image)
  end

end