package com.universal.hly.controller.rest

import com.universal.hly.dao.InventoryRepository
import com.universal.hly.dao.RepoHistoryRepository
import com.universal.hly.dao.RepoRepository
import com.universal.hly.model.Inventory
import com.universal.hly.model.User
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.sql.SQLException
import javax.persistence.EntityManager
import javax.transaction.Transactional

/**
 * Created by swm on 2018-5-19
 */

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

        data.forEach({
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
        })

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