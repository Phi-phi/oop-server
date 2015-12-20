# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

TEST_BUILDINGS = [
    { name:"Alpha" },
    { name:"Omega" },
    { name:"Mu" },
    { name:"Kappa" },
    { name:"Epsilon" },
    { name:"Iota" },
    { name:"Omicron" },
    { name:"Lambda" },
    { name:"Theta" },
    { name:"Delta" },
    { name:"Tau" },
    { name:"Psi" },
    { name:"Phi" },
    { name:"Gamma" },
    { name:"Sigma" },
    { name:"Nu" },
    { name:"Zeta" },
    { name:"Kango" },
    { name:"Guesthouse" },
    { name:"others" }
]

TEST_CLASSROOMS = [
    { name:"testclass01", location:[1, 1], building_id:1 },
    { name:"testclass02", location:[2, 2], building_id:1 },
    { name:"testclass03", location:[3, 3], building_id:1 },
    { name:"testclass04", location:[4, 4], building_id:1 },
    { name:"testclass05", location:[5, 5], building_id:1 },
    { name:"testclass06", location:[6, 6], building_id:2 },
    { name:"testclass07", location:[7, 7], building_id:2 },
    { name:"testclass08", location:[8, 8], building_id:2 },
    { name:"testclass09", location:[9, 9], building_id:3 }
]

TEST_ACCESS_POINTS = [
    { name:"ap-test-1f-01", macaddr:"00:10:20:30:40:01", classroom_id:1 },
    { name:"ap-test-1f-02", macaddr:"00:10:20:30:40:02", classroom_id:1 },
    { name:"ap-test-1f-03", macaddr:"00:10:20:30:40:03", classroom_id:1 },
    { name:"ap-test-1f-04", macaddr:"00:10:20:30:40:04", classroom_id:2 },
    { name:"ap-test-1f-05", macaddr:"00:10:20:30:40:05", classroom_id:2 },
    { name:"ap-test-1f-06", macaddr:"00:10:20:30:40:06", classroom_id:2 },
    { name:"ap-test-1f-07", macaddr:"00:10:20:30:40:07", classroom_id:3 },
    { name:"ap-test-1f-08", macaddr:"00:10:20:30:40:08", classroom_id:3 },
    { name:"ap-test-1f-09", macaddr:"00:10:20:30:40:09", classroom_id:3 },
    { name:"ap-test-1f-10", macaddr:"00:10:20:30:40:10", classroom_id:4 }
]

TEST_USERS = [
    { macaddr:"FF:FF:FF:FF:FF:01", access_point_id:1, password:"", secret:"", keyword:"", salt:"" },
    { macaddr:"FF:FF:FF:FF:FF:02", access_point_id:1, password:"", secret:"", keyword:"", salt:"" },
    { macaddr:"FF:FF:FF:FF:FF:03", access_point_id:1, password:"", secret:"", keyword:"", salt:"" },
    { macaddr:"FF:FF:FF:FF:FF:04", access_point_id:4, password:"", secret:"", keyword:"", salt:"" },
    { macaddr:"FF:FF:FF:FF:FF:05", access_point_id:5, password:"", secret:"", keyword:"", salt:"" },
    { macaddr:"FF:FF:FF:FF:FF:06", access_point_id:6, password:"", secret:"", keyword:"", salt:"" }
]

APIS = [
    { name:"POST account/register", description:"User情報の登録を行います。アプリケーションの初回起動時に行うようにしてください。", resource_url:"account/register.json" },
    { name:'POST account/update', description:'情報の更新に使います。バックグランドでの定期通信時、あるいはユーザーの指定した任意のタイミングで利用してください。', resource_url:'account/update.json' }
]

API_PARAMS = [
    { api_name:"POST account/register", name:"my_addr", optional:false, description:"端末のMACアドレス。区切る場合は「:」か「.」で。", example_value:"11:23:45:A2:BD:FF" },
    { api_name:"POST account/register", name:"ap_addr", optional:false, description:"CNS-APのMACアドレス。区切る場合は「:」か「.」で。", example_value:"00:E7:52:B1:BD:FF" },
    { api_name:"POST account/register", name:"password", optional:false, description:"ユーザーが指定したパスワード。", example_value:"my_password" },
    { api_name:"POST account/register", name:"keyword", optional:false, description:"アプリケーションが作成したキーワード。", example_value:"some_keyword" }
]


#** 書き込み **#

TEST_BUILDINGS.each do |hash|
  Building.create(hash)
end

TEST_CLASSROOMS.each do |hash|
  Classroom.create(hash)
end

TEST_ACCESS_POINTS.each do |hash|
  AccessPoint.create(hash)
end

TEST_USERS.each do |hash|
  User.create(hash)
end

APIS.each do |hash|
  Api.create(hash)
end

API_PARAMS.each do |hash|
  ApiParameter.create(hash)
end