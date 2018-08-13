User.create(first_name: "Marian" , last_name: "Ilco" , email: "ilcomarian@gmail.com", birthday: "26/2/123")
Post.create(title: "7 Bitcoin Experts Examine the Future of Crypto" , post: "After reaching almost $20,000 in December, Bitcoin has plummeted $14,000 in six months - trading at around $6,500 as of noon Eastern on Saturday, July 7. Meanwhile, Ethereum dropped from just under $1,400 in January to below $500 in June. Here's what seven experts had to tell CNBC about the future of bitcoin and cryptocurrencies", user_id: 1)



# t.string :title
# t.string :post
# t.integer :user_id

# t.string :first_name
#       t.string :last_name
#       t.string :email
#       t.integer :birthday