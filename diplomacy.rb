require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'pry'

require_relative "lib/loader"

get "/" do
  haml :index
end

post "/sms" do
  begin
    case params["Body"]
    when /commands/i
      Responses.send_commands_message(params["From"])
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
%h4 Welcome to Gunboat Diplomacy.
%div Text your diplomacy moves to <b>#{DiploConfig.phone_number}</b> - do any of the following:
%ul
  %li 
    %b Commands
    (this message/check connectivity)
  %li
    %b Germany F Kie-Den A Ber-Kie A Mun-Ruh
    (example)
  %li 
    %b End round
    (process ALL moves)

%ol
  %li Don't worry about seasons.  This process will be for every turn.
  %li Text your moves (see above format)
  %li At the round end time, have one person text <b>End round</b>.
  %li Everyone gets a text with all the moves for that round, anonymously.
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

