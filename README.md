Wombat NuOrder Integration Service
==================================

Dedicated integration between Wombat and NuOrder.
For further information about Wombat project and integrations please visit 
https://support.wombat.co/hc/en-us

NuOrder endpoint url
--------------------

There are few ways to set endpoint url for calling NuOrders API.
Below are listed ways to set it ordered by priority, starting with highest:
  * `endpoint` parameter passed in POST parameters
  * `ENV['NUORDER_ENDPOINT']` variable
  * If any of above is not present, url is defaulted to `http://wholesale.nuorder.com`

If you want to run this service in NuOrders sandbox mode you should set endpoint url
to e.g. `http://sandbox1.nuorder.com`
