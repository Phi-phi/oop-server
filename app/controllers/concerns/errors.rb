# = concern Module Errors
# エラーのBodyの部分を作ります。
# 作成した者はArrayに格納してbodyにそのまま突っ込んで下しあ。

module Errors
  extend ActiveSupport::Concern
  module_function

=begin ########################################
こんな感じ。
  ERROR_HASH = {
      :error => "true",
      :message => "",
      :body => [
          {
              :resource => "Issue",
              :field => "title",
              :code => "missing_field"
          }
      ]
  }
=end ##########################################

  # Arrayに収める要素を作る
  def error_element(resource, field, code)
    # なんとかこれにまとめる？まとめないほうがエラーわかりやすい？でもメソッドだらけになっちゃう？
  end

  def not_mac_address_error(target)
    body = Hash.new
    body[:resource] = "user"
    body[:field] = target
    body[:code] = "invalid_mac_address"
    return body
  end

  def creation_error(type)
    body = Hash.new
    body[:resource] = "account"
    body[:field] = "create"
    body[:code] = type

    return body
  end

  def update_error

  end

  def deletion_error(target)
    body = Hash.new
    body[:resource] = "user"
    body[:field] = target
    body[:code] = "deletion_error"
    return body
  end

  def password_error(target)
    body = Hash.new
    body[:resource] = "user"
    body[:field] = target
    body[:code] = "wrong_password"

    return body
  end


  def combine_errors(error_array, message)
    json = ERROR_HASH
    json[:message] = message
    json[:body] = error_array
    return json
  end

  def fatal_error(e)
    body = Hash.new
    body[:resource] = "account"
    body[:field] = "fatal"
    body[:code] = e

    return body
  end
end
