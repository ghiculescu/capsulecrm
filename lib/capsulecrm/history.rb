module CapsuleCRM::History
  # Reload history
  def history!
    @history = nil
    history
  end 

  # Load history if not loaded
  def history
    return @history if @history

    path = self.class.get_path
    path = [path, id, 'history'].join '/'
    last_response = self.class.get(path)
    data = last_response['history'].try(:[], 'historyItem')
    @history = CapsuleCRM::HistoryItem.init_many(self, data)
  end

  
  def add_history(note)
    if note
      path = [self.class.get_path, self.id, 'history'].join '/'
      self.class.create(Hash[{:note => note}], {:root => 'historyItem', :path => path})
      
      # TODO : Should be optimized so it doesn't reload history each time
      @history = nil
    end
  end
  
  alias :add_note :add_history
end

