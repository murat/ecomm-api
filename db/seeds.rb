# frozen_string_literal: true
Doorkeeper::Application.create(name: 'ecomm', redirect_uri: 'urn:ietf:wg:oauth:2.0:oob', confidential: false, scopes: %w(read write admin))

puts 'Creating sample user'
user = User.create(name: 'murat', surname: 'bastas', phone: '05555555555', email: 'muratbsts@gmail.com', password: 'password', password_confirmation: 'password')
user.confirm

puts 'Creating address for user'
Address.create(FactoryBot.attributes_for(:address, user_id: user.id))

puts 'Creating sample categories'
category_yaml =
  <<-TEXT
  Elektronik:
    - Bilgisayarlar: ["Tablet", "Masaüstü Bilgisayar", "Dizüstü Bilgisayar Laptop", "Monitör", "PC in-One", "Mini Masaüstü", "Serverlar", "Dokunmatik Pos PC"]
    - Veri Depolama
    - Bilgisayar Bileşenleri: ["Anakartlar", "Ekran Kartları", "Bellek", "İşlemciler", "Hard Diskler", "Bilgisayar Kasası", "Power Supply", "Optik Sürücüler"]
    - Çevre Birimleri
    - Ağ / Modem
    - Aksesuarlar
    - Yazılım Ürünleri
    - Oyuncu Özel
    - MP3 / Ses Kayıt Cihazları
    - Bilgisayar Yedek Parçaları
  Elektrikli Ev Aletleri:
    - Ankastre Setler
    - Aspiratörler
    - Bulaşık Makineleri
    - Buzdolapları
    - Çamaşır Makineleri
    - Davlumbazlar
    - Derin Dondurucular
    - Fırınlar
  TEXT

categories = YAML.safe_load(category_yaml)

def create_categories(name, children = [], parent = nil)
  category = Category.find_or_create_by(name: name, ancestry: parent)

  children.map do |child|
    ancestry = category.ancestry ? "#{category.ancestry}/#{category.id}" : category.id.to_s
    if child.is_a?(Hash)
      child.each do |c, grandchild|
        create_categories(c, grandchild, ancestry)
      end
      return
    end

    Category.find_or_create_by(name: child, ancestry: ancestry)
  end
end

categories.each do |category, children|
  create_categories(category, children)
rescue StandardError => e
  pp e.inspect
end

puts 'Creating sample brands'
brands = ['3M', 'Alienware', 'Amazon', 'AMD', 'Analog Devices', 'Apple', 'Audiovox',
          'Avaya', 'Averatec', 'Bose', 'Cisco Systems', 'Crucial Technology', 'Dell',
          'eMachines', 'Emerson Electric', 'Emerson Radio', 'Fitbit', 'Gateway',
          'Google', 'Hewlett-Packard', 'HP', 'IBM', 'Intel', 'Kingston', 'Koss',
          'Magnavox', 'Micron Technology', 'Microsoft', 'Motorola', 'Nvidia',
          'Packard Bell', 'Plantronics', 'Polycom', 'Qualcomm', 'RCA', 'Sandisk',
          'Seagate', 'SGI', 'Sun Microsystems', 'Texas Instruments',
          'Unisonic Products Corporation', 'Unisys', 'Vizio', 'Viewsonic',
          'Western Digital', 'Westinghouse Electric Corporation', 'Xerox', 'Zenith']
brands.each(&->(b) { Brand.find_or_create_by(name: b) })

puts 'Creating sample products'
30.times do |_n|
  Product.create(
    name: Faker::Commerce.product_name,
    brand_id: Brand.order('random()').limit(1).first.id,
    category_id: Category.order('random()').limit(1).first.id,
    stock: (1..100).to_a.sample
  )
end
