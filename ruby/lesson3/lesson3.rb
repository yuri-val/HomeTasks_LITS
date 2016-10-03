#  lesson3.rb

def bin_to_dec bin_num
  bin_str = bin_num.to_s
  if bin_str == "0" then
    return "0"
  end
  dec_val = 0
  n = 0
  until bin_str == nil do
    l_symb = bin_str[bin_str.size - 1]
    dec_val = dec_val + l_symb.to_i * (2 ** n)
    n = n + 1
    bin_str = bin_str.slice(0, bin_str.size - 1)
  end
  return dec_val
end

def dec_to_bin dec_num
  dec_val = dec_num.to_i
  if dec_val == 0 then
    return 0
  end
  bin_num = ""
  until dec_val == 0 do
    modulo = dec_val % 2
    dec_val = (dec_val / 2).to_i
    bin_num = modulo.to_s + bin_num
  end

  return bin_num
end


dec_num = ARGV[0]
bin_num = ARGV[1]

b_dec_num = bin_to_dec bin_num
d_bin_num = dec_to_bin dec_num

puts "Decimal digit #{dec_num} -> #{d_bin_num}"
puts "Binary digit #{bin_num} -> #{b_dec_num}"
