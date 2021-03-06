# = request_controller.rb
# 統計や計算結果をリクエストに応じて返すためのコントローラ
# 前提として認証が必要なようにしたい かも
# index.htmlは存在しません。

class DataController < ApplicationController
  include CheckMacAddress

  # ここにGETリクエストを送るとキャンパス内の人の分布を便利なJSON形式で返してくれます。
  # 返すJSONは
  #  {
  #      "棟名" :
  #        [棟の人数,
  #         {
  #             "教室名" : 教室内の人数
  #         }
  #        ]
  #  }
  # となっている。

  def distribution_all
    body_hash = Hash.new

    # 1. 建物・教室ごとの情報を集める
    Building.all.select(:id, :name).each do |buil|
      detail_hash = Hash.new
      buil_users = 0
      Classroom.where(building_id: buil.id).select(:id, :name).each do |clas|
        # 2. 今学校にいる人数(a_p_idが0じゃない人)の数えあげ
        clas_users = clas.users.where.not(access_point_id:0).count
        detail_hash[clas.name] = clas_users
        buil_users += clas_users
      end

      # 3. body用のHashに情報を詰め込む
      body_hash[buil.name] = [
          buil_users,
          detail_hash
      ]
    end

    render_result(body:body_hash)
  end

  private
  def user_params
    params.permit(:my_addr, :ap_addr, :classroom)
  end

  def render_result(error:false, message:"", body:Hash.new, status:200)
    result = {
        :error => error,
        :message => message,
        :body => body
    }

    render :json => result, status:status
  end
end
