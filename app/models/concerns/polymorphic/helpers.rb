module Concerns::Polymorphic::Helpers
    def find_resource(object = self)
        resource = object.orderable_type
        id = object.orderable_id
        @resource ||= resource.singularize.classify.constantize.find(id)
    end
end