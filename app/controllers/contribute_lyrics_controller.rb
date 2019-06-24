class ContributeLyricsController < ApplicationController
  def create
    @lyric = Lyric.new lyric_params

    respond_to do |format|
      if lyric.save
        format.js {render "lyrics/created_success"}
      else
        format.js {render "lyrics/created_failed"}
      end
    end
  end

  private

  attr_reader :lyric

  def lyric_params
    params.require(:lyric).permit Lyric::CONTRIBUTE_LYRIC_PARAMS
  end
end
