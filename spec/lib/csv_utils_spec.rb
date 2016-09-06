require 'rails_helper'
require 'csv_utils'

RSpec.describe CSVUtils, :type => :helper do
  describe "csv_to_tuple" do
    let(:csv_file) { File.open("spec/fixtures/people.csv") }
    let(:parsed_csv) { CSV.read("spec/fixtures/people.csv").to_a }
    let(:entries_number) { parsed_csv.size - 1 }
    subject { CSVUtils.csv_to_tuple(csv_file) }

    it "should return an array" do
      expect(subject).to be_a(Array)
    end

    it "should return an array with the appropriate number of entries" do
      expect(subject.size).to eq(entries_number)
    end

    it "should return an array of hashes" do
      expect(subject.map(&:class).uniq).to match_array([Hash])
    end

    it "should return an array of hashes with appropriate keys" do
      expect(subject.map(&:keys).uniq.first).to match_array(parsed_csv[0])
    end

    it "should return an array of hashes with appropriate values" do
      expect(subject.map(&:values)).to match_array(parsed_csv[1..-1])
    end
  end
end