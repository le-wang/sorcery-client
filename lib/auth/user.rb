module Auth
  class User
    extend ActiveModel::Callbacks
    include ActiveModel::MassAssignmentSecurity

    define_model_callbacks :save

    include Sorcery::Model
    include Sorcery::Model::Adapters::ActiveRecord

    authenticates_with_sorcery!

    attr_accessor :id, :username, :email

    def initialize(attrs)
      @id = attrs[:id]
      @username = attrs[:username]
      @email = attrs[:email]
    end

    class << self
      def site
        APP_CONFIG[:site][Rails.env]
      end

      def login(email, password)
        new Oj.load(
          RestClient.post("#{site}/api/v1/sessions.json", {
            :email => email,
            :password => password
          })
        ).with_indifferent_access
      rescue
        nil
      end

      def find_by_credentials(credentials)
        nil
      end

      def find(id)
        new Oj.load(
          RestClient.get("#{site}/api/v1/users/#{id}.json")
        ).with_indifferent_access
      rescue
        nil
      end
    end
  end
end
