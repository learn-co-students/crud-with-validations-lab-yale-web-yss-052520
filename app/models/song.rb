class Song < ApplicationRecord
    validates :title, presence: true
    validates :released, inclusion: { in: [true, false] }
    validates :artist_name, presence: true
    validate :release_year?
    validate :song_repeat?

    def release_year?
        unless self.released == false 
            if self.release_year == nil 
                errors.add(:release_year, "Can't be empty!")
            elsif self.release_year > Date.today.year 
                errors.add(:release_year, "Can't be after the present!")
            end 
        end 
    end

    def song_repeat?
        song = Song.find_by(title: self.title)
        if !self.released or song == nil
            return
        elsif song.release_year == self.release_year and song.id != self.id
            errors.add(:release_year, "Can't release the same song again!")
        end
    end

end