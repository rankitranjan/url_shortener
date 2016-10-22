#
# Base 36
# --------------------------
#
# It uses the same principal as normal base 36 operation but uses an array of random alphanumerics
#
module KgBase

  ARRAY = ['q','w','1','e','r','2','t','y','3','u','i','4','o','p','5','a','s','6','d','f','7','g','h','8','j','k','9','l','z','0','x','c','v','b','n','m']

  class << self
    def encode(num)
      str = ''
      temp = 0 + num
      while temp > 35
        i = temp/36
        str << ARRAY[temp - i*36]
        temp = temp/36
      end
      str << ARRAY[temp]
      return str.reverse
    end

    def decode(str)
      return nil if str.empty?
      temp = 0
      pos = 0
      str.reverse.each_char do |s|
        temp = temp + ARRAY.index(s)*(36**pos)
        pos = pos + 1
      end
      return temp
    end
  end
end
