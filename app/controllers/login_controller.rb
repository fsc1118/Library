require 'bcrypt'

class LoginController < ApplicationController
    def index
    end

    def login
        # Find form input on post request
        username = params[:username]
        password = params[:password]
        if password.length == 0
            flash[:error] = "Invalid username or password"
            redirect_to "/login"
            return
        end
        user = User.find_by(username: username)
        if user && BCrypt::Password.new(user.password) == password
            token = user.token
            cookies[:token] = token
            cookies[:username] = username
            redirect_to "/"
        else
            flash[:error] = "Invalid username or password"
            redirect_to "/login"
        end
    end
end
