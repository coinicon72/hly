@file:Suppress("unused")

package com.universal.hly.dao

import com.universal.hly.model.*
import org.apache.shiro.authz.annotation.Logical
import org.apache.shiro.authz.annotation.RequiresAuthentication
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.NoRepositoryBean
import org.springframework.data.repository.query.Param
import org.springframework.data.rest.core.annotation.RepositoryRestResource
import org.springframework.data.rest.webmvc.spi.BackendIdConverter
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.stereotype.Component
import java.io.Serializable
import java.util.*
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import javax.transaction.Transactional

///////////////////////////////////////////////////////////////////////////////////////////////////////
// https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods.query-creation
///////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Created by swm on 2018-4-5
 */
@NoRepositoryBean
@RequiresAuthentication
interface MyBaseRepository<T, ID : Serializable> : JpaRepository<T, ID> {

//    @RequiresPermissions(value = ["*:*:write"])
//    override fun <S : T> save(entity: S): S
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun deleteInBatch(entities: MutableIterable<T>?)
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun deleteById(id: ID)
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun deleteAllInBatch()
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun <S : T> saveAndFlush(entity: S): S
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun deleteAll(entities: MutableIterable<T>?)
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun deleteAll()
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun <S : T> saveAll(entities: MutableIterable<S>?): MutableList<S>
//
//    @RequiresPermissions(value = ["*:*:write"])
//    override fun delete(entity: T)
}

@RequiresPermissions(value = ["system:basic-data:read"])
interface ClientTypeRepository : MyBaseRepository<ClientType, Long> {
    fun findByName(name: String): Optional<ClientType>
}


@RequiresPermissions(value = ["sales:client:read"])
@RepositoryRestResource(excerptProjection = InlineClientType::class)
interface ClientRepository : MyBaseRepository<Client, Long>, ClientRepositoryCustom {
    fun findByName(@Param("name") name: String): List<Client>

    @Query("select * from client where payment_policy is not null and payment_policy <> ''", nativeQuery = true)
    fun findByPaymentPolicyIsNotNull(): List<Client>

    @Query("select * from client where collecting_policy is not null and collecting_policy <> ''", nativeQuery = true)
    fun findByCollectingPolicyIsNotNull(): List<Client>
}

// custom repository name must ends with "Custom"
interface ClientRepositoryCustom {
    fun anyOperation(client: Client)
}

//@RequiresPermissions(value = ["sales:client"])
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


@RequiresPermissions(value = ["sales:order:read"])
interface OrderRepository : MyBaseRepository<Order, Long> {
    fun findByNo(@Param("no") no: String): Optional<Order>

    fun findByStatusEquals(@Param("status") status: Int): List<Order>

    fun findByClientAndStatus(client: Client, status: Int): List<Order>

    fun findByClientAndStatusAndDeliveryDateBefore(client: Client, status: Int,
                                                   @Param("date")
                                                   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                   deliveryDate: Date): List<Order>

    @Query(value = "select d.actual_value, d.value, o.* from `order` o join (" +
            "select order_id, round(sum(price * quantity), 2) `value`, round(sum(price * actual_quantity), 2) `actual_value` from ( " +
            "select oi.order_id, oi.product_id, oi.price, oi.quantity, ifnull(sum(dsi.quantity), 0) actual_quantity " +
            "from delivery_sheet_item dsi right join order_item oi on oi.order_id=dsi.order_id and oi.product_id=dsi.product_id " +
            "where oi.order_id=:oid " +
            "group by oi.order_id, oi.product_id, oi.price, oi.quantity " +
            ") d group by order_id " +
            ") d on d.order_id=o.id",
            nativeQuery = true)
    fun findDeliveredByOrderId(@Param("oid") id: Long): Optional<Order>
}

@RequiresPermissions(value = ["sales:order:read"])
@RepositoryRestResource(excerptProjection = InlineOrderAndProductType::class)
interface OrderItemRepository : MyBaseRepository<OrderItem, OrderItemKey> {
    @Query(value = "select oi.order_id, oi.product_id, oi.price, oi.quantity, ifnull(sum(dsi.quantity), 0) actual_quantity " +
            "from delivery_sheet_item dsi right join order_item oi on oi.order_id=dsi.order_id and oi.product_id=dsi.product_id " +
            "where oi.order_id=:oid " +
            "group by oi.order_id, oi.product_id, oi.price, oi.quantity",
            nativeQuery = true)
    fun findDeliveredByOrderId(@Param("oid") id: Long): List<OrderItem>
}

