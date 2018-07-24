package com.universal.hly.controller.rest

import com.universal.hly.dao.InventoryRepository
import com.universal.hly.dao.RepoHistoryRepository
import com.universal.hly.dao.RepoRepository
import com.universal.hly.dao.UserRepository
import com.universal.hly.model.CollectingSettlement
import com.universal.hly.model.Inventory
import com.universal.hly.model.PaymentSettlement
import com.universal.hly.model.User
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.security.InvalidParameterException
import java.sql.SQLException
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
    lateinit var repoHistoryRepository: RepoHistoryRepository

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
}

data class ApplyStockChanging(
        val comment: String? = null
)

data class InventoryUpdating(
        val id: Long,
        val quantity: Float? = null,
        val price: Float? = null
)