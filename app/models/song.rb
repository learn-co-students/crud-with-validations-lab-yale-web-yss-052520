class Song < ApplicationRecord
    validates :title, presence: true 
    validates :title, uniqueness: {
        scope: %i[release_year artist_name], message: 'cannot be repeated by the same artist in the same year'
    }
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, presence: true, if: :released
    validate :valid_year?, if: :release_year
    validates :artist_name, presence: true
    
    def valid_year?
        if release_year >= Time.now.strftime('%Y').to_i
            errors.add(:release_year, "can't be in the future")
        end
        # binding.pry
    end
end
