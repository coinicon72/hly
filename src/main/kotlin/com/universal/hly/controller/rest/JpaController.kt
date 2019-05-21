@file:Suppress("unused")

package com.universal.hly.controller.rest

import com.universal.hly.dao.*
import com.universal.hly.model.*
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authz.annotation.Logical
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.security.InvalidParameterException
import java.util.*
import javax.persistence.EntityManager
import javax.transaction.Transactional

/**
 * Created by swm on 2018-5-19
 */
@RequiresPermissions(value = ["system:user-management:write"])
@RestController
@RequestMapping(path = ["/api"],
        produces = [MediaType.APPLICATION_JSON_UTF8_VALUE])
class SysAdminController {

    @Autowired
    lateinit var userRepository: UserRepository

//    @PostMapping("/user")
////    @Transactional
//    fun addUser(@RequestBody data: User): User {
//        return userRepository.add()
//    }
}


@RequiresPermissions(value = ["repo:inventory:write"])
@RestController
@RequestMapping(path = ["/api"],
        produces = [MediaType.APPLICATION_JSON_UTF8_VALUE])
class RepoChangingController {

    @Autowired
    lateinit var entityManager: EntityManager

    @Autowired
    lateinit var inventoryRepository: InventoryRepository

    @Autowired
    lateinit var repoRepository: RepoRepository

    @Autowired
    lateinit var bomRepository: BomRepository

    @Autowired
    lateinit var repoHistoryRepository: RepoHistoryRepository

    @Autowired
    lateinit var deliverySheetRepository: DeliverySheetRepository

    @Autowired
    lateinit var orderRepository: OrderRepository

    @Autowired
    lateinit var repoChangingRepository: RepoChangingRepository

    @Autowired
    lateinit var repoChangingItemRepository: RepoChangingItemRepository

    @Autowired
    lateinit var purchasingOrderRepository: PurchasingOrderRepository

//    @Autowired
//    lateinit var productRepository: ProductRepository


    @GetMapping("/boms")
//    @RequiresPermissions("document:read")
    fun listBomsByOrderStatus(@RequestParam(value = "status") status: Collection<Int>): List<Bom> {
        val boms = bomRepository.findByOrderStatus(status)

//        boms.forEach { it.orderItem?.bom = null }

        return boms
    }


    @GetMapping("/previewStockIn/{cid}")
//    @RequiresPermissions("document:read")
    fun previewStockIn(@PathVariable(value = "cid") cid: Long) =
            entityManager.createNativeQuery("call preview_stock_in_changing(:cid)", "stockInPreview")
                    .setParameter("cid", cid)
                    .resultList

    @GetMapping("/previewStockOut/{cid}")
//    @RequiresPermissions("document:read")
    fun previewStockOut(@PathVariable(value = "cid") cid: Long) =
            entityManager.createNativeQuery("call preview_stock_out_changing(:cid)", "stockOutPreview")
                    .setParameter("cid", cid)
                    .resultList

    @PostMapping("/applyStockIn/{cid}")
    fun applyStockIn(@PathVariable(value = "cid") cid: Int,
                     @RequestBody data: ApplyStockChanging): ResponseEntity<GenericRestResult> {

        val user: User = SecurityUtils.getSubject().principal as User

        entityManager.createNamedStoredProcedureQuery("applyStockInChanging")
                .setParameter("cid", cid)
                .setParameter("executor", user.id)
                .setParameter("comment", data.comment)
                .execute()
        return ResponseEntity(GenericRestResult(200), HttpStatus.OK)
    }

    @PostMapping("/applyStockOut/{cid}")
    fun applyStockOut(@PathVariable(value = "cid") cid: Int,
                      @RequestBody data: ApplyStockChanging?): ResponseEntity<GenericRestResult> {

        val user: User = SecurityUtils.getSubject().principal as User

        entityManager.createNamedStoredProcedureQuery("applyStockOutChanging")
                .setParameter("cid", cid)
                .setParameter("executor", user.id)
                .setParameter("comment", data?.comment ?: "")
                .execute()
        return ResponseEntity(GenericRestResult(200), HttpStatus.OK)
    }

    @PatchMapping("/inventory")
    @Transactional
    fun inventory(@RequestBody data: List<InventoryUpdating>): Boolean {
//        val inventory = inventoryRepository.save(Inventory(0, comment = "test"))

        data.forEach {
            if (it.quantity != null || it.price != null) {
                var sql = "update repo set "

                if (it.quantity != null)
                    sql += "quantity = ${it.quantity},"
                if (it.price != null)
                    sql += "price = ${it.price},"

                sql = sql.dropLast(1)
                sql += " where material_id = ${it.id}"

                entityManager.createNativeQuery(sql)
                        .executeUpdate()
            }
        }

        return true
    }


