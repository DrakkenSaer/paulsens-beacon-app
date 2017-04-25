class Api::SessionsController < SessionsController
    def create
        self.resource = warden.authenticate!(auth_options.merge(store: false))
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?

        render json: JWTEncoder.encode({email: resource.email, password: params[:user][:password]}), 
                status: :created, 
                location: after_sign_in_path_for(resource)
    end
end  