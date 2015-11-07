module MoneyCreation
    class Person
        attr_accessor :cash
        attr_accessor :deposit
        attr_accessor :loan

        def initialize(name)
            @name = name
            @cash = 0
            @deposit = 0
            @loan = 0
        end

        def status
            return "#{@name}\t\t#{'% 9d' %@cash}\t#{'% 9d' %@loan}\t#{'% 9d' %@deposit}\t#{'% 9d' %(@cash+@deposit-@loan)}"
        end
    end
end