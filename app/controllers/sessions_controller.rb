
# class SessionsController  resource_name, :recall => "#{controller_path}#failure"
#     sign_in_and_redirect(resource_name, resource)


#   def sign_in_and_redirect(resource_or_scope, resource=nil)
#     scope = Devise::Mapping.find_scope!(resource_or_scope)
#     resource ||= resource_or_scope
#     sign_in(scope, resource) unless warden.user(scope) == resource
#     return render :json => {:success => true}
#   end

#   def failure
#     return render :json => {:success => false, :errors => ["Login failed."]}
#   end
# end
