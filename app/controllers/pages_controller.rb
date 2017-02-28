class PagesController < ApplicationController
    before_action :authorize_page

    def show
        if(!params[:resources].nil?)
            params[:resources].each do |key, value| 
                value_to_set = is_invalid?(value) ? nil : eval(value)
                instance_variable_set("@#{key}", policy_scope(value_to_set) ) unless value_to_set.nil?
            end
        end
        render template: "pages/#{params[:page]}"
    end
    
    private

        #returns true if input string does not follow pattern of: Modelname or Modelname.find/where/order/limit(parameters)
        #note: the where query is currently limited to only single hash conditions
        def is_invalid? (value)
            value !~ /(?:\A[a-z]+)(?:(\.)?(?(1)(?:(?:limit|order|where)\(\w*:?\s?:?'?[\w\s-]*'?\))))*$/i
        end

        def authorize_page
            authorize :pages
        end
end