@RequiresPermissions(value = ["production:product:read"])
interface ProductRepository : MyBaseRepository<Product, Long> {
    fun findByCode(@Param("code") code: String): Optional<Product>
}

// FIXME no authority required
@RepositoryRestResource(excerptProjection = DeliverySheetWithOrder::class)
interface DeliverySheetRepository : MyBaseRepository<DeliverySheet, Long> {
    fun findByOrderId(@Param("id") id: Long): List<DeliverySheet>

    fun findByStatus(@Param("status") status: Int): List<DeliverySheet>
}

// FIXME no authority required
interface DeliverySheetItemRepository : MyBaseRepository<DeliverySheetItem, DeliverySheetItemKey> {
    fun findByDeliverySheetId(@Param("id") id: Long): List<DeliverySheetItem>

    @Query(nativeQuery = true, value = "select dsi.* from delivery_sheet_item dsi where dsi.order_id=:oid")
    fun findByOrderId(@Param("oid") id: Long): List<DeliverySheetItem>
}

@RequiresPermissions(value = ["production:formula:read"])
interface ProduceConditionRepository : MyBaseRepository<ProduceCondition, Long> {
    fun findByFormula(@Param("id") id: Long): Optional<ProduceCondition>
}

@RequiresPermissions(value = ["production:formula:read"])
interface FormulaRepository : MyBaseRepository<Formula, Long> {
    fun findByProduct(@Param("id") id: Long): List<Formula>

    @Query("select ifnull(max(revision), 0) from formula where product_id = ?1", nativeQuery = true)
    fun getLatestRevision(@Param("id") id: Long): Int
}

@RequiresPermissions(value = ["production:formula:read"])
interface FormulaItemRepository : MyBaseRepository<FormulaItem, FormulaItemKey> {
    @Query("select * from formula_item where formula_id = ?1", nativeQuery = true)
    fun findByFormula(@Param("id") id: Long): List<FormulaItem>
}

@RequiresPermissions(value = ["production:material:read"])
@RepositoryRestResource(excerptProjection = InlineMaterialType::class)
interface MaterialRepository : MyBaseRepository<Material, Long> {
    fun findByCode(@Param("code") code: String): Optional<Material>

    fun findByName(@Param("name") name: String): Optional<Material>

    fun findByCategory(category: Int): List<Material>
}

@RequiresPermissions(value = ["system:basic-data:read"])
interface MaterialTypeRepository : MyBaseRepository<MaterialType, Long> {

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun <S : MaterialType?> save(entity: S): S

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun deleteInBatch(entities: MutableIterable<MaterialType>?)

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun deleteById(id: Long)

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun deleteAllInBatch()

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun <S : MaterialType?> saveAndFlush(entity: S): S

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun deleteAll(entities: MutableIterable<MaterialType>?)

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun deleteAll()

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun <S : MaterialType?> saveAll(entities: MutableIterable<S>?): MutableList<S>

    @RequiresPermissions(value = ["system:basic-data:write"])
    override fun delete(entity: MaterialType?)

    fun findByIdGreaterThan(id: Long): List<MaterialType>
}


@RequiresPermissions(value = ["production:schedule:read"])
//@RepositoryRestResource(excerptProjection = InlineOrderItemAndFormulaType::class)
interface ProducingScheduleRepository : MyBaseRepository<ProducingSchedule, OrderItemKey> {
    @Query("select * from bom b join order_item oi on b.order_id = oi.order_id and b.product_id = oi.product_id where oi.order_id = ?1", nativeQuery = true)
    fun findByOrder(id: Long): List<ProducingSchedule>

    fun findByProducingDateIsNull(): List<ProducingSchedule>
}


@RequiresPermissions(value = ["production:bom:read"])
@RepositoryRestResource(excerptProjection = InlineOrderItemAndFormulaType::class)
interface BomRepository : MyBaseRepository<Bom, OrderItemKey> {
    //BomKey> {
    @Query("select * from bom b join order_item oi on b.order_id = oi.order_id and b.product_id = oi.product_id where oi.order_id = ?1", nativeQuery = true)
    fun findByOrderId(@Param("oid") oid: Long): List<Bom>
}


@RequiresPermissions(value = ["production:bom:read"])
interface BomItemRepository : MyBaseRepository<BomItem, BomItemKey>


