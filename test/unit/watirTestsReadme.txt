___INFO___

For the automated tests, we used Watir (watir.com), an open-source (BSD) family of Ruby libraries for automating web browsers.


---Watir Installation---

sudo apt-get install ruby1.9.1-dev 
sudo apt-get install rubygems
sudo gem install watir --no-rdoc --no-ri


---Executing Tests---

Each test can be executed through the shell, basically executing the respective Ruby file.

E.g: ruby QuestionTest.rb


---Tests Description---

The tests were constructed over the Watir API and use its functions to click buttons, fill text fields, search for text on the webpage (and others) to check whether the specified system is working correctly or not. The inputs were randomly generated. 


___TESTS___

___Researcher Account Test Case -> ResearcherTest.rb___

--Description: A test case to verify whether the system for "Create a new researcher account" is working properly or not.

--Test environment: The tests were executed on Ubuntu 12.10 with Ruby 1.9.3p194 (2012-04-20 revision 35410) [i686-linux]

--Features to be tested: "Create a new researcher account" form, adding new researcher to the database, new researcher info is displayed on admin page

--Features not to be tested: new researcher access to the system

--Test Oracle: If the account with the specified 'Name', 'Email' and 'Phone number' were created and it's shown on the "admin/researchers#index" page, the test passes. Otherwise, the test fails. 

--Test Results: All tests passed!
