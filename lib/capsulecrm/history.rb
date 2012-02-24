module CapsuleCRM::History
  def history!
    @history = nil
    history
  end 
  
  def history
    return @history if @history

    path = self.class.get_path
    path = [path, id, 'history'].join '/'
    last_response = self.class.get(path)
    data = last_response['history'].try(:[], 'historyItem')
    @history = CapsuleCRM::HistoryItem.init_many(self, data)
  end
  
  def add_history
    path = [self.class.get_path, self.id, 'history'].join '/'
    self.class.create(Hash[{:note => note}], {:root => 'historyItem', :path => path})
  end
end

