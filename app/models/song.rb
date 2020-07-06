class Song < ApplicationRecord

    validates :title, presence: true
    validates :title, uniqueness: {scope: [:artist_name, :release_year]}
    validates :released, inclusion: {in: [true, false]}
    validates :artist_name, presence: true
    validate :correct_year

     def correct_year
            if(released  && !release_year)
                errors.add(:release_year, "Can't be blank") 
            end
            if(release_year  && release_year > Time.now.year)
                errors.add(:release_year, "Too late") 
            end
     end

end
