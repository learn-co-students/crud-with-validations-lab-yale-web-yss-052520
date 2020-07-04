class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: {scope: %i[release_year artist_name]}
    
    validates :released, inclusion: {in: %w(true false)}

    validates :artist_name, presence: true

    # validates :release_year, presence: true, if: :released?
    # validates :release_year, numericality: { less_than_and_equal_to: Date.today.year }, if: :released?


    def released?
        released
    end

    with_options if: :released? do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
          less_than_or_equal_to: Date.today.year
        }
    end

    
end
