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
        @user = User.find(params[:party][:user_id])
        @invites = @user.invitations
        @party = @invites.select do |invite|
                    invite.party.date == params[:party][:date]
                end
        if @party.any? 
            render json: {errors: "You already have a party on that date"}, status: :unprocessable_entity
        else 
            @party = Party.new(
                date: params[:party][:date],
                location: params[:party][:location],
                time: params[:party][:time],
            )
            if @party.valid?
                @party.save
                redirect_to :controller => 'invitations', :action => 'createInvite', :user_id => @user.id, :party_id => @party.id
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
