module Hyrax
  module HoldingEntityService
    mattr_accessor :authority
    self.authority = Qa::Authorities::Local.subauthority_for('holding_entity')

    def self.select_options
      authority.all.map do |element|
        [element[:label], element[:id]]
      end
    end

    def self.label(id)
      authority.find(id).fetch('term')
    end
  end
end
