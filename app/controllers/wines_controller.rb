class WinesController < ApplicationController
    before_action :find_wine, only: [:show, :update, :destroy]

    def index
        @wines = Wine.all
        render json: @wines
    end

    def show
        render json: @wine
    end

    def create
        @user_id = params[:wine][:user_id]
        @party_id = params[:wine][:party_id]
        @wine = Wine.where({
            name: params[:wine][:name],
            brand: params[:wine][:brand],
            variety: params[:wine][:variety],
            year: params[:wine][:year],
            wine_type: params[:wine][:wine_type]
            })
        if @wine.any?
            redirect_to :controller => 'tastings', :action => 'addTasting', :user_id => @user_id, :wine_id => @wine[0].id, :party_id => @party_id
        else 
            @wine = Wine.new({
                name: params[:wine][:name],
                brand: params[:wine][:brand],
                variety: params[:wine][:variety],
                year: params[:wine][:year],
                wine_type: params[:wine][:wine_type]
            })
            if @wine.valid?
                @wine.save
                redirect_to :controller => 'tastings', 
                :action => 'addTasting', 
                :user_id => @user_id, 
                :wine_id => @wine.id, 
                :party_id => @party_id
            else
                render json: {errors: @wine.errors.full_messages}, status: :unprocessable_entity
            end
        end
    end

    def update
        if @wine.update(wine_params)
            render json: @wine
        else
            render json: {errors: @wine.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @wine.destroy
        render json: {message: "wine #{@wine.id} destroyed"}
    end

    private

    def find_wine
        @wine = Wine.find(params[:id])
    end

    def wine_params
        params.require(:wine).permit(:brand, :variety, :name, :year, :wine_type, :user_id, :party_id)
    end
end
