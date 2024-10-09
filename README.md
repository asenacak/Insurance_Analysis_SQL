# Insurance Analysis Using SQL
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-12.3-336791.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)


## Dataset
This dataset consists of four data files, which are related by linking through either **individual_id** or **address_id**.

1) **Address Data:** This data file contains address and geographic information and consists of 1,536,673 rows. The variables are:
   * **address_id**: Unique ID for a specific address.
   * **latitude**: Latitude of the address.
   * **longitude**: Longitude of the address.
   * **street_address**: Mailing address.
   * **city**: City.
   * **state**: The state, which is Texas.
   * **county**: County.

   The primary key of this table/data file is **address_id**.

2) **Customer Data:** This data file contains customer information and consists of 2,280,320 rows. The variables are:
   * **individual_id**: Unique ID for a specific insurance customer.
   * **address_id**: Unique ID for the primary address associated with a customer.
   * **curr_ann_prem**: The annual dollar amount paid by the customer. This is not the policy amount, but the amount the customer paid during the previous year.
   * **days_tenure**: The number of days the individual has been a customer with the insurance agency.
   * **cust_orig_date**: The date the individual became a customer.
   * **age_in_years**: The age of the individual.
   * **date_of_birth**: The individual’s date of birth.
   * **soc_sec_number**: Social Security Number, where the middle two digits are replaced with "XX" to prevent exposure of actual SSNs.

   The primary key of this table/data file is **individual_id**, and the foreign key is **address_id**.

3) **Demographic Data:** This data file contains demographic information and consists of 2,112,579 rows. The variables are:
   * **individual_id**: Unique ID for a specific insurance customer.
   * **income**: Estimated income for the household associated with the individual.
   * **has_children**: A flag indicating whether the individual has children in the household (1 if yes, 0 otherwise).
   * **length_of_residence**: Estimated number of years the individual has lived in their current residence.
   * **marital**: Estimated marital status (Married or Single).
   * **home_market_value**: Estimated value of the home.
   * **home_owner**: A flag indicating whether the individual owns their primary home (1 if yes, 0 otherwise).
   * **college_degree**: A flag indicating whether the individual has a college degree or higher (1 if yes, 0 otherwise).
   * **good_credit**: A flag indicating whether the individual has a FICO score greater than 630 (1 if yes, 0 otherwise).

   The primary key of this table/data file is **individual_id**.
   
4) **Termination Data:** This data file contains account suspension or cancellation information and consists of 269,259 rows. The variables are:
   * **individual_id**: Unique ID for a specific insurance customer.
   * **acct_suspd_date**: Day of account suspension or cancellation.
  
   The primary key of this table/data file is **individual_id**.
