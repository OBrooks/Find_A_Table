desc "This task is called by the Heroku scheduler add-on"
task :session_done => :environment do
    @past_sessions = Session.where('date < ?', Date.today)
    puts "Salut"
    @past_sessions.each do |session|
        session.done!
    end
end
