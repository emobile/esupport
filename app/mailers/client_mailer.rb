class ClientMailer < ActionMailer::Base
  default from: "emobile.chihuahua@gmail.com"
  def new_client_registration(client)
    @client = client
    mail(:to => client.email, :subject => "Gracias por registrarse en eSupport.")
  end
end

