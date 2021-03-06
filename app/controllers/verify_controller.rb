# = verify_controller.rb
# 端末の登録とか位置情報のアップデートとかに使う。
# verify -> auth に名前の変更を検討中


#--
# TODO: 入力に対して複数エラーを検知してJSONでエラー送信できるように
#  concernsにModule作る。処理を人鳥してから引っかかったとこ全部JSONにして送り返すような
#  参考: http://qiita.com/suin/items/f7ac4de914e9f3f35884
# TODO: Verifyからの名前の変更検討(itochanがなんか変じゃねって言ってた)
#++

# #index で端末のMACアドレスを確認し、<br>
# 新規登録の場合は VerifyController#create <br>
# そうでなければ VerifyController#update <br>
# でそれぞれ処理。

class VerifyController < ApplicationController
  include CheckMacAddress

  def index
    @params = user_params

    # もらったMACアドレスがvalidか判定する
    @params.each do |elem|
      unless check_mac_address(elem[1])
        render(nothing: true, status: 500) and return
      end
    end

    # @user = User.where(macaddr: @params[:my_addr]).first
    # @new_ap = AccessPoint.where(macaddr: @params[:ap_addr]).first
    #   where().firstじゃなくてwhere().takeになる(find_by()は等価)けど一意に決まってるしこれでいいのでは
    #   cf.) https://github.com/bbatsov/rails-style-guide/issues/76
    @user = User.find_by(macaddr: @params[:my_addr])
    @new_ap = AccessPoint.find_by(macaddr: @params[:ap_addr])

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

  # GETメソッドテスト用のサンプルメソッド
  def getsample
    @me = update_params[:my_addr]
  end

  # 上書き
  # updated_at情報の更新や、access_point_idが0になっていた人が帰ってきた時にもこれを使う必要がある
  def update
    current_ap = @user.access_point

    if current_ap.macaddr != @new_ap.macaddr
      @user.access_point_id = @new_ap.id
      @user.save
    end
  end

  # 新規作成
  def create
    @user = User.new(
      :macaddr => @params[:my_addr],
      :access_point_id => @new_ap.id
    )
    @user.save
  end

  # データの削除
  def delete
    user = User.find_by(name: delete_params[:my_addr])
    check_password(user, delete_params[:password])
  end

  private
  def user_params
    params.require(:check).permit(:my_addr, :ap_addr)
  end

  def update_params
    params.permit(:my_addr, :ap_addr, :format)
  end

  # トークンでのログインではないので（いまのところ）、my_addrを要求します。
  def delete_params
    params.permit(:my_addr, :password, :format)
  end
end

