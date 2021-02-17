class TastingsController < ApplicationController
    before_action :find_tasting, only: [:show, :update, :destroy]

    def index
        @tastings = Tasting.all
        render json: @tastings
    end

    def show
        render json: @tasting
    end

    def addTasting
        @tasting = Tasting.new({
            user_id: params[:user_id].to_i,
            wine_id: params[:wine_id].to_i,
            party_id: params[:party_id].to_i,
            letter: assign_letter
        })
        if @tasting.valid?
            @tasting.save
            render json: @tasting, include: :wine
        else
            render json: {errors: @tasting.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def create
        @referenceTasting = Tasting.where({
            user_id: parma[:tasting][:host_id],
            party_id: parma[:tasting][:party_id],
            wine_id: parma[:tasting][:wine_id],
        })
        letter = @referenceTasting.letter
        @tasting = Tasting.new(tasting_params, {letter: letter})
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
        params.require(:tasting).permit(:user_id, :wine_id, :party_id, :notes, :rating, :letter, :host_id)
    end

    def assign_letter
        ord_ref = Party.find(params[:party_id]).tastings.length + 65
        ord_ref.chr
    end
end
