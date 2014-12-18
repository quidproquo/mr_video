module MrVideo

  class Cassette

    def initialize(cassette_path)
      @cassette_path = cassette_path
    end

    def id
      URI.escape(name, /\//)
    end

    def name
      @name ||= cassette_path.sub(self.class.cassette_dir, '').match(/^\/(.+)\.yml$/)[1]
    end

    def episodes
      @episodes ||= http_interactions.map { |http_interaction|
        create_episode(http_interaction)
      }.sort { |a, b|
        a.url <=> b.url
      }
    end

    def updated_at
      @updated_at ||= episodes.map(&:recorded_at).max
    end


    # Methods:

    def destroy
      File.delete(cassette_path)
    end

    def load
      raw_data
    end

    def reload
      reset_episodes
      reset_raw_data
    end

    def save!
      File.open(cassette_path, mode: 'w') do |file|
        YAML.dump(raw_data, file)
      end
      reload
    end

    def find_episode_by_id(episode_id)
      episodes_grouped_by_id[episode_id.to_s]
    end

    def inspect
      to_s
    end

    def to_param
      id
    end

    # Class methods:

    def self.all
      cassette_paths.map { |cassette_path|
        new(cassette_path)
      }
    end

    def self.find(name)
      cassette_path = cassette_paths(name).first
      unless cassette_path
        raise StandardError.new("#{self.name} with name: '#{name}' not found!")
      end
      new(cassette_path)
    end

    private

    # Properties:

    def episodes_grouped_by_id
      @episodes_grouped_by_id ||= episodes.inject({}) { |hash, episode|
        hash[episode.id.to_s] = episode
        hash
      }
    end

    def http_interactions
      raw_data['http_interactions']
    end

    def raw_data
      @raw_data ||= YAML.load(File.read(cassette_path))
    end

    def cassette_path
      @cassette_path
    end

    # Methods:

    def create_episode(http_interaction)
      Episode.new(self, http_interaction)
    end

    def destroy_episode(episode)
      http_interactions.delete(episode.send(:http_interaction))
      save!
    end

    def reset_raw_data
      @raw_data = nil
    end

    def reset_episodes
      @episodes = nil
    end

    # Class properties:

    def self.cassette_paths(name = '**/*')
      Dir.glob(cassette_dir + "/#{name}.yml")
    end

    def self.cassette_dir
      MrVideo.configuration.cassette_library_dir
    end

  end # Cassette class

end # MrVideo module
