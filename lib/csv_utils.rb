require 'csv'

module CSVUtils

  def self.csv_to_tuple(file)
    csv_array = CSV.new(file, headers:true)
    csv_array.to_a.map &:to_hash
  end

end
