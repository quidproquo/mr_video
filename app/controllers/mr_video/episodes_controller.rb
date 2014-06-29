module MrVideo

  class EpisodesController < MrVideoController

    def show
      show_presenter = Episodes::ShowPresenter.new(self)

      # TODO: Add method for sending decompressed content
      send_data show_presenter.content, type: show_presenter.content_type, disposition: 'inline'
    end

    def destroy
      cassette = Cassette.find(params[:cassette_id])
      @episode = cassette.find_episode_by_id(params[:id])
      @episode.destroy
    end

  end # CassettesController class

end # MrVideo module