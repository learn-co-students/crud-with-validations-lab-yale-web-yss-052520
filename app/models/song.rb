class Song < ActiveRecord::Base
    
    validates :title, presence: true
    validates :title, uniqueness: {
        scope: [:artist_name, :release_year]
    }
    
    validates :released, inclusion: { in: [true, false]}
    validates :artist_name, presence: true


    # validate :released?

    # def released?
    #     if released
    #         if release_year.nil?
    #             errors.add(:release_year, "can't be nill")
    #         end
    #         song.validates :release_year, numericality: {
    #             less_than_or_equal_to: Date.today.year 
    #         }
    #     else
    #         if !release_year.nil?
    #             errors.add(:release_year, "not released")
    #         end
    #     end
    # end

    with_options if: :released do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
          less_than_or_equal_to: Date.today.year
        }
    end

end
