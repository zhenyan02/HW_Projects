
#gem 'rubocop', require: false
$VERBOSE = nil
#######################################################################
#this is class to translate the smart code in to a readable String
#######################################################################
class Readnumber
  
    def initialize(smartnumber)
      @smartnumber   = smartnumber
      @typeclearence = smartnumber[4] 
      @typenbr       = smartnumber.scan(/\d/)[0,1].join.to_i
      @typeprice     = smartnumber.scan(/\d/)[4,3].join.to_i
      @typesize      = smartnumber[8,2]
      @typestock     = smartnumber.scan(/\d/)[7,4].join.to_i
      @typelocation  = smartnumber[13,2]
     end
   
   def modelnames
    case @typenbr 
     when 0 
       return "Tshirt"
     when 1 
       return "Sweater"
     when 2 
       return "Dress"     
     when 3 
       return "Shorts"     
     when 4 
       return "Skirt"     
     when 5 
       return "Pants"     
     when 6 
       return "Jacket"     
     when 7 
       return "Scarf"     
     when 8 
       return "Coats"     
     when 9 
       return "Others"
    end
    end
    
   def clearenceornot
     if @typeclearence == 'N'
      return "No, it is not a clearence item"
     else 
      return "YES, It is a clearence item"
     end      
     end   
    
   def prices
    return @typeprice
    end
    
    def stocks
     return @typestock
     end
    
    def locations
     return @typelocation
     end
end
 
#######################################################################
#this fucntion priority orders function
#               *Priority Queue with Binary tree* |
#               *Priority Queue with Binary tree* |
#               *Priority Queue with Binary tree* |
#               *Priority Queue with Binary tree* |
#               *Priority Queue with Binary tree* V
#
#######################################################################
class PriorityQueue
  def initialize
    @orders = [nil]
   end

  def <<(ordernbr)
    @orders << ordernbr
   end
  
  def move_up(index)
    parent_index = (index / 2)
    return if index <= 1
    return if @orders[parent_index] >= @orders[index]
    exchange(index, parent_index)
    move_up(parent_index)
   end

  def exchange(source, target)
    @orders[source], @orders[target] = @orders[target], @orders[source]
   end

  def <<(ordernbr)
    @orders << ordernbr
    move_up(@orders.size - 1)
   end

  def pop
    exchange(1, @orders.size - 1)
    max = @orders.pop
    move_down(1)
    max
   end

  def move_down(index)
    child_index = (index * 2)
    return if child_index > @orders.size - 1
    not_the_last_ordernbr = child_index < @orders.size - 1
    left_ordernbr = @orders[child_index]
    right_ordernbr = @orders[child_index + 1]
    child_index += 1 if not_the_last_ordernbr && right_ordernbr > left_ordernbr
    return if @orders[index] >= @orders[child_index]
    exchange(index, child_index)
    move_down(child_index)
   end
   
  def orderssize
    @orders.size
   end

end
 
#######################################################################
#this is class to put the details of a order.
#######################################################################
 class MakeOrder
  include Comparable

  attr_accessor  :priority,:orderDetail

  def initialize( priority, orderDetail)
     @priority, @orderDetail=  priority, orderDetail
  end

  def <=>(other)
    @priority <=> other.priority
  end
end
#######################################################################
#this fucntion is to get the new model number it can used for new item
#I will use the *BUBBLE SORT* here since the Model Number is almost sorted already.
#               *BUBBLE SORT*
#               *BUBBLE SORT*
#               *BUBBLE SORT*
#               *BUBBLE SORT*
#               *BUBBLE SORT*
#               *BUBBLE SORT*
#               *BUBBLE SORT*
#All I need to do is to get rid of the duplicate model number
#######################################################################
def Reorderbymodel(newtypenbr)
 # the following line are put different model numbers into an array    
    differentmodels = Array.new
    File.open("inventory.txt") do |f|
      f.each_line do |line|
        if line[0] == newtypenbr
          unless differentmodels.include?(line[1,3])
            differentmodels << line[1,3]
          end
        end
      end
    end
  # The following codes are sort the model numbers
  
