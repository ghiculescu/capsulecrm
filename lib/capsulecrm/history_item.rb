class CapsuleCRM::HistoryItem < CapsuleCRM::Child
  attr_reader :id
  attr_accessor :type
  attr_accessor :entry_date
  attr_accessor :creator
  attr_accessor :subject
  attr_accessor :note
  
  def self.xml_map
    map = {
      "id" => 'id',
      "type" => 'type',
      "entryDate" => 'entry_date',
      "creator" => 'creator',
      "subject" => 'subject',
      "note" => 'note'
    }
    super.merge map
  end
end
