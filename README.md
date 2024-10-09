# Insurance Analysis Using SQL
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-12.3-336791.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)


## Dataset
This dataset consists of four data files, which are related by linking through either **individual_id** or **address_id**.

1) **Address Data:** This data file contains address and geographic information and 1,536,673 rows. The variables are:
    * address_id: Unique ID for a specific address.
    * lattitude: Lattitude of the address.
    * longitude: Longitude of the address.
    * street_address: Mailing Address.
    * city: City.
    * state: The state, which is Texas.
    * county: County.

  The primary key of this table/data file is **address_id**.

2) **Customer Data:** This data file contains customer information and 2,280,320 rows. The variables are:
   * individual_id: Unique ID for a specific insurance customer.
   * address_id: Unique ID for the primary address associated with a customer
   * curr_ann_prem: The Annual dollar value paid by the customer. It is not the policy amount. It is actually amount the customer paid during the previous year.
   * days_tenure: The time in days individual has been a customer with the insurance agency.
   * cust_orig_date: The data the individual became a customer.
   * age_in_years: Age of the individual.
   * date_of_birth: Individual's date of birth.
   * soc_sec_number: Social Security Number. Note the middle two digts are XX to prevent any coincidental actual SSNs from appearing.

   The primary key of this table/data file is **individual_id** whereas the foreign key is **address_id**.
