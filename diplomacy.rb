require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'pry'

require_relative "lib/loader"

get "/" do
  haml :index
end

get "/test" do
  Move.new("Germany A Kie-Ber", "8605399805")
end

get "/current" do
  Move.collection.to_json
end

post "/test" do
  Move.new(params["Body"], params["From"])
end

post "/sms" do
  begin
    case params["Body"]
    when /help/i
      Responses.send_help_message(params["From"])
    when /end\s+round/i
      Move.end_round!
    else
      Move.new(params["Body"], params["From"])
      Responses.move_submit_success(params["From"])
    end
  rescue Errors::MoveParseError
    Responses.move_submit_failure(params["From"])
  rescue Errors::EndRoundError
    Responses.end_round_error(params["From"])
  rescue => e
    Responses.send_string("Error: #{e.message}", params["From"])
  end
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

