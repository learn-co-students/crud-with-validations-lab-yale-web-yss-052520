class Song < ApplicationRecord
    include ActiveModel::Validations
    validates :title, presence: true
    validates :title, uniqueness: {
        scope: %i[release_year artist_name],
        message: 'cannot be repeated by the same artist in the same year'
      }
    validates :released, inclusion: {in: [true, false]}
    validates :artist_name, presence: true

    validates_with ReleaseValidator
end
