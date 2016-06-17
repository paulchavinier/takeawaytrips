class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user) # la methode prend un argument ce qui differe d un controller classique
    attachments.inline['banneremail.png'] = File.read('app/assets/images/banneremail.png')
    #attachments.inline['Logowhite_Small.png'] = File.read('app/assets/images/Logowhite_Small.png')
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Take Away Trips !')

  end
end
