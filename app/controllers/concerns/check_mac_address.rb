# = concern Module CheckMacAddress
# MACアドレスとしてもらったものが正しい書式であるかを判定する。
#  16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁
# のもののみ有効となっている。（カンマ区切り、スペース入りはアウト）

module CheckMacAddress

  # MACアドレスとしてもらったものが正しい書式であるかを判定する。
  #  16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁:16進数2桁
  # のもののみ有効となっている。（カンマ区切り、スペース入りはアウト）
  def check_mac_address(string)
    if string.match(/\h{2}:\h{2}:\h{2}:\h{2}:\h{2}:\h{2}/)
      return true
    else
      return false
    end
  end
end