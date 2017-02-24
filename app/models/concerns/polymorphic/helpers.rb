module Concerns::Polymorphic::Helpers
    def find_resource(object = self)
        resourcable_type = object.attributes.keys.keep_if { |attribute| attribute.include?('_type') }.first
        resourcable_id = resourcable_type.sub('_type', '_id')
        resource = object.send(resourcable_type)
        id = object.send(resourcable_id)
        @resource ||= resource.singularize.classify.constantize.find(id)
    end
end