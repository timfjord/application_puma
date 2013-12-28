include ApplicationCookbook::ResourceBase

attribute :bind, kind_of: String, required: true
attribute :user, kind_of: String
attribute :monit_timeout, kind_of: Integer, default: 30
attribute :config_source, kind_of: String
attribute :config_cookbook, kind_of: String
attribute :init_file, kind_of: String