    /**
     * confirm payment settlement
     */
    @RequiresPermissions("accounting:settlement")
    @PatchMapping("/payment/{id}/confirm")
    @Transactional
    fun confirmPaymentSettlement(@PathVariable(value = "id") id: Int): Boolean {
        /*
         update payment settlement status to 1 (confirmed)
         update status of orders included in this settlement to 3 (settled)
        */
        val user: User = SecurityUtils.getSubject().principal as User

        entityManager.createNativeQuery("update payment_settlement " +
                "set status = 1, confirmed_by=${user.id}, confirmed_date=now() " +
                "where id = $id")
                .executeUpdate()

        entityManager.createNativeQuery("update purchasing_order set status = 3 " +
                "where id in (select order_id from payment_settlement_item where settlement_id = $id)")
                .executeUpdate()

        return true
    }


    /**
     * finish payment settlement
     */
    @RequiresPermissions("accounting:settlement")
    @PatchMapping("/payment/{id}/finish")
    @Transactional
    fun finishPaymentSettlement(@PathVariable(value = "id") id: Int, @RequestBody data: PaymentSettlement): Boolean {
        /*
         update payment settlement status to 2 (processed)
         update paid_value
         update status of orders included in this settlement to 4 (paid)
        */
        data.paidValue ?: throw InvalidParameterException("paidValue must not be null")

        val user: User = SecurityUtils.getSubject().principal as User

        entityManager.createNativeQuery("update payment_settlement " +
                "set status = 2, paid_by=${user.id}, paid_date=now(), paid_value=${data.paidValue} " +
                "where id = $id")
                .executeUpdate()

        entityManager.createNativeQuery("update purchasing_order set status = 4 " +
                "where id in (select order_id from payment_settlement_item where settlement_id = $id)")
                .executeUpdate()

        return true
    }


    /**
     * confirm collecting settlement
     */
    @RequiresPermissions("accounting:settlement")
    @PatchMapping("/collecting/{id}/confirm")
    @Transactional
    fun confirmCollectingSettlement(@PathVariable(value = "id") id: Int): Boolean {
        /*
         update collecting settlement status to 1 (confirmed)
         update status of orders included in this settlement to 3 (settled)
        */
        val user: User = SecurityUtils.getSubject().principal as User

        entityManager.createNativeQuery("update collecting_settlement " +
                "set status = 1, confirmed_by=${user.id}, confirmed_date=now() " +
                "where id = $id")
                .executeUpdate()

        entityManager.createNativeQuery("update `order` set status = 3 " +
                "where id in (select order_id from collecting_settlement_item where settlement_id = $id)")
                .executeUpdate()

        return true
    }


    /**
     * finish payment settlement
     */
    @RequiresPermissions("accounting:settlement")
    @PatchMapping("/collecting/{id}/finish")
    @Transactional
    fun finishCollectingSettlement(@PathVariable(value = "id") id: Int, @RequestBody data: CollectingSettlement): Boolean {
        /*
         update payment settlement status to 2 (processed)
         update paid_value
         update status of orders included in this settlement to 4 (paid)
        */
        data.collectedValue ?: throw InvalidParameterException("collectedValue must not be null")

        val user: User = SecurityUtils.getSubject().principal as User

        entityManager.createNativeQuery("update collecting_settlement " +
                "set status = 2, collected_by=${user.id}, collected_date=now(), collected_value=${data.collectedValue} " +
                "where id = $id")
                .executeUpdate()

        entityManager.createNativeQuery("update `order` set status = 4 " +
                "where id in (select order_id from collecting_settlement_item where settlement_id = $id)")
                .executeUpdate()

        return true
    }


    /**
     */
    // FIXME no authority required
//    @RequiresPermissions("accounting:settlement")
    @GetMapping("/deliverySheet")
//    @Transactional
    fun listDeliverySheet(): List<DeliverySheet> {
        val sheets = deliverySheetRepository.findAll()
        sheets.forEach {
            it.items.clear()
            it.order?.client?.orders?.clear()
            it.order?.items?.clear()

            it.repoChanging?.bom = null

            it.createdBy?.roles?.clear()
            it.committedBy?.roles?.clear()
        }

        return sheets
    }


