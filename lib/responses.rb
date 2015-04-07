class Responses
  class << self
    def move_submit_success(from)
      Diplomacy.twilio_client.account.messages.create({
        :from => DiploConfig.phone_number, 
        :to => from, 
        :body => "Move successfully submitted",  
      })
    end

    def move_submit_failure(from)
      Diplomacy.twilio_client.account.messages.create({
        :from => DiploConfig.phone_number, 
        :to => from, 
        :body => "Command could not be understood.  If it was a move, spell the country out fully.  Otherwise, text Commands to see all available commands.",  
      })
    end

    def send_commands_message(from)
      Diplomacy.twilio_client.account.messages.create({
        :from => DiploConfig.phone_number, 
        :to => from, 
        :body => "Reply to me with any of these commands:\nCommands; End round; Germany F Kie-Den A Ber-Kie A Mun-Ruh (or appropriate variant)",  
      })
    end

    def send_string(string, from)
      Diplomacy.twilio_client.account.messages.create({
        :from => DiploConfig.phone_number, 
        :to => from, 
        :body => string,  
      })
    end

    def end_round_error(from)
      Diplomacy.twilio_client.account.messages.create({
        :from => DiploConfig.phone_number, 
        :to => from, 
        :body => "There was a problem ending this round.  This should never happen.",  
      })
    end
  end
end