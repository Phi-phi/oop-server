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

  def distribution
    json_hash = Hash.new
    body_hash = Hash.new

    testarray = Array.new
    # 1. errorではない
    json_hash[:error] = false

    # 2. 建物・教室ごとの情報を集める
    Building.all.select(:id, :name).each do |buil|
      detail_hash = Hash.new
      buil_users = 0
      Classroom.where(building_id: buil.id).select(:id, :name).each do |clas|
        # 今学校にいる人数(a_p_idが0じゃない人)の数えあげ
        clas_users = clas.users.where.not(access_point_id:0).count
        detail_hash[clas.name] = clas_users
        buil_users += clas_users
      end

      # 3. body用のHashに情報を詰め込む
      body_hash[buil.name] = [
          buil_users,
          detail_hash
      ]

      testarray << buil_users
    end

    p testarray
    puts body_hash

    # 4. Hash自体を作る
    json_hash[:body] = body_hash

    render :json => json_hash.to_json
  end

  private
  def user_params
    params.permit(:my_addr, :ap_addr, :classroom)
  end
end
