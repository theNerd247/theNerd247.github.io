---
title: Budget Language Plans
tags:
  - programming
  - languages
  - budget
---

# Current Workflow

Download CSV
 ↓
Parse CSV files into a ledger (assigns transactions to accounts using
description text)
 ↓
Validation script runs 
 ↓
Apply an overlays file (manual transactions) ←──────────────┐
 ↓                                                          │
Apply Budget file (contains only pseudo transactions)       │
 ↓                                                          │
General Reports ────────────────────────────────────────────┘


# Sample Syntax Bits

  ```
  foodBudget : Transactions -> Bool
  foodBudget = 
    \transactions -> 
         filterByAccountName "expenses:food" 
      .> filterByDateRange (lastMonth, endOfThisMonth)
      .> accountSum 
      .> (< $100)
  ```

  ```
  foodBudget = simpleBudget 
    expenses:food 
    (2nd of month starting 2020-02) 
    $100.00
  ```

  ```
  foodImports = imports (from assets:checking to expenses:food)
    [ description /Costco/ && amount < 200
    , description /Kroger/ 
    , description /pizza/
    ]
  ```

  ```
  churchImports = imports (toAccount expenses:church)
    [ description ''
    ]
  ```

  ```
  # Planning for giving to church
  # This combines budgeting an amount as well as an CSV importer statement
  givingPlanning =
    expect  
      amount = $813.25  ───────────────────────────────────┐
        && isEFT                Import Modifier / Query Statement (Predicate?) 
        && desc /Breeze/                                   │
        && between 2020-03-12 + 7d                         │
        && assets:checking ~> expenses:church:giving ──────┘
  ```
I really like this. It's straight and to the point and gives a more explicit
statement of what I expect to happen. This would essentially produce 2
statements:

  ```
  # Here the query is the same as above but the account query is removed
  # and is turned into a transaction modifier. This is what would run
  # on the import side of things.
  givingPlanningImport = import
      amount = $813.25 
        && isEFT 
        && desc /Breeze/
        && between 2020-03-12 + 7d
      (from assets:checking . to expenses:church:giving) 

  # This is the generated budget. It only includes the amount
  # and a general account to/from statement. This would capture
  # ALL transactions within this account for that time period.  
  givingPlanningBudget = 
    amount = $813.25 
    between 2020-03-12 + 7d
    assets:checking ~> expenses:church:giving
  ```
This makes me wonder if using `expect` would provide more information than just
"You met / did not meet" for this account.  Instead `expect` would look for
specific transactions regardless of the account. Furthermore a transaction is a
its query.  For example: having a statement that says "assets:checking ~>
expenses:food" (desc /burger/ || desc /pizza/ || desc /Kroger/ || etc.) is just
applying a morphism over a sub-set of the transactions (those that match the
given query. So then The transactions `assets:checking ~> expenses:food` are
1-1 with the query - the query is the transactions.  An account is just the
transaction sets over all queries that contain the account name in either the
`from` or `to` part of the modifier. To summarize:

  * transactions 1-1 with queries
  * accounts are queries over transactions
This brings up 2 questions:
  
  1. How do I make a budget for an account?
  1. How do I account for the unexpected. 
If I formulate budgets using `expect` then I know i've met that budget if the
query returns a non-empty set of transactions. Here's an example:

  ```
  foodBudetMay2020 = expect
         isFoodExpense
      && between 2020-03-01+1mo 
      && totalAmount <= $350.00

  isFoodExpense = expect
    anyOf
      [ desc /Kroger/
      , desc /Publix/
      , desc /Costco/ && amount < $150
      ]
    && assets:checking ~> expenses:food
  ```
To verify a query is correct:

  ```
  simulate foodBudetMay2020 
  ```

# Query Model

```{.haskell}
-- the input is the set of transactions currently
-- being queried (previous state). Updated state 
-- is the left over transactions to run along with 
-- the left over transactions to query with next
Query :: State Transactions Transactions

&&, ||            :: Query -> Query -> Query
(<, <=, =, >=, >) :: Amount -> Amount -> Bool 
between           :: DateRange -> Query
not               :: Query -> Query
desc              :: Regex -> Query
from              :: Account -> Query
to                :: Acount -> Query
(~>)              :: Account -> Account -> Query
modify            :: (Transaction -> Transaction) -> Query -> Query
amount            :: (Amount -> Bool) -> Query
totalAmount       :: (Amount -> Bool) -> Query
simulate          :: DateRange -> Query -> Query
simulateRegex     :: Regex -> String
simulateTrans     :: Date -> Query -> Maybe Transaction

Text    :: Text
Num     :: Double
Bool    :: Bool
Regex   :: Regex
Account :: NonEmpty Text

-- It might be useful to make Queries 1st class citizens...
named      :: Text -> Query -> Query
appendName :: Text -> Query -> Query
```

# Syntax Features
  
Comments: only `#` character at beginning of line - maybe rest of line?

`from` and `to` in the context of an import are modifiers - they change the
matching transactions `from` and `to` fields. In the context of `budget` they
are predicates.

`expect` budget $$$ as well as create an importer statement. This is usefull
for 1-off planning for unique events. This happens because planning for a
specific amount implies an import statement with the same amount.

`between` allows budgets stating when we expect a transaction to occur.  This
allows the user to account for things like a transaction appearing late in
their bank account. For example I expect to pay for BCM at costco this saturday
but allow for 5 days for that transaction to occur

`amount` would query the amount for a single transaction

`totalAmount` would query the sum total of transactions.

`~>` could be a short hand for `from acc to acc` statements.


`simulate` would be a function taking a query and then generating a set of
transactions such that the given query holds. This means we'll need a way 
to generate strings from a regex such that the regex matches that string.
