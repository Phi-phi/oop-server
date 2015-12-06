# = concern Module UserPassword
# Userの作成、削除に際しておパスワードによる保護を行う。
# Secretを作成することでセキュリティの向上を狙うが、そもそも通信が平文なので……

module UserPassword
  extend ActiveSupport::Concern
  module_function

  # secretをつくる。かえす。値がbase64なのは趣味。
  def make_secret
    SecureRandom.urlsafe_base64(8)
  end

  def make_password(secret, password)
    Digest::SHA2.hexdigest(secret + password)
  end

  # 重要な操作に際してパスワードを要求するときにこれで認可を行う。
  # セキュリティ的にはそんなに強固ではない。
  # ユーザーが送ったパスワードと、初回に # で定められたセクレットとを合わせて確認する。
  def check_password(userobj, passwd)
    userobj.password == Digest::SHA2.hexdigest(userobj.secret + passwd)
  end
  def check_keyword(userobj, keywd)
    userobj.keyword == Digest::SHA2.hexdigest(userobj.salt + keywd)
  end
end