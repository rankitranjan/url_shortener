module CommonHelper

  class << self
    def decode(str)
      id = KgBase.decode(str) rescue nil
      return ['',nil] if !id
      return ['ShortUrl',id-10000000000] if id > 10000000000
      return ['',nil]
    end

    def encode(c,id)
      temp = 10000000000
      return KgBase.encode(temp + id)
    end
  end
end