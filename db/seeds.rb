# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


### PRODUCTS ###
Product.destroy_all

p1 = Product.create name: 'The Fake Canvas Shoes - Blue', brand: 'Purlicue', price: 150.00
p2 = Product.create name: 'The Fake Canvas Shoes - Black', brand: 'Purlicue', price: 150.00
p3 = Product.create name: 'Denim Baseball Shirt', brand: '慢茶mcha', price: 40.00
p4 = Product.create name: 'Circle Printed T-Shirt', brand: '慢茶mcha', price: 30.00
p5 = Product.create name: 'Herbal Medicine Bucket Hat', brand: 'Triple Major', price: 60.00
p6 = Product.create name: 'Herbal Medicine Printed T-Shirt', brand: 'Triple Major', price: 60.00
p7 = Product.create name: 'Upcycled Rectangle Bumbag', brand: 'Remix', price: 35.00
p8 = Product.create name: 'Upcycled Circle Bumbag', brand: 'Remix', price: 150.00

puts "Created #{Product.all.length} products."

### IMAGES ###
Image.destroy_all

img1 = Image.create image: '/assets/purlicue_fake_shoes_blue.jpg'
img2 = Image.create image: '/assets/purlicue_fake_shoes_black.jpg'
img3 = Image.create image: '/assets/mancha_denim_baseball_tee.jpg'
img4 = Image.create image: '/assets/mancha_circle_tee.jpg'
img5 = Image.create image: '/assets/triplemajor_bencao_hat.jpg'
img6 = Image.create image: '/assets/triplemajor_bencao_shirt.jpg'
img7 = Image.create image: '/assets/remix_bumbag.jpg'
img8 = Image.create image: '/assets/remix_bumbag_circle.jpg'

puts "Created #{Image.all.length} images."

p1.images << img1
p2.images << img2
p3.images << img3
p4.images << img4
p5.images << img5
p6.images << img6
p7.images << img7
p8.images << img8

### USERS ###
User.destroy_all

u1 = User.create name:'Hannah', email: 'hannah@gmail.com', password: 'chicken', password_confirmation: 'chicken'
u2 = User.create name:'Jesi', email: 'jesi@gmail.com', password: 'chicken', password_confirmation: 'chicken'
u3 = User.create name:'Claire', email: 'claire@gmail.com', password: 'chicken', password_confirmation: 'chicken'

puts "Created #{User.all.length} users."

### CARTS ###
Cart.destroy_all

c1 = Cart.create user_id: u1.id
c2 = Cart.create user_id: u2.id
c3 = Cart.create user_id: u3.id

puts "Created #{Cart.all.length} carts."

# ### LINE ITEMS ###
# li1 = LineItem.create cart_id: c1.id, product_id: p1.id
# li2 = LineItem.create cart_id: c1.id, product_id: p3.id
# li3 = LineItem.create cart_id: c2.id, product_id: p1.id
#
# puts "Created #{LineItem.all.length} line items."

### SIZE ITEMS ###
ProductSize.destroy_all

s1 = ProductSize.create product_id: p1.id, size: '39', quantity: 2
s2 = ProductSize.create product_id: p1.id, size: '40', quantity: 2
s3 = ProductSize.create product_id: p1.id, size: '41', quantity: 2
s4 = ProductSize.create product_id: p1.id, size: '42', quantity: 2

puts "Created #{ProductSize.all.length} product_sizes."
