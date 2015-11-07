module MoneyCreation

    class BankAccount
        attr_accessor :deposit
        attr_accessor :loan

        def initialize
            @deposit = 0
            @loan = 0
            @bank_reserve = 0
        end
    end

    class Bank

        attr_reader :cash

        def initialize
            @accounts = Hash.new{|h,k| h[k] = BankAccount.new}
            @cash = 0
        end

        def deposit(person, amount)
            person.cash -= amount
            person.deposit += amount
            @cash += amount
            @accounts[person].deposit += amount
        end

        def update_reserve central_bank
            total_deposits = @accounts.values.inject(0){|sum, account| sum += account.deposit}
            required_reserve = total_deposits / 10

            delta_reserve = required_reserve - central_bank.bank_reserve

            @cash -= delta_reserve
            central_bank.bank_reserve += delta_reserve
        end

        def borrow person, amount
            abort "Bank has not enough cash to borrow #{amount}" if amount > @cash
            @accounts[person].loan += amount
            @cash -= amount
            person.cash += amount
            person.loan += amount
        end

        def return person, amount
            borrow person, -amount
        end

        def deposit person, amount
            @accounts[person].deposit += amount
            @cash += amount
            person.cash -= amount
            person.deposit += amount
        end

        def withdraw person, amount
            abort "#{person.name} cannot withdraw money, because bank has only #{@cash}" if amount > @cash
            deposit person, -amount
        end
        def status
            return "[Bank] Cash: #{@cash}"
        end
    end
end