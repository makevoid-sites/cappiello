if Rails.env == "production"
  require 'exception_notifier'
  Cappiello::Application.config.middleware.use ExceptionNotifier,
      :email_prefix => "[Cappiello] ",
      :sender_address => %{"Cappiello" <m4kevoid@gmail.com>},
      :exception_recipients => %w{makevoid@gmail.com nicco@filarete.net},
      ignore_exceptions: [ActionView::MissingTemplate]
end


