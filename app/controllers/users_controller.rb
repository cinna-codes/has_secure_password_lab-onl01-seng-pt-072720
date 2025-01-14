class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def show
        if !session[:user_id].nil? && !session[:user_id].empty?
            @user = User.find_by(id: session[:user_id])
        else
            redirect_to login_path
        end
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to signup_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
