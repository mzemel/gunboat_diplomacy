require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'pry'

require_relative 'config'

def twilio_client
  @client ||= Twilio::REST::Client.new DiploConfig.account_sid, DiploConfig.auth_token 
end

def phone_number
  DiploConfig.phone_number
end
 
get "/" do
  haml :index
end

get "/sms" do
  twilio_client.account.messages.create({
    :from => DiploConfig.phone_number, 
    :to => '18605399805', 
    :body => 'test',  
  })
  "Message sent!"
end

post "/sms" do
  twilio_client.account.messages.create({
    :from => DiploConfig.phone_number, 
    :to => '18605399805', 
    :body => params.inspect,  
  })
end

__END__

@@ layout
%html
  = yield

@@ index
%h4 Welcome to my gunboat diplomacy engine.
%div To use this app, text commands to <b>#{DiploConfig.phone_number}</b>.
%div Here are the valid commands:
%ul
  %li 
    %b Help
    (this message/check connectivity)
  %li
    %b Germany F Kie-Den A Ber-Kie A Mun-Ruh
    (example)
  %li 
    %b End round
    (process ALL moves)

%ol
  %li When you successfully text your moves, you'll get a confirmation text.  If there are errors, such as forgetting the country name, you'll receive a text instructing you to fix it, stupid.
  %li When someone texts <b>End round</b>, all moves are combined and texted to everyone.  The round is over.
  %li This app doesn't keep track of seasons; do that yourself. 
  %li Invalid moves are ignored.  Beware of autocorrect!
  %li Do the round over if anything went wrong.
%br
%div Hopefull you receive a text that looks like this:
%ul
  %li Germany F Kie-Den A Ber-Kie A Mun-Ruh
  %li France F Bre-MAO A Par-Bel A Mar-Spa
  %li Austria F Tri-Ven A Vie-Bud A Bud-Ser
  %li Turkey F Ank-Bla A Con-Bul A Smy-Con
  %li Russia F Sev-Bla A War-Gal A Mos-War F Stp(sc)-Bot
  %li Italy A Ven-Tri F Nap-Ion A Rom-Nap
  %li England F Lon-Yor F Edi-Yor A Lvp-Yor

