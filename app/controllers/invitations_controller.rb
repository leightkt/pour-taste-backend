class InvitationsController < ApplicationController
    def create
        @invitation = Invitation.new(invitation_params)
        if @invitation.valid?
            @invitation.save
            render json: @invitation
        else
            render json: {errors: @invitation.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def createInvite
        @user_id = params["user_id"].to_i
        @party_id = params["party_id"].to_i
        @invitation = Invitation.create(
            user_id: @user_id,
            party_id: @party_id,
            host: true
        )
        render json: @invitation
    end

    private
    
    def invitation_params
        params.require(:invitation).permit(:user_id, :party_id, :host)
    end
end
