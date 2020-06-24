require 'pry'
class Song < ApplicationRecord
    validates :title, presence: true
    validates :released, inclusion: { in: [true, false] }
    validates :artist_name, presence: true
    validate :release_year?
    validate :song_repeat?

    def release_year?
        if !self.released
            return
        elsif self.released and self.release_year == nil 
            errors.add(:release_year, "Can't be empty")
        elsif self.release_year > Date.today.year 
            errors.add(:release_year, "Can't be greater than current year")
        end
    end

    def song_repeat?
        s = Song.find_by(title: self.title)
        if !self.released or s == nil
            return
        elsif s.release_year == self.release_year and s.id != self.id
            errors.add(:release_year, "Can't release the same song in the same year")
        end
    end



end
