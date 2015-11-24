class VerifyController < ApplicationController
  def index
    @params = user_params
    @user = User.where(macaddr: @params[:my_addr]).first
    @new_ap = AccessPoint.where(macaddr: @params[:ap_addr]).first 
    if @user.blank?
      self.create
    else
      self.update
    end

    result = {
      'my_addr'   => @user.macaddr,
      'ap_addr'   => @new_ap.macaddr,
      'classroom' => {
        'name'  => @user.classroom.name,
        'x'     => @user.classroom.location[0],
        'y'     => @user.classroom.location[1]
      }
    }

    render :json => result
  end

  def update
    current_ap = @user.access_point

    if current_ap.macaddr != @new_ap.macaddr
      @user.access_point_id = @new_ap.id
      @user.save
    end
  end

  def create
    @user = User.new(
      :macaddr => @params[:my_addr],
      :access_point_id => @new_ap.id
    )
    @user.save
  end

  private
  def user_params
    params.require(:check).permit(:my_addr, :ap_addr)
  end
end