    /**
     */
    // FIXME no authority required
//    @RequiresPermissions("accounting:settlement")
    @GetMapping("/deliverySheet/committed")
//    @Transactional
    fun listCommittedDeliverySheet(): List<DeliverySheet> {
        val sheets = deliverySheetRepository.findByStatus(1)
        sheets.forEach {
            it.items.clear()
            it.order?.client?.orders?.clear()
            it.order?.items?.clear()
            it.createdBy?.roles?.clear()
            it.committedBy?.roles?.clear()
        }

        return sheets
    }


    /**
     */
    // FIXME no authority required
//    @RequiresPermissions("accounting:settlement")
    @PostMapping("/deliverySheet/{id}/repo")
    @Transactional
    fun createRepoChangingForCommittedDeliverySheet(@PathVariable(value = "id") id: Long,
                                                    @RequestBody data: RepoChanging): Optional<RepoChanging> {
//        val sheet = deliverySheetRepository.findById(id) ?: return Optional.empty()

        val changing = RepoChanging(0, repo = data.repo)
        entityManager.persist(data)

        return Optional.of(changing)
    }


    /**
     */
    // FIXME no authority required
//    @RequiresPermissions("accounting:settlement")
    @GetMapping("/order/{id}/deliverySheet")
//    @Transactional
    fun listDeliverySheetByOrder(@PathVariable(value = "id") id: Long): List<DeliverySheet> {
        val sheets = deliverySheetRepository.findByOrderId(id)
        sheets.forEach {
            it.items.clear()
            it.order?.client?.orders?.clear()
            it.order?.items?.clear()
            it.createdBy?.roles?.clear()
            it.committedBy?.roles?.clear()
        }

        return sheets
    }


    @RequiresPermissions("repo:stock-out")
    @PostMapping("/deliverySheet/{id}/repoChangingSheet")
    @Transactional
    fun createRepoChangingSheet(@PathVariable(value = "id") id: Long,
                                @RequestBody request: RepoChanging): ResponseEntity<RepoChanging> {

        val result = deliverySheetRepository.findById(id)
        if (!result.isPresent)
            return ResponseEntity.notFound().build()

        val user: User = SecurityUtils.getSubject().principal as User

        //
        val deliverySheet = result.get()
        deliverySheet.status = 2

        val repoSheet = request.copy(status = 1, type = -1, applicant = user,
                order = deliverySheet.order,
                deliverySheet = deliverySheet,
                createDate = Date(), items = mutableListOf())

        deliverySheet.items.forEach {
            val repoChangingItem = RepoChangingItem(RepoChangingItemKey(repoSheet.id, it.orderItem?.product?.material?.id!!),
                    repoChanging = repoSheet, material = it.orderItem.product.material!!,
                    quantity = it.quantity)
            repoSheet.items.add(repoChangingItem)
//            entityManager.persist(repoChangingItem)
        }

        with(entityManager) {
            //        entityManager.transaction.begin()
            persist(repoSheet)

            persist(deliverySheet)

            flush()
//        entityManager.transaction.commit()
        }

        //
//        entityManager.detach(repoSheet)
////        return ResponseEntity.created(URI("")).build()
//        with(repoSheet) {
//            applicant?.roles?.clear()
//            items.clear()
//            deliverySheet.items.clear()
//            order?.client = null
//        }
        return ResponseEntity.ok(repoSheet)
    }


    @RequiresPermissions("accounting:settlement")
    @PostMapping("/collectingSettlement")
    @Transactional
    fun createCollectingSettlement(@RequestBody request: CollectingSettlement): CollectingSettlement {

        request.status = 0
        request.createDate = Date()

        request.items.forEach {
            it.order = orderRepository.findDeliveredByOrderId(it.id.order).get()
            it.order?.status = 3

            request.value += it.order?.actualValue!!
        }

        entityManager.persist(request)

        //
        return request
    }


//    @RequiresPermissions("purchasing:plan")
//    @GetMapping("/purchasingDetails")
////    @Transactional
//    fun listPurchasingDetails(): List<RepoChangingItem> {
//
//        val repoChangingItems = repoChangingItemRepository.findStockInByReasonId(1)
//
////        repoChangingItems.forEach {
////            it.repoChanging.deliverySheet
////            it.repoChanging.order?.client
////            it.repoChanging.repo
////            it.material
////        }
//
//        //
//        return repoChangingItems
//    }


