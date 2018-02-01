# frozen_string_literal: true
require 'rails_helper'

describe Medspace::Importer do
  let(:msi) { described_class.new(input_file, data_path) }
  let(:input_file) { file_fixture('sample_medspace_data.xml') }
  let(:data_path) { Rails.root.join('spec', 'fixtures', 'files') }

  context 'processing an export file' do
    it 'can instantiate' do
      expect(msi).to be_instance_of(described_class)
    end
    it 'has a Nokogiri DOM document' do
      expect(msi.doc).to be_instance_of(Nokogiri::XML::Document)
    end
    it 'knows how many documents are in the import file' do
      expect(msi.document_count).to eq(1)
    end
    it 'knows which input file it will import' do
      expect(msi.input_file).to eq input_file
    end
    it 'can determine the collection title' do
      expect(msi.collection_name).to eq(['Foundations of Excellence'])
    end
  end

  context 'processing a single record' do
    before do
      ActiveFedora::Cleaner.clean!
      @record = msi.records.first
    end

    it 'creates a Fedora record from a Medspace object' do
      work = msi.process_record(@record)
      expect(work).to be_instance_of(Image)
    end
  end
end
