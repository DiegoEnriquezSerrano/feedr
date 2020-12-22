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
        render json: @customer_addresses.as_json, status: :created
      end
    else
      render json: { errors: 'Must be logged in' }, status: :unauthorized
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
        render json: @customer_addresses.as_json, status: :ok
      end
    else
      render json: { errors: 'Must be logged in' }, status: :unauthorized
    end
  end

  def update_default
    if !authenticate_user.nil?
      @customer_address = CustomerAddress.find(params[:id])
      @customer_address.update_default_address
      render json: @customer_address.as_json, status: :ok
    else
      render json: { errors: 'Must be logged in' }, status: :unauthorized
    end
  end

  def destroy
    if !authenticate_user.nil?
      @customer_address = CustomerAddress.find(params[:id])
      @customer_address.destroy!
      @customer_addresses = CustomerAddress.where(user: @user)
      render json: @customer_addresses.as_json, status: :ok
    end
  end

  private
    def customer_address_params
      params.required(:customer_address).permit(:address, :name)
    end
end
