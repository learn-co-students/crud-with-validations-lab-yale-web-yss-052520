class Song < ApplicationRecord
    include ActiveModel::Validations
    validates :title, presence: true
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, numericality: { only_integer: true }, if: :released
    validates_with SongValidator
end
