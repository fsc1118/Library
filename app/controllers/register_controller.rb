require 'securerandom'
require 'bcrypt'

class RegisterController < ApplicationController
    def index

    end

    def register
        username = params[:username]
        password = params[:password]
        user = User.find_by(username: username)
        if user
            flash[:error] = "Username already taken"
            redirect_to "/register"
            return
        end
        encrypted_password = BCrypt::Password.create(password)
        user = User.new(username: username, password: encrypted_password, token: SecureRandom.hex, isAdmin: false)
        user.save
        redirect_to "/login"
    end
end
