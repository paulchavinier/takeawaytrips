class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 def facebook
  user = User.find_for_facebook_oauth(request.env['omniauth.auth'])
  user.get_friendslist   # Mise à jour ou creation des relations entre amis FB qui ont installé l'app.

  if user.persisted?
    sign_in_and_redirect user, event: :authentication
    # set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  else
    session['devise.facebook_data'] = request.env['omniauth.auth']
    redirect_to new_user_registration_url
  end
 end
end
