require 'socket'

module CustomerApp
  class Base

    def initialize(request = nil)
      if( request.present?
        host = request.protocol + request.host_with_port unless request.nil?
      else
        host = Socket.ip_address_list.detect(&:ipv4?).try(:ip_address)
      end
      @headers = {
        :content_type       => :json,
        :accept             => :json,
        :"X-Forwarded-For"  =>  host
      }
    end

    def request_get(url, params = {}, custom_header = {})
      request_header = @headers.merge(custom_header)
      request_header = request_header.merge(params)
      RestClient.get(url,request_header)
    end

    def request_post(url, params = {}, custom_header = {})
      request_header = @headers.merge(custom_header)
      RestClient.post(url, params, request_header)
    end

    def request_put(url, params = {}, custom_header = {})
      request_header = @headers.merge(custom_header)
      RestClient.put(url, params, request_header)
    end

    def request_delete(url, params = {}, custom_header = {})
      request_header = @headers.merge(custom_header)
      request_header = request_header.merge(params)
      RestClient.delete(url,request_header)
    end

    def handle_timeouts
      begin
        yield
      rescue Net::OpenTimeout, Net::ReadTimeout
        {}
      end
    end
  end
end