    @RequiresPermissions("purchasing:plan")
    @GetMapping("/purchasingOrders")
//    @Transactional
    fun listPurchasingDetails(): List<PurchasingOrder> {

        val orders = purchasingOrderRepository.findAll()

        orders.forEach {
            it.items.size

            it.items.forEach { oi ->
                oi.material?.product = null
            }
        }

        //
        return orders
    }


    @RequiresPermissions("sales:order")
    @GetMapping("/orders")
//    @Transactional
    fun listOrders(@RequestParam(name = "page", required = false) page: Optional<Int>,
                   @RequestParam(name = "size", required = false) size: Optional<Int>): List<Order> {

        val p = page.orElse(0)
        val s = size.orElse(10)
        val orders = orderRepository.findAll(PageRequest.of(p, s))

        // force load lazy collection
        orders.forEach {
            it.client?.orders?.clear()

            it.deliverySheets.clear()

            it.items.size
            it.items.forEach { oi ->
                //                oi.producingSchedule?.orderItem = null
//                oi.producingSchedule?.bom?.orderItem = null
//                oi.producingSchedule?.bom?.producingSchedule = null
                oi.producingSchedule = null

//                oi.bom?.orderItem = null
//                oi.bom?.producingSchedule = null
                oi.bom = null

                oi.product.material?.product = null
                oi.product.formulas.clear()
            }

            it.deliverySheets.size
            it.deliverySheets.forEach { sheet ->
                sheet.items.size

//                sheet.repoChanging?.applicant?.roles?.clear()
                cleanStockChanging(sheet.repoChanging)
            }
        }

        //
        return orders.content
    }


//    @RequiresPermissions("sales:order")
//    @GetMapping("/salesDetails")
////    @Transactional
//    fun listSalesDetails(): List<RepoChangingItem> {
//
//        val repoChangingItems = repoChangingItemRepository.findStockOutByReasonId(11)
//
////        repoChangingItems.forEach {
////            it.repoChanging.deliverySheet
////            it.repoChanging.order?.client
////            it.repoChanging.repo
////            it.material
////        }
//
//        //
//        return repoChangingItems
//    }

    @RequiresPermissions(value = ["repo:stock-out:read"], logical = Logical.OR)
    @GetMapping("/stock-out")
    fun listStockOutByUser(): List<RepoChanging> {
        val user: User = SecurityUtils.getSubject().principal as User

        val changings = repoChangingRepository.findByTypeAndApplicant(-1, user)

        changings.forEach {
            cleanStockChanging(it)
        }

        return changings
    }

    @RequiresPermissions(value = ["repo:stock-out:read"], logical = Logical.OR)
    @GetMapping("/all-stock-out")
    fun listAllStockOut(@RequestParam(name = "page", required = false) page: Optional<Int>,
                        @RequestParam(name = "size", required = false) size: Optional<Int>): List<RepoChanging> {
//        val user: User = SecurityUtils.getSubject().principal as User
        val p = page.orElse(0)
        val s = size.orElse(10)

        val changings = repoChangingRepository.findByType(-1, PageRequest.of(p, s))

        changings.forEach {
            it.items.size
            cleanStockChanging(it)
        }

        return changings.content
    }

    @RequiresPermissions(value = ["repo:stock-out:read"], logical = Logical.OR)
    @GetMapping("/stock-out/rejected")
    fun listRejectedStockOut(): List<RepoChanging> {
//        val user: User = SecurityUtils.getSubject().principal as User

        val changings = repoChangingRepository.findByTypeAndStatus(-1, -1)

        changings.forEach {
            cleanStockChanging(it)
        }

        return changings
    }

    @RequiresPermissions(value = ["repo:stock-in:read"], logical = Logical.OR)
    @GetMapping("/stock-in")
    fun listStockInByUser(): List<RepoChanging> {
        val user: User = SecurityUtils.getSubject().principal as User

        val changings = repoChangingRepository.findByTypeAndApplicant(1, user)

//        changings.forEach { it.items.size }

        return changings
    }

    @RequiresPermissions(value = ["repo:stock-in:read"], logical = Logical.OR)
    @GetMapping("/all-stock-in")
    fun listAllStockIn(@RequestParam(name = "page", required = false) page: Optional<Int>,
                       @RequestParam(name = "size", required = false) size: Optional<Int>): List<RepoChanging> {
//        val user: User = SecurityUtils.getSubject().principal as User
        val p = page.orElse(0)
        val s = size.orElse(10)
//        val user: User = SecurityUtils.getSubject().principal as User

        val changings = repoChangingRepository.findByType(1, PageRequest.of(p, s))

        changings.forEach {
            it.items.size

            cleanStockChanging(it)
        }

        return changings.content
    }

