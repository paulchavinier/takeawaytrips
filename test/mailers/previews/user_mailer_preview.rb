class UserMailerPreview < ActionMailer::Preview # doit avoir le meme nom que le le mailer controller
  def welcome # va permettre de voir dans le navigateur pour voir comment ça rend
    user = User.first
    UserMailer.welcome(user)
  end
end
