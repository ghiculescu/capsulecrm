class CapsuleCRM::Party < CapsuleCRM::Base


  # nodoc
  def addresses
    return @addresses if @addresses
    data = raw_data['contacts']['address']
    @addresses = CapsuleCRM::Address.init_many(self, data)
  end


  # nodoc
  def custom_fields
    return @custom_fields if @custom_fields
    path = self.class.get_path
    path = [path, '/', id, '/customfield'].join
    last_response = self.class.get(path)
    data = last_response['customFields']['customField']
    @custom_fields = CapsuleCRM::CustomField.init_many(self, data)
  end

  def tags
    return @tags if @tags
    path = self.class.get_path
    path = [path, '/', id, '/tag'].join
    last_response = self.class.get(path)
    data = last_response['tags']['tag']
    @tags = CapsuleCRM::Tag.init_many(self, data)
  end

  def tag_names
    tags.map(&:name)
  end

  # nodoc
  def emails
    return @emails if @emails
    data = raw_data['contacts']['email']
    @emails = CapsuleCRM::Email.init_many(self, data)
  end


  # nodoc
  def phone_numbers
    return @phone_numbers if @phone_numbers
    data = raw_data['contacts']['phone']
    @phone_numbers = CapsuleCRM::Phone.init_many(self, data)
  end


  # nodoc
  def self.get_path
    '/api/party'
  end


  def self.find_all_by_email(email, options={})
    options[:email] = email
    find_all(options)
  end


  # nodoc
  def self.find_by_email(email)
    find_all_by_email(email, :limit => 1, :offset => 0).first
  end


  # nodoc
  def self.search(query, options={})
    options[:q] = query
    find_all(options)
  end


end