class Test
    def initialize
        @past_sessions = Session.where('date < ?', Date.today)
        @past_sessions.each do |session|
            session.done!
        end
    end
end
