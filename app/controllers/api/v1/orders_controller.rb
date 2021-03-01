module Api
  module V1
    class OrdersController < ApplicationController
      def create
        
        # 仮注文されたfoodを全てposted_line_foodsに代入
        posted_line_foods = LineFood.where(id: params[:line_food_ids])

        # orderインスタンスを生成し、restaurant_idとtotal_pliceをそれぞれ代入
        order = Order.new(
          restaurant_id: posted_line_foods.first.restaurant_id,
          total_price: total_price(posted_line_foods),
        )

        # 仮注文を全てactiveじゃなくす
        if order.save_with_update_line_foods!(posted_line_foods)
          render json: {}, status: :no_content
        else
          render json: {}, status: :internal_server_error
        end
      end

      private

      def total_price(posted_line_foods)
        posted_line_foods.sum {|line_food| line_food.total_amount } + posted_line_foods.first.restaurant.fee
      end
    end
  end
end
