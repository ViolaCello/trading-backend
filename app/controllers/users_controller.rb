class UsersController < ApplicationController

    def index
        @users = User.all
        render json:  @users 
    end
    
    def new
        @user = User.new
    end
    
    def create
       @user = User.create(user_params)
       if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
      else 
        render :new
      end
    end
        
    def show
         @user = User.find_by(id: params[:id])
         redirect_to '/' if @user == nil
    end
    
    def edit
        if logged_in?
            @user = current_user
           user_ok?(@user) 
        else
            redirect_to '/login'
        end 
    end 
    
    def update
        if logged_in?
            @user = current_user
            user_ok?(@user)
            @user.update(user_params)
            redirect_to user_path(@user)
        else  
            redirect_to '/'
        end
    end
    
    
    private
    
    def user_params
        params.require(:user).permit(:name, :password, :company, :email)
    end
end
