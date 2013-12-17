class ClientMailer < ActionMailer::Base
  default from: "no-reply@servi-net.us"
  def new_client_registration(client)
    @client = client
    mail(:to => client.email, :subject => "Gracias por registrarse en eSupport.")
  end
end

