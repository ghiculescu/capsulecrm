class CapsuleCRM::Email < CapsuleCRM::Contact

  attr_accessor :address
  define_attribute_methods [:address]


  # nodoc
  def attributes
    attrs = {}
    arr = [:address, :type]
    arr.each do |key|
      attrs[key] = self.send(key)
    end
    attrs
  end
  
  # nodoc
  def address=(value)
    address_will_change! unless value == address
    @address = value
  end
  
  # nodoc
  def dirty_attributes
    Hash[attributes.select { |k,v| changed.include? k.to_s }]
  end
  
  def parent_type
    return "person" if self.parent.class == CapsuleCRM::Person
    return "organisation" if self.parent.class == CapsuleCRM::Organisation
    raise "Unknown Parent Type"
  end
  
  # nodoc
  def save
    path = ["", "api", parent_type, self.parent.id].join("/")
    options = {:root => 'person', :path => path}
    attrs = new_record?? attributes : {:id => id}.merge(dirty_attributes)
    success = self.class.update id, attrs, options
    changed_attributes.clear if success
    success   
  end
  
  # uses xml_map() to convert :attributes into an xml string
  def self.attributes_to_xml(attributes, root=nil)
    xml = {"contacts" => {"email" => {}}}
    map = xml_map.invert
    attributes.each do |k,v|
      key = map[k.to_s]
      xml["contacts"]["email"][key] = v
    end
    xml.to_xml :root => root
  end
  
  # nodoc
  def self.xml_map
    map = {
      'emailAddress' => 'address'
    }
    super.merge map
  end


end
