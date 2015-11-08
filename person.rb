module MoneyCreation
    class Person
        attr_accessor :name
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
            return "#{'%-10s' % @name} #{'% 9d' %@cash} #{'% 9d' %@loan} #{'% 9d' %@deposit} #{'% 9d' %(@cash+@deposit-@loan)} #{'% 9d' %(@cash+@deposit)}"
        end
    end
end