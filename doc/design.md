有如下业务需求：
+ [出库单] 销售出库时，选择订单 改为 选择发货单
+ [出库单] 材料领用时，选择订单 改为 选择BOM单

```yaml
发货单deliverySheet:
    products:
        - productA
        - productB

BOM单bom:
    product: productB
```

可见，发货单对应多个产品，而bom单对应一个产品

