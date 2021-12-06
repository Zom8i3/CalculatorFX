# /////----WELCOME-----/////

FX_Waluta_5000 is a web aplication that allows for recieving the latest and histrorical currency rates from the Narodowy Bank Polski (NBP) API.  
After loading the application into IntelliJ and running the Spring Boot Aplication, the user is asked to go to localhost:8080/start to load the start page.
On the start page, all currencies are retrieved from NBP and populated on the drop down menu, where the user selects one and submits the request for information about
this currency.  

The next page that loads contains information about the currency selected such as the name, code and last available rate.  
Below this information, the user can see the historical rates from the past 7 business days which are updated in the database everytime a currency request is made
for a listed currency.

At the bottom of the page, the banker can enter the amount for foreign currency and the rate at which to but or sell.  The value of the transaction is dynamically shown 
as the user inputs the rate and quantity.  Once the BUY or SELL button is clicked, this transaction is added to the database.  

Under "Transaction History" section, the user can retrieve all transaction within a range of days, and if such transactions exist, all will be populated below.  
If no transactions exist in the date range none will be shown.

Please note, that in the Spring  application.properties file, you can see that this webapp connects to an actual MYSQL server.  

# /////----TECHNOLOGIES UTILIZED----/////
1.Backend: Java and Spring Hibernate framework, MySQL

2.Frontend: Javascript, CSS, HTML, Bootstrap


