# = account_controller.rb
# 端末の登録とか位置情報のアップデートとかに使う。
# verify_controller から変更、増強

#--
# TODO: 入力に対して複数エラーを検知してJSONでエラー送信できるように
#  concernsにModule作る。処理を人鳥してから引っかかったとこ全部JSONにして送り返すような
#  参考: http://qiita.com/suin/items/f7ac4de914e9f3f35884
#++

# #index で端末のMACアドレスを確認し、<br>
# 新規登録の場合は AccountController#create <br>
# そうでなければ AccountController#update <br>
# でそれぞれ処理。
class AccountController < ApplicationController
  before_action :init

  # 新規作成…及び端末キーワードが変わった時にキーワードだけ更新出来る用になりました。
  # passwordを要求します。
  def create
    @user.blank? ? create_new : recreate
  end


  # 上書き
  # updated_at情報の更新や、access_point_idが0になっていた人が帰ってきた時にもこれを使う必要がある
  # TODO: 'account#update'
  def update
    @error_array << Errors.password_error("keyword")  unless UserPassword.check_keyword(@user, @params[:keyword])

    current_ap = AccessPoint.find(@user.access_point_id)
    if current_ap.macaddr != @new_ap.macaddr
      @user.access_point_id = @new_ap.id
      @user.save!
    end

    body = {
        :created_at => @user.created_at,
        :updated_at => @user.updated_at,
        :my_addr    => @user.macaddr,
        :ap_addr    => @new_ap.macaddr,
        :classroom  => {
            :name => @user.classroom.name,
            :x    => @user.classroom.location[0],
            :y    => @user.classroom.location[1]
        }
    }
  rescue => e
    @error_array << Errors.fatal_error(e.to_s)
    render_result(error:true, message:"fatalエラー", body:@error_array, status:500)
  else
    if @error_array.length > 0
      render_result(error:true, message:"Failed to update.", body:@error_array, status:500)
    else
      render_result(message:"Update has succeeded.", body:body)
    end
  end


  # ログアウト(ユーザーは残す)
  def logout
    @error_array << Errors.password_error("keyword")  unless UserPassword.check_keyword(@user, @params[:keyword])
    @error_array << Errors.password_error("password")  unless UserPassword.check_password(@user, @params[:password])

    # 0が不在を表します
    @user.access_point_id = 0
    @user.save!

    body = {
        :created_at => @user.created_at,
        :updated_at => @user.updated_at,
        :my_addr    => @user.macaddr,
        :ap_addr    => @new_ap.macaddr,
        :classroom  => {
            :name => @user.classroom.name,
            :x    => @user.classroom.location[0],
            :y    => @user.classroom.location[1]
        }
    }
  rescue => e
    @error_array << Errors.fatal_error(e)
    render_result(error:true, message:"fatalエラー", body:@error_array, status:500)
  else
    if @error_array.length > 0
      render_result(error:true, message:"Failed to logout.", body:@error_array, status:500)
    else
      render_result(message:"Logout has succeeded.")
    end
  end


  # データの削除
  # userとkeywordとpasswordを照合して合致すればデータ削除。
  def delete
    # 存在しなければエラー：この処理悩みまくったけどこれ以上うまい解決法が思いつかない…
    @error_array << Errors.fatal_error("no user existing") and raise  if @user.blank?

    # password/keywordのチェック
    @error_array << Errors.password_error("keyword")  unless UserPassword.check_keyword(@user, @params[:keyword])
    @error_array << Errors.password_error("password")  unless UserPassword.check_password(@user, @params[:password])
  rescue => e
    @error_array << Errors.fatal_error(e)
    render_result(error:true, message:"fatalエラー", body:@error_array, status:500)
  else
    if @error_array.length > 0
      render_result(error:true, message:"Failed to delete.", body:@error_array, status:500)
    else
      @user.destroy    # user.destroy ここに置くの絶対良くない。。。
      render_result(message:"Deletion has succeeded.")
    end
  end


  # GETメソッドテスト用のサンプルメソッド
  def getsample
    @me = update_params[:my_addr]
  end

  # -------------------------------------------------------#
  # -------------------   private   -----------------------#
  # -------------------------------------------------------#

  private

  # 新規作成
  def create_new
    secret = UserPassword::make_secret
    salt = UserPassword::make_secret

    @user = User.new(
        :macaddr => @params[:my_addr],
        :access_point_id => @new_ap.id,
        :secret => secret,
        :password => UserPassword::make_password(secret, @params[:password]),
        :salt => salt,
        :keyword => UserPassword::make_password(salt, @params[:keyword])
    )
    @user.save!

    body = {
        :created_at => @user.created_at,
        :updated_at => @user.updated_at,
        :my_addr    => @user.macaddr,
        :ap_addr    => @new_ap.macaddr,
        :classroom  => {
            :name => @user.classroom.name,
            :x    => @user.classroom.location[0],
            :y    => @user.classroom.location[1]
        }
    }
  rescue => e
    @error_array << Errors.creation_error("#{e} #{$@}")
    render_result(error:true, message:"内部エラーです", body:@error_array, status:500)
  else
    render_result(body:body)
  end


  # ユーザデータがあるときのkeywordの登録しなおし（暗黙）
  def recreate
    @error_array << Errors.password_error("password") and raise unless UserPassword.check_password(@user, @params[:password])
    salt = UserPassword::make_secret
    current_ap = AccessPoint.find(@user.access_point_id)
    if current_ap.macaddr != @new_ap.macaddr
      @user.access_point_id = @new_ap.id
    end
    @user.salt = salt
    @user.keyword = UserPassword::make_password(salt, @params[:keyword])
    @user.save!

    body = {
        :created_at => @user.created_at,
        :updated_at => @user.updated_at,
        :my_addr    => @user.macaddr,
        :ap_addr    => @new_ap.macaddr,
        :classroom  => {
            :name => @user.classroom.name,
            :x    => @user.classroom.location[0],
            :y    => @user.classroom.location[1]
        }
    }
  rescue => e
    @error_array << Errors.creation_error("#{e} #{$@}")
    render_result(error:true, message:"内部エラーです", body:@error_array, status:500)
  else
    render_result(body:body)
  end


  def render_result(error:false, message:"", body:Hash.new, status:200)
    result = {
        :error => error,
        :message => message,
        :body => body
    }

    render :json => result, status:status
  end


  #----- params ------#

  # 引数たち。
  def account_params
    params.permit(:my_addr, :ap_addr, :password, :keyword, :format)
  end

  # 更新用
  def update_params
    params.permit(:my_addr, :ap_addr, :keyword, :format)
  end

  # トークンでのログインではないので（いまのところ）、my_addrを要求します。
  def delete_params
    params.permit(:my_addr, :password, :keyword, :format)
  end


  #----- before_action ------#

  def check_format
    unless params[:format] == "json"
      render :file => "/public/404.html", :status => 404 and return
    end
  end

  # インスタンス変数の初期化とMACアドレスチェック
  # @error_array もここで初期化してもいいかも？
  def init
    @error_array = Array.new
    @params = account_params

    # もらったMACアドレスがvalidか判定する
    @params.slice(*[:my_addr, :ap_addr]).each do |elem|
      if elem != ""
        unless CheckMacAddress.check_mac_address(elem[1])
          @error_array << Errors.not_mac_address_error(elem[0])
        end
      end
    end

    if @error_array.length > 0
      render_result(error:true, message:"initエラーです", body:@error_array, status:500) and return
    end

    @user = User.find_by(macaddr: @params[:my_addr])
    @new_ap = AccessPoint.find_by(macaddr: @params[:ap_addr])
  end
end
