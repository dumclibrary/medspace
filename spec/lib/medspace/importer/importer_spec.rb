# frozen_string_literal: true
require 'rails_helper'

describe Medspace::Importer do
  let(:msi) { described_class.new(input_file, data_path) }
  let(:input_file) { file_fixture('sample_medspace_data.xml') }
  let(:data_path) { Rails.root.join('spec', 'fixtures', 'files') }
  let(:msi_invalid) { described_class.new(input_file_with_no_title, data_path) }
  let(:input_file_with_no_title) { file_fixture('invalid_medspace_data.xml') }

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
    end
    let(:record) { msi.records.first }
    let(:work) { msi.process_record(record) }

    it 'does not create a Fedora object if one already exists with same identifier' do
      msi.import
      msi.import

      number_of_works = Image.where(identifier: Image.last.identifier).count

      expect(number_of_works).to eq 1
    end

    it 'creates a Fedora record from a Medspace object' do
      expect(work).to be_instance_of(Image)
    end

    it 'sets the Fedora object\'s visibility to open' do
      expect(work.visibility).to eq('open')
    end

    it 'adds the object to the collection' do
      msi.import

      expect(msi.collection.members.last.id).to eq(Image.last.id)
    end

    it 'sets all subject elements' do
      expect(work.subject).to eq(["Technology", "Duke University. School of Medicine", "Duke University. Hospital", "Medicine -- Study and teaching -- North Carolina", "Education, Medical"])
    end

    it 'sets the date created' do
      expect(work.date_created).to eq(['1934'])
    end

    it "sets the date" do
      expect(work.date).to eq(['1934'])
    end

    it "sets the identifier" do
      expect(work.identifier).to eq(['edc00014'])
    end

    it "sets the holding_entity" do
      expect(work.holding_entity).to eq(['Medical Center Archives'])
    end

    it "sets the archival_collection" do
      expect(work.archival_collection).to eq(["Photograph & Negative Collection"])
    end

    it "sets the resource_type" do
      expect(work.resource_type).to eq(['Image'])
    end

    context 'with complete metadata' do
      let(:input_file) { file_fixture('complete_medspace_data.xml') }

      it 'sets the contributor' do
        expect(work.contributor).to eq(['Jonas Salk'])
      end

      it 'sets the creator' do
        expect(work.creator).to eq(['Agnodice'])
      end

      it 'sets the date_accepted' do
        expect(work.date_accepted).to eq(['1955'])
      end

      it 'sets the condition' do
        expect(work.condition).to eq(['Excellent'])
      end

      it 'sets the accrual method' do
        expect(work.accrual_method).to eq(['Acquisition'])
      end

      it 'sets the provenance' do
        expect(work.provenance).to eq(['France'])
      end

      it 'sets based_near' do
        expect(work.based_near).to eq(['Italy'])
      end
    end
  end

  context 'processing multiple records' do
    before do
      ActiveFedora::Cleaner.clean!
      AdminSet.find_or_create_default_admin_set_id
    end

    describe 'import' do
      it 'has a completed message' do
        expect { msi.import }.to output(/Exhibit Room B, postgraduate course on fractures/).to_stdout_from_any_process
      end

      it 'has an error message when something goes wrong during the import' do
        expect { msi_invalid.import }.to raise_error('XML is invalid')
      end
    end
  end
end
