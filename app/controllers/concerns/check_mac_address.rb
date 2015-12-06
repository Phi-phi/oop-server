# = concern Module CheckMacAddress
# MACアドレスとしてもらったものが正しい書式であるかを判定する。
#  16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁
# のもののみ有効となっている。（カンマ区切り、スペース入りはアウト）

module CheckMacAddress
  extend ActiveSupport::Concern
  module_function

  # MACアドレスとしてもらったものが正しい書式であるかを判定する。
  #  16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁
  #  16進数2桁.16進数2桁.16進数2桁.16進数2桁.16進数2桁.16進数2桁
  #  16進数12桁
  # のものがOK（判定はちょっとゆるい）
  def check_mac_address(string)
    if string.match(/\A\h{2}[.:]\h{2}[.:]\h{2}[.:]\h{2}[.:]\h{2}[.:]\h{2}\Z/)
      return true
    elsif string.match(/\A\h{12}\Z/)
      return true
    else
      p "¥"
      return false
    end
  end

end