    @RequiresPermissions(value = ["repo:stock-in:read"], logical = Logical.OR)
    @GetMapping("/stock-in/rejected")
    fun listRejectedStockIn(): List<RepoChanging> {
//        val user: User = SecurityUtils.getSubject().principal as User

        val changings = repoChangingRepository.findByTypeAndStatus(1, -1)

//        changings.forEach { it.items.size }

        return changings
    }

    @RequiresPermissions(value = ["repo:stock-in:read", "repo:stock-out:read"], logical = Logical.OR)
    @GetMapping("/stock-changing")
    fun listStockChanging(): List<RepoChanging> {
//        val user: User = SecurityUtils.getSubject().principal as User

        val changings = repoChangingRepository.findStockInOutByStatusNot(0)

        changings.forEach {
            cleanStockChanging(it)
        }

        return changings
    }

    @RequiresPermissions(value = ["repo:stock-in:read", "repo:stock-out:read"], logical = Logical.OR)
    @GetMapping("/stock-changing/{id}")
    fun getStockChangingById(@PathVariable(value = "id") id: Int): ResponseEntity<RepoChanging> {
//        val user: User = SecurityUtils.getSubject().principal as User

        val r = repoChangingRepository.findById(id)
        return if (r.isPresent) {
            val changing = r.get()
            cleanStockChanging(changing)

            ResponseEntity.ok(changing)
        } else
            ResponseEntity.notFound().build()
    }

    private fun cleanStockChanging(changing: RepoChanging?) {
        changing ?: return

        changing.applicant?.roles?.clear()
        changing.order?.client?.orders?.clear()
        changing.order?.items?.clear()

        changing.bom?.orderItem?.bom = null
        changing.bom?.orderItem?.product?.material = null
        changing.bom?.orderItem?.producingSchedule = null

        changing.bom?.producingSchedule = null
        changing.bom?.formula = null
        changing.deliverySheet?.items?.clear()

        changing.items.forEach {
            it.material.product = null
        }
    }


    @GetMapping("/inventories/{id}")
    fun getInventoryById(@PathVariable(value = "id") id: Int): ResponseEntity<Inventory> {
        val oi = inventoryRepository.findById(id)

        return if (oi.isPresent) {
            val inventory = oi.get()

            inventory.items.size
            inventory.items.forEach {
                it.material?.product = null
            }

            ResponseEntity.ok(inventory)
        } else
            ResponseEntity(null, HttpStatus.NOT_FOUND)
    }


    @GetMapping("/inventories")
    fun listInventories(@RequestParam(name = "status", required = false) status: Collection<Int>?): MutableList<Inventory> {
        return if (status == null)
            inventoryRepository.findAll()
        else
            inventoryRepository.findByStatusIn(status)
    }

    @PostMapping("/inventories")
    @Transactional
    fun saveInventory(@RequestBody inventory: Inventory,
                      @RequestParam(name = "action", required = false) action: Int = 0): ResponseEntity<Boolean> {
//        inventory.items.forEach {
//            it.id.inventory = inventory.id
//            it.inventory = inventory
//        }
        //
        if (action == 2) {

            inventory.status = 2
            inventoryRepository.save(inventory)

        } else {
            if (action == 1) {
                inventory.reportBy ?: return ResponseEntity(false, HttpStatus.BAD_REQUEST)

                inventory.status = 1
                inventory.reportDate = Date()
            }

            if (inventory.items == null)
                inventory.items = mutableListOf()

            val items = ArrayList(inventory.items)
            inventory.items.clear()

            //
            inventoryRepository.save(inventory)

            //
            inventory.addItems(items)

            //
            items.forEach {
                if (entityManager.contains(it))
                    entityManager.merge(it)
            }

            inventoryRepository.saveAndFlush(inventory)
        }

        return ResponseEntity.ok(true)
    }


//    @PutMapping("/inventory/{id}")
//    @Transactional
//    fun updateInventory(@PathVariable(value = "id") id: Int, @RequestBody inventory: Inventory): Boolean {
//        inventory.id = id
//        inventory.items.forEach {
//            it.id.inventory = id
//            it.inventory = Inventory(id)
//        }
//
//        inventoryRepository.save(inventory)
//
//        repoHistoryRepository.saveAll(inventory.items)
//
//        return true
//    }
}

data class ApplyStockChanging(
        val comment: String? = null
)

data class InventoryUpdating(
        val id: Long,
        val quantity: Float? = null,
        val price: Float? = null
)