require 'csv'

module CSVUtils

  def self.csv_to_tuple(file)
    csv_array = CSV.new(file, headers:true).to_a
    csv_array.to_a.map {|row| row.to_hash }
  end

end