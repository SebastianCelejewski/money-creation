module MoneyCreation
    class CentralBank

        attr_reader :cash
        attr_accessor :bank_reserve

        def initialize
            @cash = 0
            @monetary_base = 0
            @bank_reserve = 0
        end

        def print_money(amount)
            @monetary_base += amount
            @cash += amount
        end

        def give_money(person, amount)
            @cash = @cash - amount
            person.cash = person.cash + amount
        end
    end
end