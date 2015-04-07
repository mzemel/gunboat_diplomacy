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
        :body => "Move could not be understood - did you include the country, spelled out fully?",  
      })
    end

    def send_help_message(from)
      Diplomacy.twilio_client.account.messages.create({
        :from => DiploConfig.phone_number, 
        :to => from, 
        :body => "Reply to me with any of these commands:\nHelp; End round; Germany F Kie-Den A Ber-Kie A Mun-Ruh (or appropriate variant)",  
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