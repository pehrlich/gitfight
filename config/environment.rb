Haml::Template.options[:format] = :html5


# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Gitfite::Application.initialize!
