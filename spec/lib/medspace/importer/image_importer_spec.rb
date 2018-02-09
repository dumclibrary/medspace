# frozen_string_literal: true
require 'rails_helper'
describe Medspace::Importer do
  let(:msi) { described_class.new(input_file, data_path) }
  let(:input_file) { file_fixture('importer/image/sample_medspace_data.xml') }
  let(:data_path) { Rails.root.join('spec', 'fixtures', 'files', 'importer', 'image') }
  let(:collection) { msi.collection }
  let(:msi_invalid) { described_class.new(input_file_with_no_title, data_path) }
  let(:input_file_with_no_title) { file_fixture('importer/image/invalid_medspace_data.xml') }

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
      expect(msi.collection_name).to eq(['New Images In Medicine'])
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
      expect(work.identifier).to eq(['edc00814'])
    end

    it "sets the holding_entity" do
      expect(work.holding_entity).to eq(['Medical Center Archives'])
    end

    it "sets the archival_collection" do
      expect(work.archival_collection).to eq(["Photograph & Negative Collection"])
    end

    it "sets the related_url" do
      expect(work.related_url).to eq(['http://cbc.ca'])
    end

    it "sets the resource_type" do
      expect(work.resource_type).to eq(['Image'])
    end

    it "adds its collection to the member_of_collections" do
      expect(work.member_of_collections).to eq([collection])
    end

    context 'with complete metadata' do
      let(:input_file) { file_fixture('importer/image/based_near_data.xml') }

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

      it 'sets host organization' do
        expect(work.host_organization).to eq(['Duke University'])
      end

      it 'sets the publishers' do
        expect(work.publisher).to eq(['Duke University Medical Publishing'])
      end
    end

    context "Without a Description" do
      let(:input_file) { file_fixture('importer/image/no_description_data.xml') }
      it 'will not create a record' do
        expect(work.nil?).to be_truthy
      end
      it 'will not create the collection' do
        expect(Collection.where(title: ['Foundations of Excellence']).first.nil?).to be_truthy
      end
    end
    context 'Without date_created' do
      let(:input_file) { file_fixture('importer/image/no_date_created_data.xml') }
      it 'will not create a record' do
        expect(work.nil?).to be_truthy
      end
      it 'will not create the collection' do
        expect(Collection.where(title: ['Foundations of Excellence']).first.nil?).to be_truthy
      end
    end
    context 'Without a subject' do
      let(:input_file) { file_fixture('importer/image/no_subject_data.xml') }
      it 'will not create a record' do
        expect(work.nil?).to be_truthy
      end
      it 'will not create the collection' do
        expect(Collection.where(title: ['Foundations of Excellence']).first.nil?).to be_truthy
      end
    end
    context 'When resource_type is Artifact' do
      let(:input_file) { file_fixture('importer/image/no_based_near_data.xml') }
      it 'will not create a record if based_near is missing' do
        expect(work.nil?).to be_truthy
      end
      it 'will not create the collection if based_near is missing' do
        expect(Collection.where(title: ['Foundations of Excellence']).first.nil?).to be_truthy
      end
    end
    context 'When resource_type is Poster' do
      let(:input_file) { file_fixture('importer/image/no_host_organization_data.xml') }
      it 'will not create a record if host_organization is missing' do
        expect(work.nil?).to be_truthy
      end
      it 'will not create the collection if based_near is missing' do
        expect(Collection.where(title: ['Foundations of Excellence']).first.nil?).to be_truthy
      end
    end
    context 'When resource_type is Presentation' do
      let(:input_file) { file_fixture('importer/image/no_host_presentation_data.xml') }
      it 'will not create a record if host_organization is missing' do
        expect(work.nil?).to be_truthy
      end
      it 'will not create the collection if based_near is missing' do
        expect(Collection.where(title: ['Foundations of Excellence']).first.nil?).to be_truthy
      end
    end
  end

  context 'Processing multiple records' do
    before do
      ActiveFedora::Cleaner.clean!
      AdminSet.find_or_create_default_admin_set_id
    end

    describe 'Import' do
      it 'has a completed message' do
        expect { msi.import }.to output(/Exhibit Room B, postgraduate course on fractures/).to_stdout_from_any_process
      end

      it 'keeps going when there are validation errors' do
        expect { msi_invalid.import }.not_to raise_error('XML is invalid')
      end

      it 'logs an error message with a filename from invalid xml' do
        expect { msi_invalid.import }.to output(/XML\: invalid_medspace_data.xml is invalid/).to_stdout_from_any_process
      end

      context 'when some records fail to import' do
        let(:input_file_1) { file_fixture('importer/image/no_based_near_data.xml') }
        let(:input_file_2) { file_fixture('importer/image/no_subject_data.xml') }
        let(:input_file_3) { file_fixture('importer/image/sample_medspace_data.xml') }
        let(:input_file_4) { file_fixture('importer/image/complete_medspace_data.xml') }
        let(:model) { Image }

        # 2 of the 4 records failed, so 2 should be successful
        it 'successfully imports the valid records' do
          # directory = ''
          xml_files = [input_file_1, input_file_2, input_file_3, input_file_4]
          expect { xml_files.each { |file| described_class.import(file, data_path) } }.to change { model.count }.by(2)
        end
      end
    end
  end
end
