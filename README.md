# DeepLinks 

```bash
> adb shell 'am start -a android.intent.action.VIEW \
-c android.intent.category.BROWSABLE \
-d "routingdemo://open.my.app/home/cart"' \
com.example.routing_demo

> adb shell 'am start -a android.intent.action.VIEW \
-c android.intent.category.BROWSABLE \
-d "https://routingdemo.example.com/home/shop/item/"' \
com.example.routing_demo


> xcrun simctl openurl booted routingdemo://open.my.app/home/shop
```
