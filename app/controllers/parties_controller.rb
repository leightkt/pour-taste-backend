class PartiesController < ApplicationController
    before_action :find_party, only: [:show, :update, :destroy, :partydeets, :user_partydeets]

    def index
        @parties = Party.all
        render json: @parties
    end

    def show
        render json: PartySerializer.new(@party, @user_id).results_to_serialized_json
    end

    def partydeets
        @user_id = params[:user_id]
        render json: PartySerializer.new(@party, @user_id).to_serialized_json
    end

    def user_partydeets
        @user_id = params[:user_id]
        get_host_tastings
        render json: PartySerializer.new(@party, @user_id).to_serialized_json
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
                party_open: true
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
        params.require(:party).permit(:date, :location, :time, :user_id, :party_open)
    end

    def get_host_tastings
        @host = User.find(@party.invitations.find{|invite| invite.host == true}.user_id)
        @host_tastings = @host.tastings.select{|tasting| tasting.party_id == @party.id}
        create_user_tastings
    end

    def create_user_tastings
        @host_tastings.map do |tasting|
            if (tasting_exist(tasting).empty?)
                Tasting.create({
                    user_id: @user_id,
                    party_id: @party.id,
                    wine_id: tasting.wine_id,
                    letter: tasting.letter
                })
            end
        end
    end

    def tasting_exist tasting
        @tasting = Tasting.where({
            user_id: @user_id,
            party_id: @party.id,
            wine_id: tasting.wine_id,
        })
    end



end
