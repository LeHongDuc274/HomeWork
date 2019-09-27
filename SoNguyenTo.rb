puts "nhập n: "
n = gets.to_i
puts ""
puts "các số nguyên tố < #{n}:"
if n<2 then puts "không có số nguyên tố nào @@"
	else
  		for i in 2..n
  			bol=0
  			for j in 2..Math.sqrt(i)
  				
  				if i % j ==0 then bol = 1
  				end
  			end

  		if bol == 0 then puts "#{i}\n"
  		end
  	end
end