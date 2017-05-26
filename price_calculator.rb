public
  def find_orders
    group_by { |e| e.strip.downcase }.
      each_with_object([]) do |i, arr|
        arr << {i[0].to_s => i.last.count}
      end
  end
  def calcu(count, price, offer_price, offer_unit)
  	amt = 0
  	if !offer_price.nil?
	  	offer =  count / offer_unit
		unit = count % offer_unit
		amt = offer * offer_price
	else
		unit = count
	end
	amt += unit * price		
  end
puts 
puts
puts "                                 Welcome to Grocery Store"
puts '                                 -------------------------'

prompt = "> "
puts 'Press 1 to list the Products or press 2 to exit'
print prompt
pro = []
while user_input  = gets.chomp
  case user_input
  when "1"
  	puts " Item   Unit Price    Sales Price"
  	puts '------  -----------   -------------'
  	pro << " Milk   $3.97        2 for $5"
  	pro << " bread  $2.17        3 for $6"
  	pro << " Banana $0.99 " 
  	pro << " Apple  $0.89"

    puts pro
    puts '---------------------------------'
    puts 'Please enter all the items purchased separated by comma.'
    puts
    c = gets.chomp
    a =  c.split(',')
    puts
    break # make sure to break so you don't ask again
  when "2"
    puts 'Thanks for visiting us.'
    exit
  else
    puts 'Press 1 to list the Products or press 2 to exit'
    print prompt # print the prompt, so the user knows to re-enter input
  end
end

 # a = ['milk', 'bread', 'apple','milk', 'bread', 'apple','milk', 'bread', 'apple','orange' ]
bil = []
res = []
total = 0
saved = 0
stock = ['Milk', 'Bread', 'Banana','Apple']
st = a.map(&:strip).map(&:downcase) - stock.map(&:strip).map(&:downcase)
orders =  a.find_orders
orders.each do |product|
	amt = 0
	tamt = 0
	count = product.values[0] 
	order = product.keys[0]
	case order.strip.downcase
	when 'milk'
		#calcu(count, price, offer_price, offer_unit)
		amt = calcu(count, 3.97, 5, 2)
		tamt = count * 3.97
	when 'bread'
		amt = calcu(count, 2.17, 6, 3)
		tamt = count * 2.17
	when 'apple'
		amt = calcu(count, 0.89, nil, nil)
		tamt = count * 0.89
	when 'banana'
		amt = calcu(count, 0.99, nil, nil)
		tamt = count * 0.99
	end
	if amt > 0
		bil << " #{order.capitalize}       #{count}           $#{amt}"
		total += amt
		saved += (tamt - amt)  if tamt > 0
	end
end 
puts " Item       Quantity      Price"

puts '---------------------------'
puts bil
puts 
puts 'Total price : $'+ total.round(2).to_s
puts 'You saved :  $'+saved.round(2).to_s
puts
if st.count>0
	puts 'Note : Below listed products will be available soon.'
	puts st.map(&:capitalize)
	puts
end
puts