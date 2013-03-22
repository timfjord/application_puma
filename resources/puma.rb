include Chef::Resource::ApplicationBase

attribute :bind, kind_of: String, required: true
attribute :user, kind_of: String