@RequiresPermissions(value = ["system:basic-data:read"])
interface RepoRepository : MyBaseRepository<Repo, Int> {
    fun findByType(@Param("type") type: Int): List<Repo>
}


@RequiresPermissions(value = ["repo:inventory:read"])
// POST:   {"id": 5, "material": {"id": 5}, "quantity": 1.3, "price": 4.4}
// DELETE: repos/5
interface RepoItemRepository : MyBaseRepository<RepoItem, RepoItemKey> {
    fun findByRepo(@Param("repo") repo: Repo): List<RepoItem>
}


@RequiresPermissions(value = ["purchasing:plan:read"])
interface PurchasingOrderRepository : MyBaseRepository<PurchasingOrder, Int> {
    fun findBySigner(signer: User): List<PurchasingOrder>

    fun findBySupplierAndStatus(supplier: Client, status: Int): List<PurchasingOrder>

    fun findByStatus(status: Int): List<PurchasingOrder>

    fun findByStatusIn(status: Collection<Int>): List<PurchasingOrder>

//    @Query("select o from PurchasingOrder o where o.status <= 1")
//    fun findNotStockIn(): List<PurchasingOrder>
}


@RequiresPermissions(value = ["purchasing:plan:read"])
interface PurchasingOrderItemRepository : MyBaseRepository<PurchasingOrderItem, PurchasingOrderItemKey>


@RequiresPermissions(value = ["repo:inventory:read"])
// POST: {"comment": "test again"}
interface InventoryRepository : MyBaseRepository<Inventory, Int>

@RequiresPermissions(value = ["repo:inventory:read"])
// POST {"id": {"inventory": 0, "material": 0}, "inventory": {"id":2}, "material": {"id":5}, "quantity": 1.3, "price": 4.4}
interface RepoHistoryRepository : MyBaseRepository<RepoHistory, RepoHistoryKey>

@RequiresPermissions(value = ["system:basic-data:read"])
interface RepoChangingReasonRepository : MyBaseRepository<RepoChangingReason, Int> {
    fun findByType(@Param("type") type: Int): List<RepoChangingReason>
}

@RequiresPermissions(value = ["repo:stock-in:read", "repo:stock-out:read"], logical = Logical.OR)
@RepositoryRestResource(excerptProjection = InlineRepoChanging::class)
// POST {"type": 2, "applicant": "whoelse", "keeper": "kevin", "amount": 4.4}
interface RepoChangingRepository : MyBaseRepository<RepoChanging, Int> {
    // @Query("select * from repo_changing b where b.order_id = ?1", nativeQuery = true)
    fun findByType(@Param("type") type: Int): List<RepoChanging>

    fun findByTypeAndStatus(@Param("type") type: Int, @Param("status") status: Int): List<RepoChanging>

    fun findByTypeAndStatusAndApplicant(@Param("type") type: Int, @Param("status") status: Int, @Param("user") user: User): List<RepoChanging>

    fun findByApplicant(@Param("user") user: User): List<RepoChanging>

    fun findByStatus(@Param("status") status: Int): List<RepoChanging>

    //    fun findByStatusAndTypeIn(@Param("type") type: List<Int>, @Param("status") status: Int): List<RepoChanging>
    @Query("select * from repo_changing where type <> 0 and status=?1", nativeQuery = true)
    fun findStockInOutByStatus(@Param("status") status: Int): List<RepoChanging>

    //    fun findByStatusAndTypeIn(@Param("type") type: List<Int>, @Param("status") status: Int): List<RepoChanging>
    @Query("select * from repo_changing where type=-1 and order_id=:oid", nativeQuery = true)
    fun findStockOutByOrderId(@Param("oid") id: Long): List<RepoChanging>

    @Query("select * from repo_changing where type=-1 and order_id=:oid and reason_id=:reason", nativeQuery = true)
    fun findStockOutByOrderIdAndReasonId(@Param("oid") id: Long, @Param("reason") reason: Int): List<RepoChanging>

    @Query("select * from repo_changing where type=-1 and reason_id=:reason", nativeQuery = true)
    fun findStockOutByReasonId(@Param("reason") reason: Int): List<RepoChanging>

    @Query(nativeQuery = true, name = "RepoChanging.previewStockOut")
    fun previewStockIn(@Param("cid") cid: Int): List<StockInPreview>

