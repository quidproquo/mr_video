module MrVideo
  module IdService
    extend self

    def encode(value)
      Base64.urlsafe_encode64(value, padding: false)
    end

    def decode(id)
      Base64.urlsafe_decode64(id)
    end

  end
end
