package com.universal.hly.dao

import com.universal.hly.model.*
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.NoRepositoryBean
import org.springframework.data.repository.query.Param
import org.springframework.data.rest.core.annotation.RepositoryRestResource
import org.springframework.data.rest.webmvc.spi.BackendIdConverter
import org.springframework.stereotype.Component
import java.io.Serializable
import java.util.*
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import javax.transaction.Transactional

///////////////////////////////////////////////////////////////////////////////////////////////////////
// https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods.query-creation
///////////////////////////////////////////////////////////////////////////////////////////////////////

//import com.universal.hly.model.Order

/**
 * Created by swm on 2018-4-5
 */
@NoRepositoryBean
interface MyBaseRepository<T, ID : Serializable> : JpaRepository<T, ID> {

//    fun findById(id: ID): Optional<T>

//    fun <S : T> save(entity: S): S
}

interface ClientTypeRepository : MyBaseRepository<ClientType, Long> {
    fun findByName(name: String): Optional<ClientType>
}

// custom repository name must ends with "Custom"
interface ClientRepositoryCustom {
    fun anyOperation(client: Client)
}

// implementation name must ends with "Impl"
open class ClientRepositoryImpl : ClientRepositoryCustom {
    @PersistenceContext
    private val em: EntityManager? = null

    // enable transaction as need
    @Transactional
    override fun anyOperation(client: Client) {
//        if (em != null)
//            em.flush()
        em?.flush()
    }
}

@RepositoryRestResource(excerptProjection = InlineClientType::class)
interface ClientRepository : MyBaseRepository<Client, Long>, ClientRepositoryCustom {
    fun findByName(@Param("name") name: String): List<Client>
}

interface OrderRepository : MyBaseRepository<Order, Long> {
    fun findByNo(@Param("no") no: String): Optional<Order>
    fun findByStatusEquals(@Param("status") status: Int): List<Order>
}

@RepositoryRestResource(excerptProjection = InlineOrderAndProductType::class)
interface OrderItemRepository : MyBaseRepository<OrderItem, OrderItemKey> {
}

interface ProductRepository : MyBaseRepository<Product, Long> {
    fun findByCode(@Param("code") code: String): Optional<Product>
}

interface ProduceConditionRepository : MyBaseRepository<ProduceCondition, Long> {
    fun findByFormula(@Param("id") id: Long): Optional<ProduceCondition>
}

interface FormulaRepository : MyBaseRepository<Formula, Long> {
    fun findByProduct(@Param("id") id: Long): List<Formula>

    @Query("select ifnull(max(revision), 0) from formula where product_id = ?1", nativeQuery = true)
    fun getLatestRevision(@Param("id") id: Long): Int
}

interface FormulaItemRepository : MyBaseRepository<FormulaItem, Long> {
    @Query("select * from formula_item where formula_id = ?1", nativeQuery = true)
    fun findByFormula(@Param("id") id: Long): List<FormulaItem>
}

@RepositoryRestResource(excerptProjection = InlineMaterialType::class)
interface MaterialRepository : MyBaseRepository<Material, Long> {
    fun findByCode(@Param("code") code: String): Optional<Material>
    fun findByName(@Param("name") name: String): Optional<Material>
}

interface MaterialTypeRepository : MyBaseRepository<MaterialType, Long> {
}


@RepositoryRestResource(excerptProjection = InlineOrderItemAndFormulaType::class)
interface BomRepository : MyBaseRepository<Bom, Long> {
    @Query("select * from bom b join order_item oi on b.order_id = oi.order_id and b.product_id = oi.product_id where oi.order_id = ?1", nativeQuery = true)
    fun findByOrderId(@Param("oid") oid: Long): List<Bom>
}


interface BomItemRepository : MyBaseRepository<BomItem, BomItemKey> {
}


// POST:   {"id": 5, "material": {"id": 5}, "quantity": 1.3, "price": 4.4}
// DELETE: repos/5
interface RepoRepository : MyBaseRepository<Repo, Long> {
}

// POST: {"comment": "test again"}
interface InventoryRepository : MyBaseRepository<Inventory, Int> {
}

// POST {"id": {"inventory": 0, "material": 0}, "inventory": {"id":2}, "material": {"id":5}, "quantity": 1.3, "price": 4.4}
interface RepoHistoryRepository : MyBaseRepository<RepoHistory, Int> {
}

// POST {"type": 2, "applicant": "whoelse", "keeper": "kevin", "amount": 4.4}
interface RepoChangingRepository : MyBaseRepository<RepoChanging, Int> {
    // @Query("select * from repo_changing b where b.order_id = ?1", nativeQuery = true)
    fun findByType(@Param("type") type: Int): List<RepoChanging>

    fun findByTypeAndStatus(@Param("type") type: Int, @Param("status") status: Int): List<RepoChanging>

    fun findByStatus(@Param("status") status: Int): List<RepoChanging>

    @Query(nativeQuery = true, name = "RepoChanging.previewStockOut")
    fun previewStockIn(@Param("cid") cid: Int): List<StockInPreview>

    @Query(nativeQuery = true, name = "RepoChanging.previewStockOut")
    fun previewStockOut(@Param("cid") cid: Int): List<StockOutPreview>
}

// POST {"id": {"repoChanging": 0, "material": 0}, "repoChanging": {"id":1}, "material": {"id":6}, "quantity": -1.3, "price": 4.4}
interface RepoChangingItemRepository : MyBaseRepository<RepoChangingItem, Int> {
}


//interface StockOutPreviewRepository : MyBaseRepository<StockOutPreview, Int> {
//    @Query(nativeQuery = true, name = "RepoChanging.previewStockOut")
//    fun previewStockOut(@Param("cid") cid: Int): List<StockOutPreview>
//}

// ==============================================================
@Component
class FormulaItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String, entityType: Class<*>): Serializable {
        val parts = id.split("_")
        return FormulaItemKey(parts[0].toLong(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: FormulaItemKey = source as FormulaItemKey
        return String.format("%s_%s", id.formula, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return FormulaItem::class.java == type
    }
}

@Component
class OrderItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String, entityType: Class<*>): Serializable {
        val parts = id.split("_")
        return OrderItemKey(parts[0].toLong(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: OrderItemKey = source as OrderItemKey
        return String.format("%s_%s", id.order, id.product)
    }

    override fun supports(type: Class<*>): Boolean {
        return OrderItem::class.java == type
    }
}

@Component
class BomItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String, entityType: Class<*>): Serializable {
        val parts = id.split("_")
        return BomItemKey(parts[0].toLong(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: BomItemKey = source as BomItemKey
        return String.format("%s_%s", id.bom, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return BomItem::class.java == type
    }
}

@Component
class RepoHistoryKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String, entityType: Class<*>): Serializable {
        val parts = id.split("_")
        return RepoHistoryKey(parts[0].toInt(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: RepoHistoryKey = source as RepoHistoryKey
        return String.format("%s_%s", id.inventory, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return RepoHistory::class.java == type
    }
}

// @Component
// class RepoChangingItemKeyConverter : BackendIdConverter {
// 
//     override fun fromRequestId(id: String, entityType: Class<*>): Serializable {
//         val parts = id.split("_")
//         return RepoChangingItemKey(parts[0].toInt(), parts[1].toLong())
//     }
// 
//     override fun toRequestId(source: Serializable, entityType: Class<*>): String {
//         val id: RepoChangingItemKey = source as RepoChangingItemKey
//         return String.format("%s_%s", id.repoChanging, id.material)
//     }
// 
//     override fun supports(type: Class<*>): Boolean {
//         return RepoChangingItem::class.java == type
//     }
// }