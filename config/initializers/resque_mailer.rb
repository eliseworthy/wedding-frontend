if Rails.env.production?
	ActionMailer::Base.smtp_settings = {
	  address: "smtp.gmail.com",
	  port: 587,
	  authentication: :plain,
	  domain: 'herokuapp.com',
	  user_name: ENV["EMAIL"],
	  password: ENV["PASSWORD"]
	  }
  ActionMailer::Base.delivery_method = :smtp
end
