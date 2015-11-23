class VerifyController < ApplicationController
  def index
    @user = User.where(macaddr: user_params[:my_addr])
    @now_ap = AccessPoint.where(macaddr: user_params[:ap_addr]) 
    if @user.blank?
      redirect_to action: 'create'
    else
      redirect_to action: 'ap_check'
    end
  end

  def ap_check
    past_ap = @user.access_point

    if past_ap.macaddr != @now_ap.macaddr
      @user.access_point_id = @now_ap.id
      @user.save
    end
  end

  def create
    @user = User.new(
      :macaddr => user_params[:my_addr],
      :access_point_id => @now_ap.id
    )
    @user.save
  end

  private
  def user_params
    params.require(:check).permit(:my_addr, :ap_addr)
  end
end
