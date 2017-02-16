# SubwayCookieGenerator
Build. Setup server. Eat free cookies.




#Setting up the server.

```
sudo gem install sinatra
```
and 
```
pip install selenium
```

Then run it: 
```
  sudo ruby api.rb -o 0.0.0.0
```

If you will set up ddns or other service on your server then don't forget to change this line in RequestViewController.swift

```
let api_address = "http://localhost:4567"
```
to your own domain/ip address. 


Build your app and enjoy free cookies on the way :) 


You might want to have a look here in case you will face error 
```
selenium.common.exceptions.WebDriverException: Message: 'geckodriver' executable needs to be in PATH. 
```

http://stackoverflow.com/a/40208762/3595696
