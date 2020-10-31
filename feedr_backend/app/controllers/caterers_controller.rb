class CaterersController < ApplicationController
  def index
    @caterers = User.where(caterer_user: true)
    render json: @caterers.as_json(only: [
      :id,
      :caterer_business_name,
      :caterer_business_cover_image,
      :caterer_business_address,
      :caterer_business_city,
      :caterer_business_state,
      :zip_code
    ])
  end

  def show
    if User.where(caterer_user: true).where(id: params[:id]).exists?
      @caterer = User.find(params[:id])
      render json: @caterer.as_json(
        include: { meals: { except: [
          :created_at,
          :updated_at,
          :user_id
        ]}},
        except: [
          :email,
          :first_name,
          :last_name,
          :created_at,
          :updated_at
        ])
    else
      head(:not_found)
    end
  end

  def search
    if !authenticate_user.nil?
      @user = User.find(authenticate_user[0]['user_id'])
      render json: { user: @user.as_json(only: [:id, :first_name, :caterer_user]) }
    else
      render json: { error: 'Unauthorized request' }, status: :unauthorized
    end
  end
end
