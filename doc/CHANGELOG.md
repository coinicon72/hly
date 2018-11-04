# v1.0.1 2018-11-04
+ [ ] [ADD] add ```status``` to delivery-sheet. 0-just created; 1-committed (to repo)
+ [ ] [ADD] add ```createdBy```, ```createdOn```, ```committedBy```, ```committedOn``` to delivery-sheet
+ [ ] [ADD] can't commit a committed delivery-sheet


# 2018-08-24
+ [application.yaml] spring.data.rest.defaultPageSize => 200
+ [delivery sheet]

# 2018-08-23
## treat product as special material
+ add material first, then use material id as product id
+ Product model uses PrimaryKeyJoinColumn to connect to material (primary key as foreign key)