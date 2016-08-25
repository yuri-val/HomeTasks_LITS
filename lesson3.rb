#  lesson3.rb
#  
#  Copyright 2016 Yuri Valigursky <yuri.valigursky@gmail.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

def bin_to_dec bin_num
  bin_str = bin_num.to_s
  dec_val = 0
  n = 0
  until bin_str == nil do
    l_symb = bin_str[bin_str.size - 1]
    dec_val = dec_val + l_symb.to_i * (2 ** n);
    n = n + 1
    bin_str = bin_str.slice(0, bin_str.size - 1)
  end
  return dec_val
end

def dec_to_bin dec_num
  dec_val = dec_num.to_i
  bin_num = ""
  until dec_val == 1 do
    modulo = dec_val % 2
    dec_val = (dec_val / 2).to_i
    bin_num = modulo.to_s + bin_num
  end
  if dec_num.to_i > 2 then
	bin_num = "1" + bin_num 
  end
  return bin_num 
end


dec_num = ARGV[0]
bin_num = ARGV[1]

puts "Arguments are: #{ARGV}"

b_dec_num = bin_to_dec bin_num
d_bin_num = dec_to_bin dec_num

puts d_bin_num, b_dec_num


