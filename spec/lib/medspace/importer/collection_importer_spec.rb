# frozen_string_literal: true
require 'rails_helper'
describe Medspace::CollectionImporter do
  let(:msci) { described_class.new(input_file) }
  let(:input_file) { file_fixture('importer/collection/collection_1.xml') }
  let(:msci_sans_title) { file_fixture('importer/collection/collection_sans_title.xml') }

  it 'can instantiate' do
    expect(msci).to be_instance_of(described_class)
  end

  it 'has a Nokogiri DOM document' do
    expect(msci.doc).to be_instance_of(Nokogiri::XML::Document)
  end

  context 'parsing the xml' do
    let(:validator) { Medspace::Validator.new(msci_sans_title) }
    it 'validates for title' do
      expect { validator.validate_collection }.to output(/XML\: collection_sans_title.xml is invalid. The errors are\: \[\"Missing title\"\]/).to_stdout_from_any_process
    end

    context 'validating description' do
      let(:msci_sans_description) { file_fixture('importer/collection/collection_sans_description.xml') }
      let(:validator) { Medspace::Validator.new(msci_sans_description) }
      it 'validates for description' do
        expect { validator.validate_collection }.to output(/XML\: collection_sans_description.xml is invalid. The errors are\: \[\"Missing description\"\]/).to_stdout_from_any_process
      end
    end
  end

  context 'processing the xml object' do
    xml_description1 = <<-HERE
The Medical Center Library’s Historical Images in Medicine (HIM) collections encompass over 3,000 photographs, illustrations, engravings, and bookplates from the history of the health and life sciences. Special collections in HIM include Bartisch’s Ophthalmodouleia, the Bookplates, the Four Season and the Stewart Album. In the past the HIM images were only retrievable by our History of Medicine Collections staff, but they are now available via the Internet. The Web versions of the images are not publication quality, nor are they intended for such use. If you see images you would like to incorporate into your publications, please contact the History of Medicine Collections Curator, for information. Grants from The Mary Duke Biddle Foundation and The Josiah Charles Trent Memorial Foundation made possible the realization of the Historical Images in Medicine database.
    HERE

    xml_description2 = <<-HERE
In addition to individual images, The Historical Images in Medicine Collection contains four smaller collections of materials.  1) Georg Bartisch’s <em>Ophthalmodouleia Das ist Augendienst</em>; 2) The Bookplate Collection; 3) The Four Seasons; and 4) The Stewart Album.
    HERE

    let(:record) { msci.records.first }
    let(:collection) { msci.process_record(record) }
    let(:description_1) { Nokogiri::HTML(xml_description1).text.chomp }
    let(:description_2) { Nokogiri::HTML(xml_description2).text.chomp }
    before do
      ActiveFedora::Cleaner.clean!
      AdminSet.find_or_create_default_admin_set_id
    end

    it 'concatenates multiple description elements' do
      expect(collection.description).to eq([description_1, description_2])
    end
  end

  context 'Creating Hyrax Collections' do
    let(:record) { msci.records.first }
    let(:collection) { msci.process_record(record) }

    before do
      ActiveFedora::Cleaner.clean!
      AdminSet.find_or_create_default_admin_set_id
    end

    it 'sets the Fedora object\'s visibility to open' do
      expect(collection.visibility).to eq('open')
    end
  end
end
