# gunboat_diplomacy
Web server that uses [Twilio](https://www.twilio.com) SMS integration to create in-person gunboat diplomacy games.

See the User's manual [here](http://warm-everglades-8078.herokuapp.com/)

#### Installation

1.  Install git, ruby, rubygems, and the heroku toolbelt.
2.  Create a trial (or paid) account with Twilio and copy your Account SID, Auth Token, and SMS phone number.
3.  Git clone this repo, `gem install sinatra`, `bundle install`
4.  `heroku create` to create a heroku server and add it to your git remote.
5.  `git push heroku master`
6.  `heroku config:set ACCOUNT_SID=<ACCOUNT_SID> AUTH_TOKEN=<AUTH_TOKEN> PHONE_NUMBER=<PHONE_NUMBER>`
7.  `heroku open` and get the URL.  Add "/sms" to the end of that string and save that in your Twilio console under your number's SMS endpoint, keeping it as HTTP POST.
8.  You should be able to text "commands", "end round", or any moves in valid syntax described on the home page of your heroku app to your Twilio phone number.  The moves will be stored in your heroku server and delivered to all participants whenever someone ends the round.

For any support concerns, contact me at michael [dot] zemel [at] gmail [dot] com.
