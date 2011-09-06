class CapsuleCRM::Contact < CapsuleCRM::Child

  attr_accessor :type
  define_attribute_methods [:type]

  # nodoc
  def attributes
    attrs = {}
    arr = [:type]
    arr.each do |key|
      attrs[key] = self.send(key)
    end
    attrs
  end
  
  # nodoc
  def type=(value)
    type_will_change! unless value == type
    @type = value
  end
  
  # nodoc
  def self.xml_map
    map = {'type' => 'type'}
    super.merge map
  end
end
