class CustomerAddressesController < ApplicationController
  def create
    if !authenticate_user.nil?
      @user = User.find(authenticate_user[0]['user_id'])
      @customer_address = CustomerAddress.new(
        address: params[:address],
        user: @user,
        name: params[:name]
      )
      if @customer_address.save
        @customer_addresses = CustomerAddress.where(user: @user)
        render json: @customer_addresses.as_json
      else
        head(:unauthorized)
      end
    end
  end

  def update
    if !authenticate_user.nil?
      @user = User.find(authenticate_user[0]['user_id'])
      @customer_address = CustomerAddress.find(params[:id])
      @customer_address.name = params[:name]
      @customer_address.address = params[:address]
      if @customer_address.save
        @customer_addresses = CustomerAddress.where(user: @user)
        render json: @customer_addresses.as_json
      else
        head(:unauthorized)
      end
    end
  end

  private
    def customer_address_params
      params.required(:customer_address).permit(:address, :name)
    end
end
