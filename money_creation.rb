require './person'
require './central_bank'
require './bank'

module MoneyCreation

    def MoneyCreation::action description
        puts "\n[Action] #{description}"
    end

    def MoneyCreation::print_status central_bank, people, bank
        puts central_bank.status
        puts "Person               Cash        Loan     Deposit       Total"
        people.each{|p| puts p.status}
        total_cash = people.inject(0){|sum,person| sum += person.cash} + central_bank.bank_reserve + bank.cash
        total_loan = people.inject(0){|sum,person| sum += person.loan}
        total_deposit = people.inject(0){|sum,person| sum += person.deposit}
        puts "Central bank    #{'% 9d' %central_bank.bank_reserve}"
        puts "Bank            #{'% 9d' %bank.cash}" 
        puts "Total           #{'% 9d' %total_cash}\t#{'% 9d' %total_loan}\t#{'% 9d' %total_deposit}\t#{'% 9d' %(total_cash+total_deposit-total_loan)}"
        puts bank.status
    end

    central_bank = CentralBank.new
    bank = Bank.new
    people = Array.new

    bank_owner = Person.new("Bank owner")
    p1 = Person.new("Person 1")
    p2 = Person.new("Person 2")
    p3 = Person.new("Person 3")
    p4 = Person.new("Person 4")
    p5 = Person.new("Person 5")

    people << bank_owner
    people << p1
    people << p2
    people << p3
    people << p4
    people << p5

    action "Initial situation"

    print_status central_bank, people, bank

    action "Central Bank prints some money"

    central_bank.print_money 60

    print_status central_bank, people, bank

    action "Money is given to all people"

    central_bank.give_money(bank_owner, 10)
    central_bank.give_money(p1, 10)
    central_bank.give_money(p2, 10)
    central_bank.give_money(p3, 10)
    central_bank.give_money(p4, 10)
    central_bank.give_money(p5, 10)

    print_status central_bank, people, bank

    action "Bank owner establishes a bank"
    bank.deposit bank_owner, bank_owner.cash
    print_status central_bank, people, bank

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank

end