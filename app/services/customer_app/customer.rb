module CustomerApp
  class Customer < Base

    def initialize(request = nil)
      super(request)
      @service_base_uri = "#{ENV["CUSTOMER_APP_DOMAIN"]}/api/v1/users"
    end

    def find_or_create_customer(user_id)
      user = JSON.parse(get_customer(user_id))
      JSON.parse(set_customer(params)) unless user
    end  

    def set_customer(user_id)
      handle_timeouts do
        begin
          request_post("#{@service_base_uri}",{params:{user_id: user_id}})
        rescue RestClient::Response => err
          puts "Error : #{err.response}"
        end
      end
    end

    def get_customer(user_id)
      handle_timeouts do
        begin
          request_get("#{@service_base_uri}",{params:{user_id: user_id}})
        rescue RestClient::Response => err
          puts "Error : #{err.response}"
        end
      end
    end
  end
end
