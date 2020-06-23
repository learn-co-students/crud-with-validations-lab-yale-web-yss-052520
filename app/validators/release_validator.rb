class ReleaseValidator < ActiveModel::Validator
    def validate(record)
        return if !record.released
        if !record.release_year.present?
            record.errors[:release_year] << "Must include a release year." 
        else 
            validate_date(record)
        end
    end

    private

    def validate_date(record)
        year = DateTime.new(record.release_year.to_i)
        record.errors[:release_year] << "Can't release in the future" if year.future?
    end
end