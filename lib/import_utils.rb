require 'csv_utils'

module ImportUtils

  def self.import(klass, file, unique_keys=[:email])
    entries = CSVUtils.csv_to_tuple(file)

    people = Person.all

    to_save = []
    entries.map do |entry|
      unique_fields = {}
      unique_keys.each do |key|
        unique_fields[key] = entry[key.to_s]
      end
      if person = people.find_by(unique_fields)
        entry.each do |key, val|
          person.protected_update(key, val)
        end
        to_save << person
      else
        to_save << Person.new(entry)
      end
    end
    klass.transaction do
      to_save.map(&:save!)
    end
  end

end