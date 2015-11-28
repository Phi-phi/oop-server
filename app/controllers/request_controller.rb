# = request_controller.rb
# 統計や計算結果をリクエストに応じて返すためのコントローラ
# 前提として認証が必要なようにしたい かも
# index.htmlは存在しません。

class RequestController < ApplicationController
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

    Building.all.select(:id, :name).each do |buil|
      detail_hash = Hash.new
      buil_count = 0
      Classroom.where(building_id: buil.id).select(:id, :name).each do |clas|
        # 今学校にいる人数(a_p_idが0じゃない人)の数えあげ
        clas_num = clas.users.where.not(access_point_id:0).count
        detail_hash[clas.name] = clas_num
        buil_count += clas_num
      end
      json_hash[buil.name] = [
          buil_count,
          detail_hash
      ]
    end

    render :json => json_hash.to_json
  end

  private
  def user_params
    params.require(:check).permit(:my_addr, :ap_addr, :classroom)
  end
end
