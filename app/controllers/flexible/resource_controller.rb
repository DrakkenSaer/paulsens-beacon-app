class Flexible::ResourceController < ResourceController
  include Concerns::Resource::Nested::SetParentResource

  prepend_before_action :set_parent_resource

  def index
    set_resource_variable(@parent_resource.class == resource_class ? 
                                      policy_scope(resource_class) : 
                                      policy_scope(@parent_resource.send(resource_name.pluralize)),
                          "@#{resource_name.pluralize}")
  end

  def create
    set_resource_variable(@parent_resource.class == resource_class ? 
                                                  @parent_resource : 
                                                  @parent_resource.send(resource_name.pluralize).create(resource_params))

    authorize_resource
    respond_with resource, location: helpers.flexible_resource_path(resource_path, resource)
  end

  def update
    resource.update(resource_params)
    respond_with resource, location: helpers.flexible_resource_path(resource_path, resource)
  end

  def destroy
    resource.destroy
    respond_to do |format|
      format.html { redirect_to after_destroy_path, notice: "#{resource_class.name} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def resource_path(name = resource_name)
      eval("#{name}_path")
    end

    def set_resource
      if @parent_resource.class == resource_class
        set_resource_variable(@parent_resource)
      else
        set_resource_variable(params[:id] ? @parent_resource.send(resource_name.pluralize).find(params[:id]) : @parent_resource.send(resource_name.pluralize).build)
      end
    end
    
    def after_destroy_path
      if @parent_resource.class == resource_class
        resource_path(resource_name.pluralize)
      else
        @parent_resource
      end
    end
    
end
