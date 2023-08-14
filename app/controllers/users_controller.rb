class UsersController < ApplicationController
  #  GET /users/:id
  def show
    # @user = User.first
    @user = User.find(params[:id])

    # => app/views/users/show.html.erb
  end

  # GET /users/new or /signup
  def new
    # => app/views/users/new.html.erb
    @user = User.new
    # => app/views/users/new.html
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # => sucsess
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # => GET /user/:id
    else
      # => Failure
      render 'new', status: :unprocessable_entity
    end

    # render 'create'
  end

  private
    # Strong Parameters
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
