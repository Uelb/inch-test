require 'rails_helper'
require 'csv_utils'
require 'import_utils'

RSpec.describe ImportUtils, :type => :helper do
  describe "csv_to_tuple" do
    let(:csv_file) { File.open("spec/fixtures/people.csv") }
    let(:parsed_csv) { CSVUtils.csv_to_tuple(File.open("spec/fixtures/people.csv")) }
    let(:entries_number) { parsed_csv.size }
    subject { ImportUtils.import(Person, csv_file) }

    context "when the base is empty" do
      it 'should create the appropriate number of tuple' do
        expect{subject}.to change(Person, :count).by(entries_number)
      end
    end

    context "when the base is not empty" do
      let!(:already_created) { Person.create(parsed_csv[0]) }
      it 'should create the appropriate number of tuple' do
        expect{subject}.to change(Person, :count).by(entries_number - 1)
      end
    end
  end
end