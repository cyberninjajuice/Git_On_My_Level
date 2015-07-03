
file = File.read("secrets.json")
data = JSON.parse(file) 

Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
 
  config.external_providers = [:github]


  CLIENTID = data["client-id"]
  CLIENTSECRET= data["client-secret"]

  config.github.key = CLIENTID
  config.github.secret = CLIENTSECRET
  config.github.callback_url = "http://mylevl.com/oauth/callback?provider=github"
  config.github.user_info_mapping = {:email => "email"}


  # --- user config ---
  config.user_config do |user|
    # -- core --
    # specify username attributes, for example: [:username, :email].
    # Default: `[:email]`
    #
    # user.username_attribute_names =
    # Default: `:email`
    
    # encryption key used to encrypt reversible encryptions such as AES256.
    # WARNING: If used for users' passwords, changing this key will leave passwords undecryptable!
    # Default: `nil`
    #
    # user.encryption_key =


    # use an external encryption class.
    # Default: `nil`
    #
    # user.custom_encryption_provider =


    user.authentications_class = Authentication

    user.before_authenticate << :active?
    # User's identifier in authentications class.
    # Default: `:user_id`
  end

  # Define which model authenticates with sorcery.
  config.user_class = "User"
end

