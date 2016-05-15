class ShopsController < ApplicationController
def new
  @shop = Shop.new
end

def edit
  @shop = Shop.find(params[:id])
end

def create
  @shop = Shop.new(shop_params)

  if @shop.save
    redirect_to @shop
  else
    render 'new'
  end
end

def update
  @shop = Shop.find(params[:id])

  if (@shop.update(shop_params))
    redirect_to @shop
  else
    render 'edit'
  end
end

def destroy
  @shop = Shop.find(params[:id])

  @shop.destroy
  redirect_to shops_path
end

def index
  @shops = Shop.all
  puts(@shops)
end

def show
  @shop = Shop.find(params[:id])
end


private
  def shop_params
   params.require(:shop).permit(:name, :chain, :latitude, :longitude, :address, :city, :zip, :phone, :country_code)
  end

end
