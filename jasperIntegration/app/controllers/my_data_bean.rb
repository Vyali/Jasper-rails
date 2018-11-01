class MyDataBean
    attr_accessor :country
  def initialize(n,c)
    name =n
    country = c
  end

    # def country = (c)
    #     @country = c
    # end

    # def name = (n)
    #     @name = n
    # end

    def name
        return @name
    end

    def deshhmera
        return @country
    end

end
