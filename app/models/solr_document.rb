# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.

  use_extension( Hydra::ContentNegotiation )

  def archival_collection
    self[Solrizer.solr_name('archival_collection')]
  end
  def holding_entity
    self[Solrizer.solr_name('holding_entity')]
  end
  def date
    self[Solrizer.solr_name('date')]
  end
  def date_accepted
    self[Solrizer.solr_name('date_accepted')]
  end
  def condition
    self[Solrizer.solr_name('condition')]
  end
  def accrual_method
    self[Solrizer.solr_name('accrual_method')]
  end
  def provenance
    self[Solrizer.solr_name('provenance')]
  end
  def host_organization
    self[Solrizer.solr_name('host_organization')]
  end
  def at_location
    self[Solrizer.solr_name('at_location')]
  end
  def title_ssort
    self[Solrizer.solr_name('title_ssort')]
  end
  def handle
    self[Solrizer.solr_name('handle')]
  end
end
