class Admin::HotController < AdminController
  def index; end

  def update
    ActiveRecord::Base.transaction do
      Track.where(hot: true).update! hot: false
      Album.where(hot: true).update! hot: false
      Track.where(id: hot_params[:track_ids]).update! hot: true
      Album.where(id: hot_params[:album_ids]).update! hot: true
    end
    redirect_to admin_hot_path, notice: t(".updated")
  rescue Exception
    redirect_to admin_hot_path, alert: t(".failed_to_pin")
  end

  private

  def hot_params
    params.require(:hot).permit track_ids: [], album_ids: []
  end
end
