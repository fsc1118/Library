class SearchController < ApplicationController
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
    def index
        @search = params[:search]
        @type = params[:type]

        if @type == "ISBN"
            if !isISBN?(@search)
                flash[:error] = "Invalid ISBN"
                @books = [] 
                redirect_back(fallback_location: "/")
            else 
                @books = Book.where(isbn: @search.gsub(/[-\s]/, ''), isAvailable: true)
            end
        else
            @books = Book.where("book_name LIKE ? AND isAvailable = ?", "%#{@search}%", true)
        end
        
    end
end
