class Song < ApplicationRecord

    validates :title, presence: true
    
    validates :released, inclusion: { in: [true, false]}
    
    validates :artist_name, presence: true 
    validates :artist_name, uniqueness: { scope: :release_year}
    with_options if: :released? do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: { less_than_or_equal_to: Time.now.year}
    end  

    def released?
        self.released 
    end
end
