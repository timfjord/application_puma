include Chef::Resource::ApplicationBase

attribute :bind, kind_of: String, required: true
attribute :user, kind_of: String
attribute :monit_timeout, kind_of: Integer, default: 30
attribute :init_file, kind_of: String
