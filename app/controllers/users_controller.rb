class UsersController < ApplicationController
    before_action :find_user, only: [:show, :destroy, :update]
    # skip_before_action :authorized, only: [:create, :login]

    def index
        @users = User.all
        render json: @users
    end

    def show
        my_parties
        my_tastings
        render json: UserSerializer.new(@user, @parties, @tastings).to_serialized_json
        # render json: @user, include: :parties
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            render json: @user
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        render json: {message: "user: #{@user.username} destroyed"}
    end

    def login
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            @token = JWT.encode({user_id: @user.id}, Rails.application.secrets.secret_key_base[0])
            render json: {user_id: @user.id, token: @token}
        else
            render json: {errors: "Invalid Credentials"}, status: :unauthorized
        end
    end
    
    def my_parties
        @parties = @user.parties.uniq {|party| party.id}
    end

    def my_tastings
        @tastings = @user.tastings
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :username, :password, :email)
    end
end
