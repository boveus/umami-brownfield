class VendorsController < ApplicationController
  def index
    @vendors = Vendor.online
  end
  
  def show
    @vendor = Vendor.find(params[:id])
  end
  
  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update(vendor_params)
    redirect_back(fallback_location: root_path)
  end
  
  private
  
    def vendor_params
      params.permit(:status, :id)
    end
end
