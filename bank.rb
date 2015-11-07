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
        attr_accessor :interest_rate

        def initialize
            @accounts = Hash.new{|h,k| h[k] = BankAccount.new}
            @cash = 0
            @interest_rate = 0
            @bank_reserve
        end

        def deposit(person, amount)
            person.cash -= amount
            person.deposit += amount
            @cash += amount
            @accounts[person].deposit += (amount * (1 + @interest_rate / 2)).to_i
        end

        def borrow person, amount
            if amount > @cash
                puts "FATAL: Bank cannot borrow #{amount}, because it has only #{@cash}" 
                abort
            end
            loan = (amount * (1 + @interest_rate) + 1).to_i
            @accounts[person].loan += loan
            @cash -= amount
            person.cash += amount
            person.loan += loan
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
            if amount > @cash + @bank_reserve
                puts "FATAL: #{person.name} cannot withdraw #{amount}, because bank has only #{@cash} in cash + #{@bank_reserve} in Central Bank reserve" 
                abort
            end
            if amount > @cash
                puts "WARNING: Bank has only #{@cash} in cash, so if #{person.name} wants to withdraw #{amount}, bank has to use its reserve." 
            end
            deposit person, -amount
        end
   
        def update_reserve central_bank
            total_deposits = @accounts.values.inject(0){|sum, account| sum += account.deposit}
            required_reserve = total_deposits / 10

            delta_reserve = required_reserve - central_bank.bank_reserve

            @cash -= delta_reserve
            central_bank.bank_reserve += delta_reserve

            if @cash < 0
                puts "Bank is in trouble! It should have #{central_bank.bank_reserve} in Central Bank reserve, but it ran out of cash"
                central_bank.bank_reserve += @cash
                @cash = 0
            end

            @bank_reserve = central_bank.bank_reserve
        end

        def status
            return "[Bank] Cash: #{@cash}"
        end
    end
end