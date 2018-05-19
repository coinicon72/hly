package com.universal.hly.controller.rest

import com.universal.hly.model.Greeting
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.hibernate.service.spi.InjectService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.*
import java.util.concurrent.atomic.AtomicLong
import javax.persistence.EntityManager

/**
 * Created by swm on 2018-5-19
 */

@RestController
@RequestMapping(path = ["/api"],
        produces = [MediaType.APPLICATION_JSON_UTF8_VALUE])
class RepoChangingController {

    @Autowired
    lateinit var entityManager: EntityManager

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
                     @RequestBody data: ApplyStockChanging) =
            entityManager.createNamedStoredProcedureQuery("applyStockInChanging")
                    .setParameter("cid", cid)
                    .setParameter("executor", "admin")
                    .setParameter("comment", data.comment)
                    .execute()

    @PostMapping("/applyStockOut/{cid}")
    fun applyStockOut(@PathVariable(value = "cid") cid: Int,
                     @RequestBody data: ApplyStockChanging) =
            entityManager.createNamedStoredProcedureQuery("applyStockOutChanging")
                    .setParameter("cid", cid)
                    .setParameter("executor", "admin")
                    .setParameter("comment", data.comment)
                    .execute()
}

data class ApplyStockChanging (
        val comment: String? = null
)