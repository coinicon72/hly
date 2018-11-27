# 1.1.1 2018-11-27
+ [x] [CHANGE] `销售明细`查询接口`api/orders`改为支持查询所有销售详情，包括未生产、未发货的
+ [x] [CHANGE] `采购明细`查询接口`api/purchasingOrders`改为支持查询所有采购详情，包括未入库的


# v1.1.0 2018-11-25
+ [x] [ADD] `销售明细`查询接口
+ [x] [ADD] `采购明细`查询接口


# v1.0.1 2018-11-04
+ [x] [ADD] add ```status``` to delivery-sheet. 0-just created; 1-committed (to repo)
+ [x] [ADD] add ```createdBy```, ```createdOn```, ```committedBy```, ```committedOn``` to delivery-sheet
+ [x] [ADD] can't commit a committed delivery-sheet

+ [x] [ADD] 从`发货单`生成`出库单`的接口
+ [x] [ADD] 生成`应收结算单`的接口


# 2018-08-24
+ [application.yaml] spring.data.rest.defaultPageSize => 200
+ [delivery sheet]

# 2018-08-23
## treat product as special material
+ add material first, then use material id as product id
+ Product model uses PrimaryKeyJoinColumn to connect to material (primary key as foreign key)