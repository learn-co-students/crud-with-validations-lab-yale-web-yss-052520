require 'date'
# Super helpful documentation: https://guides.rubyonrails.org/active_record_validations.html
class Song < ApplicationRecord
    validates :title, presence: true 
    validates :released, inclusion: {in: [true, false]}
    validates :artist_name, presence: true 
    validates :genre, presence: true 
    
    # Put multiple conditions in a with_options block
    # :released? is method that returns a boolean value
    with_options if: :released? do |song|
        song.validates :release_year, presence: true 
        song.validates :release_year, numericality: {less_than: Date.today.year}
    end 



    validate :is_valid_title? 

    #https://stackoverflow.com/questions/5584327/how-can-i-combine-multiple-rails-validations-for-the-same-if-condition
    # with options :released? do |song|
    #     song.validates :release_year, presence:true
    #     song.validates 

    def released? 
        self.released 
    end

    def is_valid_title?
        if Song.all.select {|song| song.artist_name == self.artist_name }.select {|song| song.release_year == self.release_year}.select {|song| song.title == self.title}.count > 0 
            errors.add(:title, "not a valid title")
        end 
    end 

end
