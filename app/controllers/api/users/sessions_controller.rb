class Api::Users::SessionsController < Devise::SessionsController
    respond_to :json

    def create
        self.resource = warden.authenticate!(auth_options.merge(store: false))
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        
        @encoded_token = JWTEncoder.encode({email: resource.email, password: params[:user][:password]})
        render 'users/registrations/show.json', user: resource, status: :created
    end
    

    private
    
        def respond_to_on_destroy
            flash[:notice] = find_message(:signed_out)
    
            # We actually need to hardcode this as Rails default responder doesn't
            # support returning empty response on GET request
            respond_to do |format|
                format.all { head :no_content }
                format.any(*navigational_formats) { render json: flash.to_hash, status: :ok }
            end
        end

end  