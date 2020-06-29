class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: { scope: [:release_year, :artist_name] }
    validates :released, inclusion: { in: [true, false] }
    validate :release_year_validations
    validates :artist_name, presence: true

    def release_year_validations
        if released && !release_year
            errors.add(:release_year, "cannot be blank if released")
        end
        if release_year && release_year > Time.now.year
            errors.add(:release_year, "cannot be in the future")
        end
    end
end
