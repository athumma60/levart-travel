class RegistrationsController < Devise::RegistrationsController

skip_before_filter :require_no_authentication, only: [:new]

	#Defines Destroy
	def destroy
	    resource.soft_delete
	    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
	    set_flash_message :notice, :destroyed if is_flashing_format?
	    yield resource if block_given?
	    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
    end

  protected
  	#Defines update Resources
    def update_resource(resource, params)
      resource.update_without_password(params)
    end  
end  