    @Query(nativeQuery = true, name = "RepoChanging.previewStockOut")
    fun previewStockOut(@Param("cid") cid: Int): List<StockOutPreview>
}

@RequiresPermissions(value = ["repo:stock-in:read", "repo:stock-out:read"], logical = Logical.OR)
// POST {"id": {"repoChanging": 0, "material": 0}, "repoChanging": {"id":1}, "material": {"id":6}, "quantity": -1.3, "price": 4.4}
interface RepoChangingItemRepository : MyBaseRepository<RepoChangingItem, RepoChangingItemKey> {
    @Query("SELECT ci.* FROM hly.repo_changing_item ci join repo_changing c on ci.repo_changing_id=c.id " +
            "where c.type=-1 and c.reason_id=:reason", nativeQuery = true)
    fun findStockOutByReasonId(@Param("reason") reason: Int): List<RepoChangingItem>

    @Query("SELECT ci.* FROM hly.repo_changing_item ci join repo_changing c on ci.repo_changing_id=c.id " +
            "where c.type=1 and c.reason_id=:reason", nativeQuery = true)
    fun findStockInByReasonId(@Param("reason") reason: Int): List<RepoChangingItem>
}


@RequiresPermissions(value = ["system:user-management:read"])
interface RoleRepository : MyBaseRepository<Role, Int> {
    @RequiresPermissions(value = ["system:user-management:write"])
    override fun <S : Role?> save(entity: S): S

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun deleteInBatch(entities: MutableIterable<Role>?)

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun deleteById(id: Int?)

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun deleteAllInBatch()

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun <S : Role?> saveAndFlush(entity: S): S

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun deleteAll(entities: MutableIterable<Role>?)

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun deleteAll()

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun <S : Role?> saveAll(entities: MutableIterable<S>?): MutableList<S>

    @RequiresPermissions(value = ["system:user-management:write"])
    override fun delete(entity: Role?)
}


@RequiresPermissions(value = ["system:user-management:read"])
interface PrivilegeRepository : MyBaseRepository<Privilege, Int>

@RequiresPermissions(value = ["system:basic-data:read"])
interface OrganizationRepository : MyBaseRepository<Organization, Int>

@RequiresPermissions(value = ["system:user-management:read"])
interface UserRepository : MyBaseRepository<User, Int> {
//    @Query("select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1", nativeQuery = true)
//    override fun findAll(): List<User>

    //    @Query("select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1", nativeQuery = true)
//    override fun findAll(pageable: Pageable?): Page<User>
//
//    @Query("select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1 and id=:id", nativeQuery = true)
//    override fun findById(id: Int): Optional<User>
//
//    @Query("select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1 and info->>'\$.phone' = :phone", nativeQuery = true)
    @Query("select u from User u where u.phone = :phone")
    fun getByPhone(phone: String): User?

//    @Query(nativeQuery = true, name = "User.addUser")
//    fun add(@Param("did") did: Int,
//            @Param("name") name: String,
//            @Param("phone") phone: String,
//            @Param("password") password: String,
//            @Param("comment") comment : String) : User


//    @Query("select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1 and id=:id", nativeQuery = true)
//    override fun getOne(id: Int?): User

//    override fun <S : User?> save(entity: S): S
}


//@RequiresPermissions(value = ["system:basic-data:read"])
@RepositoryRestResource(excerptProjection = CollectingSettlementProjection::class)
interface CollectingSettlementRepository : MyBaseRepository<CollectingSettlement, Int> {
    fun findByStatus(status: Int): List<CollectingSettlement>
    fun findByStatusLessThan(status: Int): List<CollectingSettlement>

    fun findByStatusAndConfirmedDateBetween(status: Int,
                                            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                            from: Date,
                                            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                            to: Date): List<CollectingSettlement>
}

@RepositoryRestResource(excerptProjection = CollectingSettlementItemProjection::class)
interface CollectingSettlementItemRepository : MyBaseRepository<CollectingSettlementItem, CollectingSettlementItemKey>


@RepositoryRestResource(excerptProjection = PaymentSettlementProjection::class)
interface PaymentSettlementRepository : MyBaseRepository<PaymentSettlement, Int> {
    fun findByStatus(status: Int): List<PaymentSettlement>
    fun findByStatusLessThan(status: Int): List<PaymentSettlement>

