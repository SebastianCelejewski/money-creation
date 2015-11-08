# Money Creation

Simulation of money creation process.

## Model

### Actors
- Central Bank
- People (5 customers + 1 bank owner)
- Bank

### Rules
- Central Bank can print money
- Central Bank can give money to people for free
- Bank owner establishes a bank
- Bank has to keep a required reserve in the Central Bank
- Customers can borrow/return money
- Customers can deposit/withdraw money
- Customers can give money to other customers (pay for work, for goods, etc.)
 
### Calculations
- All actors can have cash, loan and deposits
- M0 (monetary base) = cash
- M3 (money supply) = cash + deposist

## Usage

`Usage: ruby money_creation.rb <required_reserve_%> <loan_interest_rate_%> <deposit_interest_rate_%>`

Example:

`ruby money_creation.rb 10 20 10`

## Screenshot

![Screenshot](https://raw.githubusercontent.com/SebastianCelejewski/money-creation/master/doc/money_creation.png)
