class TastingsController < ApplicationController
    before_action :find_tasting, only: [:show, :update, :destroy]

    def index
        @tastings = Tasting.all
        render json: @tastings
    end

    def show
        render json: @tasting
    end

    def create
        @tasting = Tasting.new(tasting_params)
        if @tasting.valid?
            @tasting.save
            render json: @tasting
        else
            render json: {errors: @tasting.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        if @tasting.update(tasting_params)
            render json: @tasting
        else
            render json: {errors: @tasting.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @tasting.destroy
        render json: {message: "tasting #{@tasting.id} destroyed"}
    end

    private

    def find_tasting
        @tasting = Tasting.find(params[:id])
    end

    def tasting_params
        params.require(:tasting).permit(:user_id, :wine_id, :party_id, :notes, :rating, :letter)
    end
end
