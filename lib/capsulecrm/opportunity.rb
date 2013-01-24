class CapsuleCRM::Opportunity < CapsuleCRM::Base

  attr_accessor :name
  attr_accessor :party_id
  attr_accessor :currency
  attr_accessor :value
  attr_accessor :duration_basis
  attr_accessor :duration
  attr_accessor :expected_close_date
  attr_accessor :actual_close_date
  attr_accessor :milestone
  attr_accessor :updated_on
  attr_accessor :created_on  
  attr_accessor :probability

  # nodoc
  def self.xml_map
    map = {
      'name' => 'name',
      'partyId' => 'party_id',
      'currency' => 'currency',
      'value' => 'value',
      'durationBasis' => 'duration_basis',
      'expectedCloseDate' => 'expected_close_date',
      'actualCloseDate' => 'actual_close_date',
      'milestone' => 'milestone',
      'updatedOn' => 'updated_on',
      'createdOn' => 'created_on',
      'probability' => 'probability',
    }
    super.merge map
  end

  def all
    return @opportunities if @opportunities
    path = self.class.get_path
    last_response = self.class.get(path)
    @opportunities = CapsuleCRM::Opportunity.init_many(last_response)
  end
  
  # nodoc
  def self.get_path
    '/api/opportunity'
  end


  # nodoc
  def self.init_many(response)
    data = response['opportunities']['opportunity']
    CapsuleCRM::Collection.new(self, data)
  end

  # nodoc
  def self.init_one(response)
    data = response['opportunity']
    new(attributes_from_xml_hash(data))
  end

  # nodoc
  def party
    return nil if party_id.nil?
    @party ||= CapsuleCRM::Party.find(party_id)
  end
  
  # nodoc
  def custom_fields
    return @custom_fields if @custom_fields
    path = self.class.get_path
    path = [path, '/', id, '/customfield'].join
    last_response = self.class.get(path)
    data = last_response['customFields'].try(:[], 'customField')
    @custom_fields = CapsuleCRM::CustomField.init_many(self, data)
  end

end
