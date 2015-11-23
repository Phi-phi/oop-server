class VerifyController < ApplicationController
  def index
    @params = user_params
    @user = User.where(macaddr: @params[:my_addr]).first
    @now_ap = AccessPoint.where(macaddr: @params[:ap_addr]).first 
    if @user.blank?
      self.create
    else
      self.ap_check
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
      :macaddr => @params[:my_addr],
      :access_point_id => @now_ap.id
    )
    @user.save
  end

  private
  def user_params
    params.require(:check).permit(:my_addr, :ap_addr)
  end
end