#               *BUBBLE SORT*    |
#               *BUBBLE SORT*    |
#               *BUBBLE SORT*    |
#               *BUBBLE SORT*    |
#               *BUBBLE SORT*    |
#               *BUBBLE SORT*    V
  differentmodels.each do |i|
    i = 0
    j = 1
    while (j < differentmodels.size)
        if differentmodels[i] >= differentmodels[j]
            differentmodels[i],differentmodels[j] = differentmodels[j],differentmodels[i]
       end 
    i+=1
    j+=1
  end
 end
    
 return differentmodels.last
end

#######################################################################
#this fucntion is to get the 10 cheapest items of certain cloth type
#I will use the *QUICK SORT* here since the price is totally disordered .
#All I need to do is to get rid of the duplicate model number and get the price information
#######################################################################
def Reorderbyprice(newpricechecknbr)
 # the following line are put different model numbers into an array    
    differentmodels = Array.new
    File.open("inventory.txt") do |f|
      f.each_line do |line|
        if line[0] == newpricechecknbr
          tempnumbers = line[5,3] + line[0,4]
          unless differentmodels.include?(tempnumbers)
          differentmodels << tempnumbers 
          end
        end
      end
    end
    differentmodels = quicksort(differentmodels)

    
end 
#               *QUICK SORT*    |
#               *QUICK SORT*    |
#               *QUICK SORT*    |
#               *QUICK SORT*    |
#               *QUICK SORT*    |
#               *QUICK SORT*    V
def quicksort(array)
      return array if array.length <= 1
      pivot = array[array.length - 1]
      left, right = array[0..-2].partition { |x| x < pivot }
      quicksort(left) + [pivot] + quicksort(right)
end

#######################################################################
#this fucntion is to sort the inventory.
#I will use the *BUBBLE SORT* here since the Model Number is almost sorted already.
#All I need to do is to get rid of the duplicate model number
#######################################################################
def Reorderinventory()
  # the following line are put different model numbers into an array 
   count = 0
    File.open("inventory.txt")do |f|
    count = f.read.count("\n")
    end
    lines = File.readlines("inventory.txt")
      i=0
     while i < count-1
      j=0
      while j < count-i-1
       if lines[j] > lines[j+1]
         sssss   = lines[j]
         lines[j] = lines[j+1]
         lines[j+1] = sssss
       end
       j+=1
      end
       i+=1
     end  
    File.open("inventory.txt", 'w') { |f| f.write(lines.join)}
  
end
#######################################################################
#this fucntion is to check whether the user input a correct model number
#######################################################################
def checkmodelnbrs(inputchecknbr)
  checknbrsflag = 0
    File.open("inventory.txt") do |f|
      f.each_line do |line|
          if line.match(inputchecknbr)&& inputchecknbr.length == 4&& inputchecknbr !~ /\D/
            checknbrsflag = 1
          end
      end
    end
    return checknbrsflag
end  
#######################################################################
#this fucntion is to check whether the user input a correct size input
#######################################################################
def checksize(inputchecksize)
    checksizesflag = 0
    if ['XS', 'SS', 'MM', 'LL','XL','XX'].include? inputchecksize
          checksizesflag = 1
    end      
    return checksizesflag
end 

#**************************************************#
#****************************************************#
#******************************************************#
#********************************************************#
#**********************************************************#
#************************************************************#
#**************************************************************#
#****************************************************************#
#******************************************************************#
#********************************************************************#
#**********************************************************************#
########################################################################
# Main functions list#
# Main functions list#
# Main functions list#
# Main functions list#
# Main functions list#
########################################################################
#**********************************************************************#
#This are the instructions that provide the guide in the TUI
#Different number will means different functions
puts "Welcome to Storage Management System \n Please hit enter to continue"

#This is to read the history of orders still not been processed in orderbook 
currentOrders = PriorityQueue.new
file='orderbook.txt'
File.readlines(file).each do |line|
   order_split = line.split(/[\s,]+/)
   priority    = order_split [0].to_s
   orderDetail = order_split [1].to_s
   currentOrders << MakeOrder.new(priority ,orderDetail)
end



