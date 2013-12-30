ActionMailer::Base.smtp_settings = {
    :address              => "reach.nseasy.com",
    :port                 => 587,
    :domain               => "ptotem.com",
    :user_name            => "career@codehr.in",
    :password             => "codehr123",
    :authentication       => :login,
    :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?