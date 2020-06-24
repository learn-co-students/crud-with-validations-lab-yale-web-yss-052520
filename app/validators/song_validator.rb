class SongValidator < ActiveModel::Validator
    def validate(record)
        songs_array = Song.all.select{ |song| song.title == record.title }
        if record.released
            if !record.release_year
                record.errors[:release_year]  << "Must not be blank if song has been released"
            elsif record.release_year >= Time.now.year
                record.errors[:release_year]  << "Must not be greater than current year"
            elsif songs_array.find{ |song| song.release_year == record.release_year}
                record.errors[:release_year]  << "Artist cannot release the same song twice in a single year"
            end
        end
    end
end