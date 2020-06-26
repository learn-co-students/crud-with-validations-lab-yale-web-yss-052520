class Song < ApplicationRecord
  validates :title, presence: true
    #cannot be repeated by the same artist in the same year

  validates :release_year, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: Time.current.year }, presence: true, if: :released

  validates :artist_name, presence: true

  validate :no_duplicate_songs




  def artist_and_title
    self.artist_name + " - " + self.title
  end

  def no_duplicate_songs
    unless Song.where(artist_name: self.artist_name, release_year: self.release_year, title: self.title).empty?
      errors.add(:release_year, "#{self.release_year} can't have another song with the name #{self.title} for the artist #{self.artist_name}")
    end
  end

end