    fun findByStatusAndConfirmedDateBetween(status: Int,
                                            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                            from: Date,
                                            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                            to: Date): List<PaymentSettlement>

//    fun listPaidDetails(from: Date, to: Date): List<PaymentDetail>
}

@RepositoryRestResource(excerptProjection = PaymentSettlementItemProjection::class)
interface PaymentSettlementItemRepository : MyBaseRepository<PaymentSettlementItem, PaymentSettlementItemKey>


// ==============================================================
//region key converters
@Component
class FormulaItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

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

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return OrderItemKey(parts[0].toLong(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: OrderItemKey = source as OrderItemKey
        return String.format("%s_%s", id.order, id.product)
    }

    override fun supports(type: Class<*>): Boolean {
        return OrderItem::class.java == type
                || ProducingSchedule::class.java == type
                || Bom::class.java == type
    }
}

@Component
class DeliverySheetItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return DeliverySheetItemKey(parts[0].toLong(), OrderItemKey(parts[1].toLong(), parts[2].toLong()))
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: DeliverySheetItemKey = source as DeliverySheetItemKey
        return String.format("%s_%s_%s", id.deliverySheet, id.orderItem.order, id.orderItem.product)
    }

    override fun supports(type: Class<*>): Boolean {
        return DeliverySheetItem::class.java == type
    }
}

//@Component
//class ProducingScheduleKeyConverter : BackendIdConverter {
//
//    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
//        if (id == null) return null
//
//        val parts = id.split("_")
//        return OrderItemKey(parts[0].toLong(), parts[1].toLong())
//    }
//
//    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
//        val id: OrderItemKey = source as OrderItemKey
//        return String.format("%s_%s", id.order, id.product)
//    }
//
//    override fun supports(type: Class<*>): Boolean {
//        return ProducingSchedule::class.java == type
//    }
//}

//@Component
//class BomKeyConverter : BackendIdConverter {
//
//    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
//        if (id == null) return null
//
//        val parts = id.split("_")
//        return BomKey(parts[0].toLong(), parts[1].toLong())
//    }
//
//    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
//        val id: BomKey = source as BomKey
//        return String.format("%s_%s", id.order, id.product)
//    }
//
//    override fun supports(type: Class<*>): Boolean {
//        return Bom::class.java == type
//    }
//}

@Component
class BomItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return BomItemKey(parts[0].toLong(), parts[1].toLong(), parts[2].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: BomItemKey = source as BomItemKey
        return String.format("%s_%s_%s", id.order, id.product, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return BomItem::class.java == type
    }
}


@Component
class RepoItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return RepoItemKey(parts[0].toInt(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: RepoItemKey = source as RepoItemKey
        return String.format("%s_%s", id.repo, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return RepoItem::class.java == type
    }
}


@Component
class RepoHistoryKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

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


@Component
class PurchasingOrderItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return PurchasingOrderItemKey(parts[0].toInt(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: PurchasingOrderItemKey = source as PurchasingOrderItemKey
        return String.format("%s_%s", id.purchasingOrder, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return PurchasingOrderItem::class.java == type
    }
}


@Component
class RepoChangingItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return RepoChangingItemKey(parts[0].toInt(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: RepoChangingItemKey = source as RepoChangingItemKey
        return String.format("%s_%s", id.repoChanging, id.material)
    }

    override fun supports(type: Class<*>): Boolean {
        return RepoChangingItem::class.java == type
    }
}


@Component
class CollectingSettlementItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return CollectingSettlementItemKey(parts[0].toInt(), parts[1].toLong())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: CollectingSettlementItemKey = source as CollectingSettlementItemKey
        return String.format("%s_%s", id.settlement, id.order)
    }

    override fun supports(type: Class<*>): Boolean {
        return CollectingSettlementItem::class.java == type
    }
}


@Component
class PaymentSettlementItemKeyConverter : BackendIdConverter {

    override fun fromRequestId(id: String?, entityType: Class<*>): Serializable? {
        if (id == null) return null

        val parts = id.split("_")
        return PaymentSettlementItemKey(parts[0].toInt(), parts[1].toInt())
    }

    override fun toRequestId(source: Serializable, entityType: Class<*>): String {
        val id: PaymentSettlementItemKey = source as PaymentSettlementItemKey
        return String.format("%s_%s", id.settlement, id.order)
    }

    override fun supports(type: Class<*>): Boolean {
        return PaymentSettlementItem::class.java == type
    }
}
//endregion