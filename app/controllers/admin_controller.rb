class AdminController < ApplicationController

    private def isUserAuthorized
        # Get credentials from cookies
        token = cookies[:token]
        if !token
            return false
        end
        username = cookies[:username]
        if !username
            return false
        end
        # Get user from database
        user = User.find_by(username: username)
        if !user
            return false
        end
        if user.token != token
            return false
        end
        if !user.isAdmin
            return false
        end
        return true
    end

    def index
        if !isUserAuthorized
            redirect_to "/403.html"
        else
            render "index"
        end
    end

    private def isISBN?(isbn)
        # Remove any dashes or spaces
        isbn = isbn.gsub(/[-\s]/, '')

        # ISBN-10 should have 10 digits
        return false unless isbn.match?(/^\d{10}$/)

        sum = 0
        10.times do |i|
            sum += isbn[i].to_i * (i + 1)
        end

        # Checksum should be divisible by 11
        sum % 11 == 0
    end

    def book
        if !isUserAuthorized
            redirect_to "/403.html"
        else
            render "book"
        end
    end

    def saveBook
        if !isUserAuthorized
            redirect_to "/403.html"
        else
            title = params[:title]
            author_last_name = params[:authorLastName]
            author_first_name = params[:authorFirstName]
            edition = params[:edition]
            isbn = params[:isbn]
            if title.blank? || isbn.blank?
                flash[:error] = "Title and ISBN are required"
                redirect_to "/admin/book"
                return
            end
            if !isISBN?(isbn)
                flash[:error] = "Invalid ISBN"
                redirect_to "/admin/book"
                return
            end
            isbnWithoutDashes = isbn.gsub(/[-\s]/, '')
            book = Book.new(book_name: title, 
                author_last_name: author_last_name,
                author_first_name: author_first_name,
                edition: edition,
                isbn:isbnWithoutDashes,
                isAvailable: true
            )
            book.save
            flash[:success] = "Book saved"
            redirect_to "/admin/book"
        end
    end
end
