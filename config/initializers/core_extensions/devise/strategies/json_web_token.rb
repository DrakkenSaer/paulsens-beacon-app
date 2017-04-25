module Devise
    module Strategies
        class JsonWebToken < Base
            def valid?
                request.headers['Authorization'].present?
            end
            
            def authenticate!
                return fail! unless claims
                return fail! unless claims.has_key?('email') && claims.has_key?('password')

                user = User.find_for_authentication(email: claims['email'])
                success! user if user.valid_password?(claims['password'])
            end
            
            protected
            
                def claims
                    strategy, token = request.headers['Authorization'].split(' ')
                    
                    return nil if (strategy || '').downcase != 'bearer'
                    
                    JWTEncoder.decode(token) rescue nil
                end
        end
    end
end