require './person'
require './central_bank'
require './bank'

module MoneyCreation

    def MoneyCreation::action description
        puts "\n[Action] #{description}"
    end

    def MoneyCreation::print_status central_bank, people, bank
        puts central_bank.status
        puts "Person          Cash      Loan   Deposit     Total"
        people.each{|p| puts p.status}
        total_cash = people.inject(0){|sum,person| sum += person.cash} + central_bank.bank_reserve + bank.cash
        total_loan = people.inject(0){|sum,person| sum += person.loan}
        total_deposit = people.inject(0){|sum,person| sum += person.deposit}
        puts "Central bank #{'% 7d' %central_bank.bank_reserve}"
        puts "Bank         #{'% 7d' %bank.cash}" 
        puts "Total      #{'% 9d' %total_cash} #{'% 9d' %total_loan} #{'% 9d' %total_deposit} #{'% 9d' %(total_cash+total_deposit-total_loan)}"
        puts bank.status
    end

    central_bank = CentralBank.new
    bank = Bank.new
    people = Array.new

    bank.interest_rate = 0.20

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

    action "Bank borrows money to Person 1"
    bank.borrow p1, bank.cash
    print_status central_bank, people, bank

    action "Person 1 pays to Person 2"
    p2.cash += p1.cash
    p1.cash = 0
    print_status central_bank, people, bank

    action "Person 2 deposits all its money into the bank"
    bank.deposit p2, p2.cash
    print_status central_bank, people, bank

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank

    action "Person 3 pays to Person 2"
    p2.cash += p3.cash
    p3.cash = 0
    print_status central_bank, people, bank

    action "Person 2 deposits its new money into the bank"
    bank.deposit p2, p2.cash
    print_status central_bank, people, bank

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    

    action "Person 3 borrows money from the bank"
    bank.borrow p3, bank.cash
    print_status central_bank, people, bank        

    action "Person 3 pays again to Person 2"
    p2.cash += p3.cash
    p3.cash = 0
    print_status central_bank, people, bank

    action "Person 2 deposits its new money into the bank"
    bank.deposit p2, p2.cash
    print_status central_bank, people, bank

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    

    action "Person 4 borrows money from the bank"
    bank.borrow p4, bank.cash
    print_status central_bank, people, bank        

    action "Person 4 pays again to Person 2"
    p2.cash += p4.cash
    p4.cash = 0
    print_status central_bank, people, bank

    action "Person 2 deposits its new money into the bank"
    bank.deposit p2, p2.cash
    print_status central_bank, people, bank

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    

    action "Person 2 takes some of its money from the bank"
    bank.withdraw p2, p1.loan
    print_status central_bank, people, bank    

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    
    
    action "Person 2 pays to Person 1"
    p2.cash -= p1.loan
    p1.cash += p1.loan
    print_status central_bank, people, bank    

    action "Persion 1 returns its loan"
    bank.return p1, p1.loan
    print_status central_bank, people, bank    

    action "Person 2 takes more of its money from the bank"
    bank.withdraw p2, p3.loan
    print_status central_bank, people, bank    

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    

    action "Person 2 pays to Person 3"
    p2.cash -= p3.loan
    p3.cash += p3.loan
    print_status central_bank, people, bank    

    action "Person 3 returns its loan"
    bank.return p3, p3.loan
    print_status central_bank, people, bank    

    action "Person 2 takes more of its money from the bank"
    bank.withdraw p2, p4.loan
    print_status central_bank, people, bank    

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    

    action "Person 2 pays to Person 4"
    p2.cash -= p4.loan
    p4.cash += p4.loan
    print_status central_bank, people, bank    

    action "Person 4 returns its loan"
    bank.return p4, p4.loan
    print_status central_bank, people, bank    

    action "Person 2 takes all the rest its money from the bank"
    bank.withdraw p2, p2.deposit
    print_status central_bank, people, bank    

    action "Bank has to update its reserve"
    bank.update_reserve central_bank
    print_status central_bank, people, bank    

end