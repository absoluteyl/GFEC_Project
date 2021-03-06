# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
# 
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create a root user with admin privilege
#User.create(username: 'absoluteyl', email: 'chinbo@gmail.com', mobile: '0987654321', password: '111qaz')
#User.create(username: 'chin1', email: 'chin1@example.com', mobile: '0988776655', password: '111111')
# Create Merchandises for test

# Create data for Category table
# Category.delete_all
# Category. create(name: "Women's Clothing")
# Category. create(name: "Men’s Clothing")
# Category. create(name: "Games & Toys")
# Category. create(name: "Sports & Outdoors")
# Category. create(name: "Accessories")
# Category. create(name: "Cosmetics & Care")
# Category. create(name: "Electronics & Computers")
# Category. create(name: "Cellphones & Accessories")
# Category. create(name: "Home & Living")
# Category. create(name: "Mom & Baby")
# Category. create(name: "Food & Beverage")
# Category. create(name: "Cameras & Lens")
# Category. create(name: "Books & Audible")
# Category. create(name: "Handmade")
# Category. create(name: "Tickets")
# Category. create(name: "Pets")
# Category. create(name: "Miscellaneous")
# Category. create(name: "Tops", parent_id: Category.find_by(name: "Women's Clothing").id)
# Category. create(name: "dresses", parent_id: Category.find_by(name: "Women's Clothing").id)
# Category. create(name: "Jeans", parent_id: Category.find_by(name: "Women's Clothing").id)
# Category. create(name: "Jackets", parent_id: Category.find_by(name: "Women's Clothing").id)
# Category. create(name: "Shoes", parent_id: Category.find_by(name: "Women's Clothing").id)
Category. create(name: "Tops", parent_id: Category.find_by(name: "Men's Clothing").id)
Category. create(name: "Jumpsuits", parent_id: Category.find_by(name: "Men's Clothing").id)
Category. create(name: "Jeans", parent_id: Category.find_by(name: "Men's Clothing").id)
Category. create(name: "Coats", parent_id: Category.find_by(name: "Men's Clothing").id)
Category. create(name: "Shoes", parent_id: Category.find_by(name: "Men's Clothing").id)
Category. create(name: "Video Games", parent_id: Category.find_by(name: "Games & Toys").id)
Category. create(name: "Board Games", parent_id: Category.find_by(name: "Games & Toys").id)
Category. create(name: "Boys' Toys", parent_id: Category.find_by(name: "Games & Toys").id)
Category. create(name: "Girls' Toys", parent_id: Category.find_by(name: "Games & Toys").id)


