class NewOrdersController < ApplicationController
  def show
    @order = current_order
    render json: @order.as_json(
      include: {
        order_meals: { include: {
          meal: { except: [
            :created_at,
            :updated_at,
            :user_id,
            :ingredients
          ]}
        }, except: [
          :created_at,
          :updated_at,
          :order_id,
          :meal_id
        ]},
        caterer: { except: [
          :created_at,
          :updated_at,
          :caterer_user,
          :email,
          :first_name,
          :last_name,
        ]}
      },
      except: [
        :created_at,
        :updated_at,
        :caterer_id,
        :abandoned,
        :abandoned_on,
        :submitted,
        :submitted_on,
        :accepted,
        :accepted_on
    ])
  end

  def create
    if !authenticate_user.nil?
      @order = current_order
      if !@order.order_meals.empty?
        @order.update(submitted: true, submitted_on: Time.now)
        render json: @order.as_json, status: :created
      end
    else
      render json: { error: 'Unauthorized request' }, status: :unauthorized
    end
  end
end
