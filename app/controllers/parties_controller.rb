class PartiesController < ApplicationController
    before_action :find_party, only: [:show, :update, :destroy]

    def index
        @parties = Party.all
        render json: @parties
    end

    def show
        render json: @party
    end

    def create
        @party = Party.where({ user_id: params[:party][:user_id].to_i, date: params[:party][:date]})
        if @party.any? 
            render json: {errors: "You already have a party on that date"}, status: :unprocessable_entityexit
        else 
            @party = Party.new(party_params)
            if @party.valid?
                @party.save
                render json: @party
            else
                render json: {errors: @party.errors.full_messages}, status: :unprocessable_entity
            end
        end
    end

    def update
        if @party.update(party_params)
            render json: @party
        else
            render json: {errors: @party.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @party.destroy
        render json: {message: "party on #{@party.date} destroyed"}
    end

    private

    def find_party
        @party = Party.find(params[:id])
    end

    def party_params
        params.require(:party).permit(:date, :location, :time, :user_id)
    end

end
