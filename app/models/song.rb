class Song < ApplicationRecord
    validates :title, presence: true 
    validates :released, inclusion: {in: [true, false]}
    validates :artist_name, presence: true 
    validate :is_year_correct?
    validate :repeat_song? 

    def is_year_correct?
        unless self.released == false 
            if self.release_year == nil 
                errors.add(:release_year, "Can't be blank!")
            elsif self.release_year > Time.now.year 
                errors.add(:release_year, "Can't be in the future!")
            end 
        end 
    end 

    def repeat_song? 
        unless self.released == false 
            same_year_songs = Song.all.select{|song| song.artist_name == self.artist_name && song.release_year == self.release_year}
            same_year_songs.each do |song| 
                if song.title == self.title && song.id != self.id  
                    errors.add(:title, "You can't release the same song twice!")
                end 
            end 
        end 
    end 
end
