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
