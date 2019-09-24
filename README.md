# Access By Ip
Is a project of security login that ensure only the desired users can be enter on the website is very useful for:
* Office environment.
* Banks.
* Closed enterprises.
* And many others that need this security system.

### Installation
Clone this repository, you will need:
* ruby 2.4.6
* rails 4.2.11.1
* nvm or rbenv
* postgresql
* execute bundle install
* execute rake db:create db:migrate db:seed

### How it woks
#### Algorithm
1) First we need a list of valid ips, this list is given by the enterprise or employees for set up the app.

2) The next step its define the relationships, these are:
* A company has many users of the system.
* A user belongs to a company.
* A company has a white list.
* A white list has many ip address.
* An ip belongs to a white list.

3) Done so, now we will define the rules of sign in.
* A SuperUser or AdminUser can access without ip restriction.
* A tipic user only can access to the app if his ip is registered.
* If a company has not a white list there is not ip restriction.

4) The next step its define all logic in the framework

* For this we need to create all corresponding models and relationships
and also we need define the logic of the methods, the most important method should be authenticate_ip_addreess. We need to be careful and reflect all rules of sign in at this point.

 ###### Don't forget its a good practice to develop our apps using TDD if you don't know what is TDD here is an example [Click me](https://wdi-sg.github.io/gitbook-2018/06-ruby-rails/ruby-tdd/readme.html)