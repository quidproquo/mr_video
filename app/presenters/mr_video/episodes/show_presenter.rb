module MrVideo

  module Episodes

    class ShowPresenter

      def initialize(context)
        @context = context
      end

      def content
        if fix_relative_links?
          content_with_relative_links_fixed
        else
          raw_content
        end
      end

      def content_type
        episode.content_type
      end

      private

      def content_with_relative_links_fixed
        content = raw_content
        [
        /href=["']([^'" >]+)["']/,
        /src=["']([^'" >]+)["']/,
        /@import url\(([^'" >]+)\)/
        ].each do |pattern|
          content.gsub!(pattern) do |match|
            url = $1
            match.gsub(url, URI.join(base_url, url).to_s) rescue URI::InvalidURIError
          end
        end
        content
      end

      def base_url
        episode.website_url
      end

      def raw_content
        episode.content
      end

      def fix_relative_links?
        params[:fix_relative_links] != 'false'
      end

      def episode
        @episode ||= cassette.find_episode_by_id(id)
      end

      def cassette
        @cassette ||= Cassette.find(cassette_id)
      end

      def cassette_id
        params[:cassette_id]
      end

      def id
        params[:id]
      end

      def params
        context.params
      end

      def context
        @context
      end

    end # ShowPresenter class

  end # Episodes module

end # MrVideo module
