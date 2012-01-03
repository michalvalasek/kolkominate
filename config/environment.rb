# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Kolkominate::Application.initialize!

# Set custom form builder
ActionView::Base.default_form_builder = AdminiumFormBuilder

