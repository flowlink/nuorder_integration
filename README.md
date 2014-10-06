Wombat NuOrder Integration Service
==================================

Dedicated integration between Wombat and NuOrder.
For further information about Wombat project and integrations please visit 
https://support.wombat.co/hc/en-us

Supported Webhooks
------------------

| # | Object (Wombat) | Wombat Webhook  | NuOrder API                 |
|---|-----------------|-----------------|-----------------------------|
| 1 | Order           | /get_orders     | /api/orders/{status}/detail |
| 2 | Product         | /add_product    | /api/product/new            |
| 3 | Product         | /update_product | /api/product/{id}           |
| 4 | Product         | /get_products   | *To be implemented*         |
| 5 | Inventory       | /set_inventory  | /api/inventory/{id}         |
| 6 | Customers       | /get_customers  | *To be implemented*         |
| 7 | Order           | /cancel_order   | /api/order/{id}/cancel      |

1. Gets all orders in `approved` and `edited` status. Webhook marks each order 
   as `processed` using the NuOrder API call `/api/order/{id}/process`.
2. Creates a new product in NuOrder. Saves the `nuorder_id` back in Wombat for later updates.
   Creates also an *inventory record* in Wombat with the `nuorder_id` with inventory 0.
3. Updates the product in NuOrder.
4. **(Not ready yet)** Gets all products form NuOrder based on last modified date.
5. Updates inventory in NuOrder using `nuorder_id`.
6. **(Not ready yet)** Gets a list of customers from NuOrder based on last modified.
7. Marks the order as cancelled. Assumption is that the order is cancelled in ERP.

NuOrder Endpoint Url
--------------------

There are few ways to set endpoint url for calling NuOrders API.
Below are listed ways to set it ordered by priority, starting with highest:
  * `endpoint` parameter passed in POST parameters
  * `ENV['NUORDER_ENDPOINT']` variable
  * If any of above is not present, url is defaulted to `http://wholesale.nuorder.com`

If you want to run this service in NuOrders sandbox mode you should set endpoint url
to e.g. `http://sandbox1.nuorder.com`


Copyright (c) 2014 [Netguru](https//netguru.co). See LICENSE for further details.