while step1 = gets.chomp
# the upper sentence is to get input from user to perform a function 

 #utlize the first step input to perform the next step
 #in this Second step user may still need to choose a number for the subfunctions
 case step1
 #**********************************************************************#
 #{year.to_i.to_s(16)}
 when '0'
   File.open('orderbook.txt', 'w+') do |file|
     for i in 0..currentOrders.orderssize-2
       orders_infor = currentOrders.pop
       file.write("#{orders_infor.priority},#{orders_infor.orderDetail.to_s}\n")
      end
    end
   puts "Goodbye!"
  break 
 #**********************************************************************#
 
 when '1'
  puts "Please input the item number of the cloth"
  modelnbr=gets.chomp
  if (checkmodelnbrs(modelnbr)==1)
          File.open("inventory.txt") do |f|
           f.each_line do |line|
             if line.match(modelnbr)
                 @items= "#{line}"            # puts @@items
             end
           end
          end
     DDDDD= Readnumber.new(@items)
     puts DDDDD.modelnames
  else
    puts  "Wrong input model number","Please check the inputs and test it again \n"
  end
  
 #**********************************************************************#
 
 when '2'
  puts "Please input the item number of the cloth"
  modelnbr=gets.chomp
  if checkmodelnbrs(modelnbr)== 1 
       File.open("inventory.txt") do |f|
          f.each_line do |line|
            if line.match(modelnbr)
             @items= "#{line}"            # puts @@items
            end
         end
        end
      EEEEE= Readnumber.new(@items)
      puts EEEEE.clearenceornot
    else
    puts  "Wrong input model number","Please check the inputs and test it again \n"
  end
  
 #**********************************************************************#
 
 when '3'
  puts "Please input the item number of the cloth"
  modelnbr=gets.chomp
  modelnbr=modelnbr.to_s
  puts "Please input the item size of the cloth"
  modelsize=gets.chomp.to_s
  puts "\n"
  
  if checkmodelnbrs(modelnbr)*checksize(modelsize) == 1
  
    inventoryflag = 0

     File.open("inventory.txt") do |f|
      f.each_line do |line|
       if line.match(modelnbr)&&line.match(modelsize)
         @items= "#{line}" 
         @FFFFF= Readnumber.new(@items)
          puts "Location",@FFFFF.locations,"Quantity", @FFFFF.stocks 
          puts "\n"
          inventoryflag = 1 
       end
      end
        if inventoryflag == 0
          puts "0 stocks in every locations"
        end
        f.close
     end
   else
    puts  "Wrong input model number","Please check the inputs and test it again \n"
  end
 #**********************************************************************#
 
 when '4'
  puts "Please input the item number of the cloth"
  modelnbr=gets.chomp
  if checkmodelnbrs(modelnbr)== 1 
      File.open("inventory.txt") do |f|
       f.each_line do |line|
        if line.match(modelnbr)
          @items= "#{line}"            # puts @@items
        end
        end
       end
      DDDDD= Readnumber.new(@items)
      print "\n","Price: $",DDDDD.prices 
  else
    puts  "Wrong input model number","Please check the inputs and test it again \n"
  end
 #**********************************************************************# 
 
 when '5'
    # For the new items, they will have every sizes at every location with stock number as 100
    # All the new items will be not clearence items
    # So new numbers will be ****N***XS100MI, ****N***XS100OH, ****N***XS100CA, ****N***XS100NY
    #                   and  ****N***SS100MI, ****N***SS100OH, ****N***SS100CA, ****N***SS100NY
    #                   and  ****N***MM100MI, ****N***MM100OH, ****N***MM100CA, ****N***MM100NY
    #                   and  ****N***LL100MI, ****N***LL100OH, ****N***LL100CA, ****N***LL100NY
    #                   and  ****N***XL100MI, ****N***XL100OH, ****N***XL100CA, ****N***XL100NY
    #                   and  ****N***XX100MI, ****N***XX100OH, ****N***XX100CA, ****N***XX100NY
    # Also the new number need to be the next avalible number for example:
    # right now the new Tshirt number is  0015******** the next number need to be 0015******** 
    # We need a sort of the current four digit numbers to determin which will be the next aavliable number 

    # Get the model type of the new item
    puts "Please select the type of the new cloth"
    puts "Tshirt    Press 0"
    puts "Sweater   Press 1"
    puts "Dress     Press 2"     
    puts "Shorts    Press 3"     
    puts "Skirt     Press 4"     
    puts "Pants     Press 5"     
    puts "Jacket    Press 6"     
    puts "Scarf     Press 7"     
    puts "Coats     Press 8"     
    puts "Others    Press 9"
    puts "\n"
    
    newtypenbr = gets.chomp
    # get the new model number of the new item
    newrandomnbr = Reorderbymodel(newtypenbr).to_i + 1 
    newrandomnbr = newtypenbr + "%03d" % newrandomnbr.to_s
    puts "This will be the new model number:", newrandomnbr
    
   
    # get price of the new item
    puts "Please provide the price of this item"
    puts "Price will be between bigger than 0 and smaller than 999"
    puts "\n"
    newprice = gets.chomp
  if  (['0','1','2','3','4','5','6','7','8','9'].include? newtypenbr and newprice !~ /\D/ and ((newprice.to_i) > 0) and newprice.to_i < 1000 ) 
        newprice = newprice.to_i
        newprice = "%03d" % newprice.to_s
    sizesets     = ["XS","SS","MM","LL","XL","LL"]
    locationsets = ["CA","MI","NY","OH"]

   # we need to write these files into the inventory
    open('inventory.txt', 'a') do |f|
       #These while loop will create all the new numbers
       i = 0
       while i < 6
         j = 0
          while j < 4
            newsmartnumber = newrandomnbr + "N" + newprice + sizesets[i] + "100" + locationsets[j]
            f.write("#{newsmartnumber}\n")
            j=j+1
          end
         i = i + 1 
       end
       f.close 
     end 

    # we need reorder the inventory. The Reorderinventory will help us do this functions
      Reorderinventory()
  else
    puts  "Wrong input model number","Please check the inputs and test it again \n"
  end
 #**********************************************************************#
 
 when '6'
    #This will help the employee to delete the obselete part numbers, this function will help to save some inventory. But this number will not used for new items to avoid making confusions.
      testnbr = 0
      puts "Please input the item number of the cloth you want to delete"
      modelnbr=gets.chomp
  if checkmodelnbrs(modelnbr)== 1        
    #The following are the code that will delete the obseleted item lines
     read_file = File.new('inventory.txt', "r").read
     write_file = File.new('inventory.txt', "w")

     read_file.each_line do |line|
      if line.match(modelnbr)
        testnbr=1
      end
     write_file.write(line) unless line.include? modelnbr.to_s
     end
    f = File.open('inventory.txt')
    f.close
     
    #This is the line told the employee the delete is success or the number iput is invalided
     if testnbr == 1
       print "Item ", modelnbr, " has been deleted successfully"
      else
       print "Item ", modelnbr, " is not a valid number, please try again"
    end 
   else
    puts  "Wrong input model number","Please check the inputs and test it again \n"
  end  
 #**********************************************************************#
 
 when '7'
    # This will provide us the cheapest 10 items of certain type
    # function reorderbyprice will be used for this target
    # Get the model type of the new item
    puts "Please select the type of you wanna to check"
    puts "Tshirt    Press 0"
    puts "Sweater   Press 1"
    puts "Dress     Press 2"     
    puts "Shorts    Press 3"     
    puts "Skirt     Press 4"     
    puts "Pants     Press 5"     
    puts "Jacket    Press 6"     
    puts "Scarf     Press 7"     
    puts "Coats     Press 8"     
    puts "Others    Press 9"
    puts "\n"
    
    newpricechecknbr = gets.chomp
    cheapestten = Reorderbyprice(newpricechecknbr)
  if  (['0','1','2','3','4','5','6','7','8','9'].include? newpricechecknbr) 
       #This is the output 
       if cheapestten.count > 9
         puts "These are the cheapest 10 items: "
         itemranges = 10
       elsif cheapestten.count == 0
             itemranges = cheapestten.count
        puts "There is no items of this type, please try another type"
       else
         print "There are only ", cheapestten.count, " items \n"
         puts "These are items sorted by price"
         itemranges = cheapestten.count
       end 

       i=0
       while i<itemranges
        print i+1,". Item number: ",cheapestten[i].split(//).last(4).join, ", price: $" ,cheapestten[i].split(//).first(3).join.to_i,"\n"
        i=i+1
       end
    else
    puts  "Wrong input information","Please check the inputs and test it again \n"
 end         
 #**********************************************************************#
 
 when '8'
  # this will allow the employee to make an order for customers
  # After make a purchase the stock quantity will decrease. 
  # So this need to modify a line in the inventory
  
    # First we need to figure out which product the customer want to purchase
    puts "Please input the item number of the cloth"
    modelnbr=gets.chomp
    puts "Please input the item size of the cloth"
    modelsize=gets.chomp.to_s
    # Second we need to know how many do customer want.
    puts "How many pieces are customer want to buy?"
    modelpieces=gets.chomp
    puts "Please provide the priority of the order 5 is highest 1 is lowest"
    orderPriority=gets.chomp
    
    
    # Third we also need to know where is the purchase happened
    puts "Please indicate your locations"
    puts "CA Press 1", "MI Press 2","NY Press 3","OH Press 4"
    saleslocationsinput=gets.chomp
      case saleslocationsinput
       when '1' 
        saleslocations = 'CA'
       when '2' 
        saleslocations = 'MI'  
       when '3' 
        saleslocations = 'NY'    
       when '4' 
       saleslocations = 'OH'     
      end
     
    puts "\n"
   # With all above lines we have all the information of the order
  if (checkmodelnbrs(modelnbr)*checksize(modelsize) == 1 and ['1','2','3','4'].include?saleslocationsinput)
    # The following codes are to modify the lines in the inventory.
     inventoryflag = 0
    flagsofstorage = 0
      File.open("inventory.txt") do |f|
      f.each_line do |line|
        if line.match(modelnbr)&&line.match(modelsize)&&line.match(saleslocations)
           HHHHH = "#{line}"
           inventoryflag = 1 
                # if this is not enough stock of this product, it will print a warning.
                if HHHHH[10,3].to_i < modelpieces.to_i
                     puts "Sorry there is not enough stock in this location"
                     GGGGG = HHHHH
                    flagsofstorage = 1
                  end
         GGGGG =HHHHH[0,10]+ "%03d" % (HHHHH[10,3].to_i - modelpieces.to_i).to_s+HHHHH[13,2]+"\n"
         end          
        end 
       end

        if flagsofstorage != 1
         file_names = ["inventory.txt"]
           file_names.each do |file_name|
                text = File.read(file_name)
                new_contents = text.gsub(HHHHH, GGGGG)
           File.open(file_name, "w") {|file| file.puts new_contents }
           puts "Successfully make this order"
           currentOrders << MakeOrder.new(orderPriority ,modelnbr << modelsize << modelpieces << saleslocations)
           print "There are still ", HHHHH[10,3].to_i - modelpieces.to_i," pieces of ",  HHHHH[0,4], " left in ", HHHHH[13,2]+"\n"
         end
        end
         if inventoryflag == 0
            puts "0 stocks in every locations"
         end
   else
    puts  "Wrong input information","Please check the inputs and test it again \n"
 end      
       
 #**********************************************************************#
 when'9'
   
  puts "NEXT ORDER TO BE PROCCESSED IS :"
  puts currentOrders.pop.orderDetail
  puts "\n"
   
 #**********************************************************************#   
    
    
 end 
 #end of the case step1
     puts "\n**************************************************************************"
     puts "Welcome to Storage Management System"
     puts "**************************************************************************"
     puts "Press 0 to exit this system\n"
     puts "Press 1 for check an item style\n"
     puts "Press 2 for check whether this item is in clearence or not\n"
     puts "Press 3 for check the location and stock of certain item\n"
     puts "Press 4 for the price of certain item\n"
     puts "Press 5 to add a new item into inventory\n"
     puts "Press 6 to delete an item from inventory\n"
     puts "Press 7 to provide 10 cheapest model number wihich is sorted by price\n\n"
     puts "About orders"
     puts "Press 8 to place an order\n"   
     puts "Press 9 to process an order with the highest priority\n" 
     puts "\n"
     puts "\n"

end 
#end of while loop 

