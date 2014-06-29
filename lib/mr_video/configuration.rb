module MrVideo

  class Configuration

    attr_accessor :cassette_library_dir

    def cassette_library_dir
      @cassette_library_dir ||= './spec/fixtures/vcr_cassettes'
    end

  end

end # MrVideo module