# Create data for City table
City. delete_all
City. create(name:"台北市")#1
City. create(name:"新北市")#2
City. create(name:"基隆市")#3
City. create(name:"宜蘭縣")#4
City. create(name:"桃園縣")#5
City. create(name:"新竹市")#6
City. create(name:"新竹縣")#7
City. create(name:"苗栗縣")#8
City. create(name:"台中市")#9
City. create(name:"彰化縣")#10
City. create(name:"南投縣")#11
City. create(name:"嘉義市")#12
City. create(name:"嘉義縣")#13
City. create(name:"雲林縣")#14
City. create(name:"台南市")#15
City. create(name:"高雄市")#16
City. create(name:"澎湖縣")#17
City. create(name:"屏東縣")#18
City. create(name:"台東縣")#19
City. create(name:"花蓮縣")#20
City. create(name:"金門縣")#21
City. create(name:"連江縣")#22
City. create(name:"南海諸島")#23
City. create(postcode: 100, name:"中正區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 103, name:"大同區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 104, name:"中山區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 105, name:"松山區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 106, name:"大安區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 108, name:"萬華區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 110, name:"信義區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 111, name:"士林區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 112, name:"北投區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 114, name:"內湖區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 115, name:"南港區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 116, name:"文山區", parent_id: City.find_by(name: "台北市").id)
City. create(postcode: 207, name:"萬　里", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 208, name:"金　山", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 220, name:"板　橋", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 221, name:"汐　止", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 222, name:"深　坑", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 223, name:"石　碇", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 224, name:"瑞　芳", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 226, name:"平　溪", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 227, name:"雙　溪", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 228, name:"貢　寮", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 231, name:"新　店", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 232, name:"坪　林", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 233, name:"烏　來", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 234, name:"永　和", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 235, name:"中　和", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 236, name:"土　城", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 237, name:"三　峽", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 238, name:"樹　林", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 239, name:"鶯　歌", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 241, name:"三　重", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 242, name:"新　莊", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 243, name:"泰　山", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 244, name:"林　口", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 247, name:"蘆　洲", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 248, name:"五　股", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 249, name:"八　里", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 251, name:"淡　水", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 252, name:"三　芝", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 253, name:"石　門", parent_id: City.find_by(name: "新北市").id)
City. create(postcode: 200, name:"仁愛區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 201, name:"信義區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 202, name:"中正區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 203, name:"中山區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 204, name:"安樂區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 205, name:"暖暖區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 206, name:"七堵區", parent_id: City.find_by(name: "基隆市").id)
City. create(postcode: 260, name:"宜　蘭", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 261, name:"頭　城", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 262, name:"礁　溪", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 263, name:"壯　圍", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 264, name:"員　山", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 265, name:"羅　東", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 266, name:"三　星", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 267, name:"大　同", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 268, name:"五　結", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 269, name:"冬　山", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 270, name:"蘇　澳", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 272, name:"南　澳", parent_id: City.find_by(name: "宜蘭縣").id)
City. create(postcode: 320, name:"中  壢", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 324, name:"平  鎮", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 325, name:"龍  潭", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 326, name:"楊  梅", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 327, name:"新  屋", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 328, name:"觀  音", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 330, name:"桃  園", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 333, name:"龜  山", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 334, name:"八  德", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 335, name:"大  溪", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 336, name:"復  興", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 337, name:"大  園", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 338, name:"蘆  竹", parent_id: City.find_by(name: "桃園縣").id)
City. create(postcode: 300, name:"全  區", parent_id: City.find_by(name: "新竹市").id)
City. create(postcode: 302, name:"竹  北", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 303, name:"湖  口", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 304, name:"新  豐", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 305, name:"新  埔", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 306, name:"關  西", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 307, name:"芎　林", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 308, name:"寶  山", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 310, name:"竹  東", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 311, name:"五  峰", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 312, name:"橫  山", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 313, name:"尖  石", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 314, name:"北  埔", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 315, name:"峨  眉", parent_id: City.find_by(name: "新竹縣").id)
City. create(postcode: 350, name:"竹  南", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 351, name:"頭  份", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 352, name:"三  灣", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 353, name:"南  庄", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 354, name:"獅  潭", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 356, name:"後  龍", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 357, name:"通  霄", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 358, name:"苑  裡", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 360, name:"苗  栗", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 361, name:"造  橋", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 362, name:"頭  屋", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 363, name:"公  館", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 364, name:"大  湖", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 365, name:"泰  安", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 366, name:"銅  鑼", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 367, name:"三  義", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 368, name:"西  湖", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 369, name:"卓  蘭", parent_id: City.find_by(name: "苗栗縣").id)
City. create(postcode: 400, name:"中  區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 401, name:"東  區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 402, name:"南  區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 403, name:"西  區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 404, name:"北  區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 406, name:"北屯區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 407, name:"西屯區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 408, name:"南屯區", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 411, name:"太  平", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 412, name:"大  里", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 413, name:"霧  峰", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 414, name:"烏  日", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 420, name:"豐  原", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 421, name:"后  里", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 422, name:"石  岡", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 423, name:"東  勢", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 424, name:"和  平", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 426, name:"新  社", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 427, name:"潭  子", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 428, name:"大  雅", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 429, name:"神  岡", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 432, name:"大  肚", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 433, name:"沙  鹿", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 434, name:"龍  井", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 435, name:"梧　棲", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 436, name:"清  水", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 437, name:"大  甲", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 438, name:"外  埔", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 439, name:"大  安", parent_id: City.find_by(name: "台中市").id)
City. create(postcode: 500, name:"彰  化", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 502, name:"芬  園", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 503, name:"花  壇", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 504, name:"秀  水", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 505, name:"鹿  港", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 506, name:"福  興", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 507, name:"線  西", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 508, name:"和  美", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 509, name:"伸  港", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 510, name:"員  林", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 511, name:"社  頭", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 512, name:"永  靖", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 513, name:"埔  心", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 514, name:"溪  湖", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 515, name:"大  村", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 516, name:"埔  鹽", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 520, name:"田  中", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 521, name:"北  斗", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 522, name:"田  尾", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 523, name:"埤  頭", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 524, name:"溪  州", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 525, name:"竹  塘", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 526, name:"二  林", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 527, name:"大  城", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 528, name:"芳  苑", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 530, name:"二  水", parent_id: City.find_by(name: "彰化縣").id)
City. create(postcode: 540, name:"南  投", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 541, name:"中  寮", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 542, name:"草  屯", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 544, name:"國  姓", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 545, name:"埔  里", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 546, name:"仁  愛", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 551, name:"名  間", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 552, name:"集  集", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 553, name:"水  里", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 555, name:"魚  池", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 556, name:"信  義", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 557, name:"竹  山", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 558, name:"鹿  谷", parent_id: City.find_by(name: "南投縣").id)
City. create(postcode: 600, name:"全  區", parent_id: City.find_by(name: "嘉義市").id)
City. create(postcode: 602, name:"番  路", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 603, name:"梅  山", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 604, name:"竹  崎", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 605, name:"阿里山", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 606, name:"中  埔", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 607, name:"大  埔", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 608, name:"水  上", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 611, name:"鹿  草", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 612, name:"太  保", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 613, name:"朴　子", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 614, name:"東  石", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 615, name:"六  腳", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 616, name:"新  港", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 621, name:"民  雄", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 622, name:"大  林", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 623, name:"溪  口", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 624, name:"義  竹", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 625, name:"布  袋", parent_id: City.find_by(name: "嘉義縣").id)
City. create(postcode: 630, name:"斗  六", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 631, name:"大  埤", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 632, name:"虎  尾", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 633, name:"土  庫", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 634, name:"褒  忠", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 635, name:"東  勢", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 636, name:"台  西", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 637, name:"崙  背", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 638, name:"麥  寮", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 640, name:"斗  六", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 643, name:"林  內", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 646, name:"古  坑", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 647, name:"荊  桐", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 648, name:"西  螺", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 649, name:"二  崙", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 651, name:"北  港", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 652, name:"水  林", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 653, name:"口  湖", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 654, name:"四  湖", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 655, name:"元  長", parent_id: City.find_by(name: "雲林縣").id)
City. create(postcode: 700, name:"中  區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 701, name:"東  區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 702, name:"南  區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 703, name:"西  區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 704, name:"北  區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 708, name:"安平區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 709, name:"安南區", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 710, name:"永  康", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 711, name:"歸  仁", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 712, name:"新  化", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 713, name:"左  鎮", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 714, name:"玉  井", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 715, name:"楠  西", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 716, name:"南  化", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 717, name:"仁  德", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 718, name:"關  廟", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 719, name:"龍  崎", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 720, name:"官  田", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 721, name:"麻  豆", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 722, name:"佳  里", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 723, name:"西  港", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 724, name:"七  股", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 725, name:"將  軍", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 726, name:"學  甲", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 727, name:"北  門", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 730, name:"新  營", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 731, name:"後  壁", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 732, name:"白  河", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 733, name:"東  山", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 734, name:"六  甲", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 735, name:"下  營", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 736, name:"柳  營", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 737, name:"鹽  水", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 741, name:"善  化", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 742, name:"大  內", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 743, name:"山  上", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 744, name:"新  市", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 745, name:"安  定", parent_id: City.find_by(name: "台南市").id)
City. create(postcode: 800, name:"新興區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 801, name:"前金區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 802, name:"苓雅區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 803, name:"鹽埕區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 804, name:"鼓山區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 805, name:"旗津區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 806, name:"前鎮區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 807, name:"三民區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 811, name:"楠梓區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 812, name:"小港區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 813, name:"左營區", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 814, name:"仁  武", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 815, name:"大  社", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 820, name:"岡  山", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 821, name:"路  竹", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 822, name:"阿  蓮", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 823, name:"田  寮", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 824, name:"燕  巢", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 825, name:"橋  頭", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 826, name:"梓  官", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 827, name:"彌  陀", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 828, name:"永  安", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 829, name:"湖  內", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 830, name:"鳳  山", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 831, name:"大  寮", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 832, name:"林  園", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 833, name:"鳥  松", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 840, name:"大  樹", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 842, name:"旗  山", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 843, name:"美  濃", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 844, name:"六  龜", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 845, name:"內  門", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 846, name:"杉  林", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 847, name:"甲  仙", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 848, name:"桃  源", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 849, name:"三  民", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 851, name:"茂  林", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 852, name:"茄  萣", parent_id: City.find_by(name: "高雄市").id)
City. create(postcode: 880, name:"馬  公", parent_id: City.find_by(name: "澎湖縣").id)
City. create(postcode: 881, name:"西  嶼", parent_id: City.find_by(name: "澎湖縣").id)
City. create(postcode: 882, name:"望  安", parent_id: City.find_by(name: "澎湖縣").id)
City. create(postcode: 883, name:"七  美", parent_id: City.find_by(name: "澎湖縣").id)
City. create(postcode: 884, name:"白  沙", parent_id: City.find_by(name: "澎湖縣").id)
City. create(postcode: 885, name:"湖  西", parent_id: City.find_by(name: "澎湖縣").id)
City. create(postcode: 900, name:"屏  東", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 901, name:"三  地", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 902, name:"霧  台", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 903, name:"瑪  家", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 904, name:"九  如", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 905, name:"里  港", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 906, name:"高  樹", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 907, name:"鹽  埔", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 908, name:"長  治", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 909, name:"麟  洛", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 911, name:"竹  田", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 912, name:"內  埔", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 913, name:"萬  丹", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 920, name:"潮  州", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 921, name:"泰  武", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 922, name:"來  義", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 923, name:"萬  巒", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 924, name:"崁  頂", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 925, name:"新  埤", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 926, name:"南  州", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 927, name:"林  邊", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 928, name:"東  港", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 929, name:"琉  球", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 931, name:"佳  冬", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 932, name:"新  園", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 940, name:"枋  寮", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 941, name:"枋  山", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 942, name:"春  日", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 943, name:"獅  子", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 944, name:"車  城", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 945, name:"牡  丹", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 946, name:"恆  春", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 947, name:"滿  州", parent_id: City.find_by(name: "屏東縣").id)
City. create(postcode: 950, name:"台  東", parent_id: City.find_by(name: "台東縣").id)
City. create(postcode: 955, name:"鹿  野", parent_id: City.find_by(name: "台東縣").id)
City. create(postcode: 961, name:"成  功", parent_id: City.find_by(name: "台東縣").id)
City. create(postcode: 966, name:"達  仁", parent_id: City.find_by(name: "台東縣").id)
City. create(postcode: 970, name:"花  蓮", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 971, name:"新  城", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 972, name:"秀  林", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 973, name:"吉  安", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 974, name:"壽  豐", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 975, name:"鳳  林", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 976, name:"光  復", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 977, name:"豐  濱", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 978, name:"瑞  穗", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 979, name:"萬  榮", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 981, name:"玉  里", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 982, name:"卓  溪", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 983, name:"富  里", parent_id: City.find_by(name: "花蓮縣").id)
City. create(postcode: 890, name:"金  沙", parent_id: City.find_by(name: "金門縣").id)
City. create(postcode: 891, name:"金  湖", parent_id: City.find_by(name: "金門縣").id)
City. create(postcode: 892, name:"金  寧", parent_id: City.find_by(name: "金門縣").id)
City. create(postcode: 893, name:"金  城", parent_id: City.find_by(name: "金門縣").id)
City. create(postcode: 894, name:"烈  嶼", parent_id: City.find_by(name: "金門縣").id)
City. create(postcode: 896, name:"烏  坵", parent_id: City.find_by(name: "金門縣").id)
City. create(postcode: 209, name:"南  竿", parent_id: City.find_by(name: "連江縣").id)
City. create(postcode: 210, name:"北  竿", parent_id: City.find_by(name: "連江縣").id)
City. create(postcode: 211, name:"莒  光", parent_id: City.find_by(name: "連江縣").id)
City. create(postcode: 212, name:"東  引", parent_id: City.find_by(name: "連江縣").id)
City. create(postcode: 817, name:"東  沙", parent_id: City.find_by(name: "南海諸島").id)
City. create(postcode: 819, name:"南  沙", parent_id: City.find_by(name: "南海諸島").id)
City. create(postcode: 290, name:"釣魚台列嶼", parent_id: City.find_by(name: "南海諸島").id)