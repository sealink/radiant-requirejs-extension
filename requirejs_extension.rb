# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
class RequirejsExtension < Radiant::Extension
  version "1.0"
  description "Extension to integrate RequireJS."
  url ''


  def activate
    require 'tags/requirejs_tags'
    Page.send :include, RequirejsTags
  end


  def deactivate
  end
end
