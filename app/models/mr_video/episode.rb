module MrVideo

  class Episode

    attr_reader :cassette

    def initialize(cassette, http_interaction)
      @cassette = cassette
      @http_interaction = http_interaction
    end

    def id
      url.hash
    end

    def request_method
      request['method']
    end

    def url
      request['uri']
    end

    def website_url
      @website_url ||= "#{uri.scheme}://#{uri.host}"
    end

    def content
      response['body']['string']
    end

    def content_type
      headers['content-type'][0]
    end

    def recorded_at
      Time.zone.parse(http_interaction['recorded_at'].to_s).to_datetime
    end

    def destroy
      cassette.send(:destroy_episode, self)
    end

    def inspect
      to_s
    end

    def to_param
      id.to_s
    end

    private

    def request
      http_interaction['request']
    end

    def response
      http_interaction['response']
    end

    def headers
      @headers ||= response['headers'].transform_keys(&:downcase)
    end

    def uri
      @uri ||= URI(url)
    end

    def http_interaction
      @http_interaction
    end

  end # Episode class

end # MrVideo module
