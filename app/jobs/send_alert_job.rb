class SendAlertJob
	@queue = :alerts

	def self.perform(alert_id, user_id)
  	@user = User.find(user_id)
  	@alert = Alert.find(alert_id)

  	@host = ENV['MYUSA_HOME']
  	@path = "/api/notifications"

  	@payload = { 
  		:notification => {
  			:subject => @alert.subject,
  			:body => @alert.body
  		}
  	}.to_json

	  @result = HTTParty.post(@host+@path, 
	    :body => @payload,
	    :headers => {
	    	'Content-Type' => 'application/json',
	    	'Authorization' => "Bearer #{@user.token}"
	    })
	  binding.pry
	  puts @response
	end
end