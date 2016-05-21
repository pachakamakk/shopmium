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

def find
  @distance = 0.5
  @limit = 10
  if (params.has_key?(:dist))
    @distance = params[:dist].to_f
    if (@distance < 0)
      @distance = 0.5
    end
  end
  if (params.has_key?(:limit))
    @limit = params[:limit].to_f
    if (@limit < 1)
      @limit = 10
    end
  end
  @userCoord = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
  @coord = Array.new
  @shops = Array.new
  if (@userCoord.success == false)
    puts("Couldn't get IP, choosing default (Paris)")
    @coord = [48.856614, 2.352222];
  else
    @coord = [@userCoord.lat, @userCoord.lng]
  end
  Shop.all.each do |shop|
    if shop.distance_to(@coord, :units => :kms) <= @distance
      @shops << shop
      if (@shops.size == @limit)
        break
      end
    end
  end
end

def index
  @shops = Shop.all
end

def show
  @shop = Shop.find(params[:id])
end


private
  def shop_params
   params.require(:shop).permit(:name, :chain, :latitude, :longitude, :address, :city, :zip, :phone, :country_code)
  end

end
