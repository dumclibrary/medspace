require 'rails_helper'

describe HandleDispatcher do
  subject(:dispatcher) { described_class.new(registrar: fake_registrar.new) }

  let(:object) do
    Image.new(id: 'fake_moomin',
              title: ['Comet in Moominland'],
              description: ['blah'],
              date_created: ['1999'],
              subject: ['moomins'])
  end

  let(:handle)     { 'hdl/fake_1' }
  let(:handle_url) { "http://hdl.handle.net/#{handle}" }

  let(:fake_registrar) do
    Class.new do
      def initialize(*); end

      def register!(*)
        record        = Handle::Record.new
        record.handle = 'hdl/fake_1'
        record
      end
    end
  end

  shared_examples 'performs handle assignment' do |method|
    it 'returns the same object' do
      expect(dispatcher.public_send(method, object: object, attribute: :handle)).to eql object
    end

    it 'assigns to specified attribute when requested' do
      dispatcher.public_send(method, object: object, attribute: :handle)
      expect(object.handle).to match(handle_url)
    end
  end

  it 'has a registrar' do
    expect(dispatcher.registrar).to be_a fake_registrar
  end

  describe '#assign_for' do
    include_examples 'performs handle assignment', :assign_for
  end

  describe '#assign_for!' do
    let(:id) { ActiveFedora::Noid::Service.new.mint }

    let(:object) do
      Image.new(id: id,
                title: ['Comet in Moominland'],
                description: ['blah'],
                date_created: ['1999'],
                subject: ['moomins'])
    end

    include_examples 'performs handle assignment', :assign_for!

    it 'saves the object' do
      expect { dispatcher.assign_for!(object: object, attribute: :handle) }
        .to change { object.new_record? }
        .from(true)
        .to(false)
    end
  end
end
