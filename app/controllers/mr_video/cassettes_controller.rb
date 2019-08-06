module MrVideo
  class CassettesController < MrVideoController

    def index
      @cassettes = Cassette.all
    end

    def show
      @cassette = Cassette.find(params[:id])
    end

    def destroy
      @cassette = Cassette.find(params[:id])
      @cassette.destroy    
    end

  end
end
