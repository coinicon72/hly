package com.universal.hly.model

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonInclude
import org.hibernate.annotations.NaturalId
import org.hibernate.annotations.OnDelete
import org.hibernate.annotations.OnDeleteAction
import org.springframework.data.rest.core.config.Projection
import java.io.Serializable
import java.util.*
import javax.persistence.*
import kotlin.collections.ArrayList

/**
 * Created by swm on 2018-4-5
 */

//open class MetaData(
//        @Column(length = 500)
//        val meta: String? = null
//)

@Entity
data class ClientType(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

        @Column(nullable = false, length = 50)
        val name: String = ""
) //: MetaData()


@Entity
//@Table(uniqueConstraints = [UniqueConstraint(name = "uniq_Client_contract_no", columnNames = ["contractNo"])])
data class Client(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

        @Column(nullable = false, length = 50)
//        @NaturalId
        val name: String = "",

        @Column(length = 100)
        val fullName: String? = null,

        @ManyToOne(fetch = FetchType.EAGER)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_client_type"))
        val type: ClientType? = null,

        @NaturalId
        @Column(unique = true, nullable = false, length = 50)
        val contractNo: String = "",

        @Column(length = 100)
        val settlementPolicy: String? = null,

        @Column(length = 200)
        val address: String? = null,

        @Column(length = 200)
        val deliveryAddress: String? = null,

        @Column(length = 6)
        val postCode: String? = null,

        @Column(length = 30)
        val contact: String? = null,

        @Column(length = 30)
        val phone: String? = null,

        val comment: String? = null,

        @Column(length = 500)
        val metadata: String? = null,

        @OneToMany(mappedBy = "client")//, cascade = [CascadeType.ALL]) // mappedBy is the key to remove join table
        val orders: MutableList<Order> = mutableListOf()
) {
//    fun addOrder(order: Order) {
//        orders.add()
//    }

    override fun toString(): String {
        return "Client(id=$id, name='$name', fullName=$fullName, type=$type, contractNo='$contractNo', settlementPolicy=$settlementPolicy, address=$address, deliveryAddress=$deliveryAddress, postCode=$postCode, contact=$contact, phone=$phone, comment=$comment, metadata=$metadata)"
    }
}

@Projection(types = [Client::class])
interface InlineClientType {
    fun getId(): Long
    fun getName(): String
    fun getFullName(): String
    fun getType(): ClientType
    fun getContractNo(): String
    fun getSettlementPolicy(): String
    fun getAddress(): String
    fun getDeliveryAddress(): String
    fun getPostCode(): String
    fun getContact(): String
    fun getPhone(): String
    fun getComment(): String
    fun getMetadata(): String
}


@Entity
@Table(name = "[order]",
        uniqueConstraints = [(UniqueConstraint(name = "uk_order_no", columnNames = ["no"]))])
data class Order(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

//        @NaturalId
        @Column(unique = true, nullable = false, length = 20)
        val no: String = "",

        @ManyToOne//(fetch = FetchType.EAGER)
//        @JoinColumn(name = "client", foreignKey = ForeignKey(name = "fk_client_order"))
        @JoinColumn(nullable = false, foreignKey = ForeignKey(name = "fk_client_order"))
        val client: Client? = null,

        @Column(nullable = false)
        val orderDate: Date = Date(),

        @Column(nullable = false)
        val deliveryDate: Date = Date(),

        @OneToMany(mappedBy = "order")
//        @JoinColumn(name = "product", foreignKey = ForeignKey(name = "fk_order_product"))
//        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_product"))
//        val product: Product? = null,
//        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_details"))
        val items: List<OrderItem> = LinkedList(),

        val tax: Boolean = false,

        val value: Float = 0f,
        val actualValue: Float?,

        val comment: String? = null,

        @Column(length = 500)
        val metadata: String? = null,

        // 订单状态, 0 = 签订, 1 = 执行中, 2 = 已完成, 3 = 取消
        @Column(nullable = false, columnDefinition = "tinyint default 0")
        val status: Int = 0
) {
    override fun toString(): String {
        return "Order(id=$id, no='$no', orderDate=$orderDate, deliveryDate=$deliveryDate, tax=$tax, value=$value, actualValue=$actualValue, comment=$comment, metadata=$metadata, status=$status)"
    }
}


@Entity
//@IdClass(OrderItemKey::class)
data class OrderItem(
        @EmbeddedId
//        @GeneratedValue(strategy = GenerationType.IDENTITY)
//        val id: Long? = null,
        val id: OrderItemKey,

        @MapsId("order")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_item_order"))
        val order: Order,

//        @Id
        @MapsId("product")
        @ManyToOne(fetch = FetchType.EAGER)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_item_product"))
        val product: Product,

        @Column(nullable = false)
        val quantity: Float = 0f,

        val actualQuantity: Float? = null,

        val price: Float = 0f,

        @OneToOne(mappedBy = "orderItem")
        val bom: Bom? = null
) : Serializable


@Projection(name = "InlineOrderAndProductType", types = [OrderItem::class])
interface InlineOrderAndProductType {
    fun getId(): OrderItemKey
    fun getQuantity(): Float
    fun getActualQuantity(): Float?
    fun getPrice(): Float
    fun getOrder(): Order
    fun getProduct(): Product
}


@Embeddable
data class OrderItemKey(
        val order: Long,
        val product: Long
) : Serializable


@Entity
@Table(uniqueConstraints = [(UniqueConstraint(name = "uk_product_code", columnNames = ["code"]))])
data class Product(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

//        @NaturalId
        @Column(nullable = false, length = 20)
        val code: String = "",

        @Column(length = 20)
        val color: String = "",

        @Column(length = 50)
        val base: String = "",

        val comment: String? = null,

        @Column(length = 500)
        val metadata: String? = null,

//        @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true)
////        @JoinColumn(name = "produce_condition", foreignKey = ForeignKey(name = "fk_product_produce_cond"))
//        @PrimaryKeyJoinColumn
//        var produceCondition: ProduceCondition? = null,

//        @OneToOne
////        @JoinColumns(value = [JoinColumn(name="id", referencedColumnName = "product_id", updatable = false), JoinColumn(name = "formula_revision", referencedColumnName = "revision", updatable = false)], foreignKey = ForeignKey(name = "fk_product_formula"))
////        val formula: Formula
//        @JoinColumn(foreignKey = ForeignKey(name = "fk_product_formula"))
//        val formula: Formula
        @OneToMany(mappedBy = "product", cascade = [CascadeType.REMOVE], orphanRemoval = true)
        val formulas: List<Formula> = LinkedList()
)


//@Entity
//data class Formula(
//        @Id
//        val id: Long,
//
//        @Column(length = 200)
//        val comment: String,
//
//        @OneToMany
////        @JoinColumn(name = "re")
//        val revisions: List<Formula>
//)


@Entity
//@IdClass(FormulaKey::class)
@Table(uniqueConstraints = [UniqueConstraint(name = "uniq_formula_revision", columnNames = ["product_id", "revision"])])
data class Formula(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long,

//        @Id
//        @GeneratedValue(strategy = GenerationType.IDENTITY)(strategy = GenerationType.SEQUENCE)
        val revision: Int = 0,

//        @MapsId
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_rev_product"))
//        @Column(insertable = false, updatable = false)
        val product: Product? = null,
//        val formula: Formula,

        @Column(nullable = false)
        val createDate: Date = Date(),

        @Column(length = 200)
        val changeLog: String? = null,

        val comment: String? = null,

        @Column(length = 500)
        val metadata: String? = null,

        @OneToOne(cascade = [CascadeType.REMOVE])//, orphanRemoval = true)
//        @JoinColumn(name = "produce_condition", foreignKey = ForeignKey(name = "fk_product_produce_cond"))
        @PrimaryKeyJoinColumn
        @OnDelete(action = OnDeleteAction.CASCADE)
        var produceCondition: ProduceCondition? = null,

        @OneToMany(mappedBy = "formula", cascade = [CascadeType.REMOVE])
        @OnDelete(action = OnDeleteAction.CASCADE)
        val items: List<FormulaItem> = LinkedList()
)


//data class FormulaKey(
////        val product: Product,
////        val formula: Formula,
//        val id: Long,
//        val revision: Int
//) : Serializable


@Entity
data class ProduceCondition(
        @Id
        val id: Long? = null,

        @MapsId
        @OneToOne(fetch = FetchType.LAZY)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_produce_cond"))
        val formula: Formula? = null,

        @Column(nullable = false)
        val mixTime: Int = -1,

        @Column(nullable = false)
        val inputTemperature: Int = -1,

        @Column(nullable = false)
        val outputTemperature: Int = -1,

        @Column(nullable = false)
        val mesh: Int = -1,

        @Column(nullable = false)
        val mainMillerRpm: Int = -1,

        @Column(nullable = false)
        val secondMillerRpm: Int = -1,

        @Column(nullable = false)
        val screwRpm: Int = -1
) {
    override fun toString(): String {
        return "ProduceCondition(mixTime=$mixTime, inputTemperature=$inputTemperature, outputTemperature=$outputTemperature, mesh=$mesh, mainMillerRpm=$mainMillerRpm, secondMillerRpm=$secondMillerRpm, screwRpm=$screwRpm)"
    }
}


// =================================================================================================
// the @IdClass approach will lead to "detached entity passed to persist" error, don't know why

// id and formula/material obj are all need
//
// following to add new row, id has no used, fk identified by {"formula": {"id": 2}, "material": {"id": 2}}
// {"quantity": 8, "id": {"formula": ?, "material": ?}, "formula": {"id": 2}, "material": {"id": 2}}
//
// following to update row, id used to identify row, {"formula": {"id": 2}, "material": {"id": 2}} will not used
// {"quantity": 8, "id": {"formula": 2, "material": 2}, "formula": {"id": ?}, "material": {"id": ?}}

@Entity
data class FormulaItem(
        @EmbeddedId
        val id: FormulaItemKey,

        @MapsId("formula")
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_item_formula"))
//        @JoinColumns(value = [JoinColumn(name = "product_id", referencedColumnName = "product_id"),
//            JoinColumn(name = "formula_revision", referencedColumnName = "revision")])
        val formula: Formula,

        @MapsId("material")
        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_item_material"))
        val material: Material,

        val quantity: Float
) : Serializable

@Embeddable
data class FormulaItemKey(
//        @Column//(name = "formula_id")//, insertable = false, updatable = false)
        val formula: Long = 0,

//        @Column//(name = "material_id")//, insertable = false, updatable = false)
        val material: Long = 0
) : Serializable


// the @IdClass approach
//
//@Entity
//@IdClass(FormulaItemKey::class)
//data class FormulaItem(
//        @Id
//        @ManyToOne//(cascade = [CascadeType.MERGE], fetch = FetchType.LAZY)
//        @JoinColumn( foreignKey = ForeignKey(name = "fk_formula_item_formula"))
//        val formula: Formula,
//
//        @Id
//        @ManyToOne//(cascade = [CascadeType.MERGE], fetch = FetchType.LAZY)
//        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_item_material"))
//        val material: Material,
//
//        val quantity: Float
//) : Serializable
//
//data class FormulaItemKey(
//        val formula: Long = 0,
//
//        val material: Long = 0
//) : Serializable


interface InlineMaterial {

}

@Entity
data class Material(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

        @NaturalId
        @Column(length = 20)//, unique = true, nullable = false)
        val code: String = "",

        @Column(nullable = false, length = 50)
        val name: String = "",

        @ManyToOne//(fetch = FetchType.EAGER)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_material_type"))
        val type: MaterialType? = null,

        @Column(nullable = false)
        val safeQuantity: Float = 0f,

        val spec: String? = null,

//        val unit: String,

        val comment: String? = null,

        @Column(length = 500)
        val metadata: String? = null
) : Serializable

@Projection(name = "InlineMaterialType", types = [Material::class])
interface InlineMaterialType {
    fun getId(): Long
    fun getCode(): String
    fun getName(): String
    fun getType(): MaterialType
    fun getSafeQuantity(): Float
    fun getSpec(): String
    fun getComment(): String
    fun getMetadata(): String
}


@Entity
data class MaterialType(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

        @Column(nullable = false, length = 50)
        val name: String = ""
)


@Entity
data class Bom(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long = 0,

//       @Id
        @OneToOne(fetch = FetchType.EAGER)
        @JoinColumns(JoinColumn(name = "order_id", referencedColumnName = "order_id",
                foreignKey = ForeignKey(name = "fk_bom_order_id")),
                JoinColumn(name = "product_id", referencedColumnName = "product_id"),
                foreignKey = ForeignKey(name = "fk_bom_product_id"))
        val orderItem: OrderItem? = null,

        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_bom_formula_id"))
        val formula: Formula? = null,

        @Column(nullable = false, columnDefinition = "datetime default now()")
        val createDate: Date = Date(),

        @OneToMany(mappedBy = "bom")
        val items: List<BomItem> = LinkedList()
)


@Projection(name = "InlineOrderItemAndFormulaType", types = [Bom::class])
interface InlineOrderItemAndFormulaType {
    fun getId(): Long
    fun getCreateDate(): Date
    fun getFormula(): Formula
    fun getOrderItem(): OrderItem
}


@Entity
data class BomItem(
        @EmbeddedId
        val id: BomItemKey,

        @MapsId("bom")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_bom_item_bom"))
        val bom: Bom,

        @MapsId("material")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_bom_material"))
        val material: Material,

        val calcQuantity: Float = 0f,
        val quantity: Float = 0f
) : Serializable


@Embeddable
data class BomItemKey(
        val bom: Long = 0,
        val material: Long = 0
) : Serializable


// ==================
@Entity
data class Repo(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        val name: String? = null,

        val type: Int = 0,

        val comment: String? = null
)

@Entity
data class RepoItem(
        @EmbeddedId
        val id: RepoItemKey,

        @MapsId(value = "repo")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_repo_item_repo"))
        val repo: Repo? = null,

        @MapsId(value = "material")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_repo_item_material"))
        val material: Material? = null,

        var quantity: Float? = null,

        var price: Float? = null
)

@Embeddable
data class RepoItemKey(
        val repo: Int = 0,
        val material: Long = 0
) : Serializable


@Entity
data class Inventory(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        val date: Date = Date(),

        val comment: String? = null
)


@Entity
data class RepoHistory(
        @EmbeddedId
        val id: RepoHistoryKey,

        @MapsId(value = "inventory")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_repo_history_inventory"))
        val inventory: Inventory? = null,

        @MapsId(value = "material")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_repo_history_material"))
        val material: Material? = null,

        val quantity: Float = 0f,
        val price: Float = 0f
) : Serializable

@Embeddable
data class RepoHistoryKey(
        val inventory: Int = 0,
        val material: Long = 0
) : Serializable


@Entity
data class RepoChangingReason(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        val type: Int? = null,

        val reason: String? = null,

        val orderRelated: Boolean = false
)


@Entity
@NamedNativeQueries(
        NamedNativeQuery(name = "RepoChanging.previewStockIn",
                query = "call preview_stock_in_changing(:cid)",
                resultClass = StockInPreview::class,
                resultSetMapping = "stockInPreview"
        ),
        NamedNativeQuery(name = "RepoChanging.previewStockOut",
                query = "call preview_stock_out_changing(:cid)",
                resultClass = StockOutPreview::class,
                resultSetMapping = "stockOutPreview"
        )
)
@SqlResultSetMappings(SqlResultSetMapping(name = "stockInPreview",
        classes = [ConstructorResult(targetClass = StockInPreview::class,
                columns = [
                    ColumnResult(name = "repo_id", type = Int::class),
                    ColumnResult(name = "material_id", type = Int::class),
                    ColumnResult(name = "current_quantity", type = Float::class),
                    ColumnResult(name = "current_price", type = Float::class),
                    ColumnResult(name = "in_quantity", type = Float::class),
                    ColumnResult(name = "in_price", type = Float::class),
                    ColumnResult(name = "new_quantity", type = Float::class),
                    ColumnResult(name = "new_price", type = Float::class)
                ])]),
        SqlResultSetMapping(name = "stockOutPreview",
                classes = [ConstructorResult(targetClass = StockOutPreview::class,
                        columns = [
                            ColumnResult(name = "repo_id", type = Int::class),
                            ColumnResult(name = "material_id", type = Int::class),
                            ColumnResult(name = "quantity", type = Float::class),
                            ColumnResult(name = "require_quantity", type = Float::class),
                            ColumnResult(name = "fulfilled", type = Boolean::class)
                        ])])
)
@NamedStoredProcedureQueries(
        NamedStoredProcedureQuery(
                name = "applyStockInChanging",
                procedureName = "apply_stock_in_changing",
//            resultClasses = { Car.class },
                parameters = [
                    StoredProcedureParameter(name = "cid", type = Integer::class, mode = ParameterMode.IN),
                    StoredProcedureParameter(name = "executor", type = Integer::class, mode = ParameterMode.IN),
                    StoredProcedureParameter(name = "comment", type = String::class, mode = ParameterMode.IN)
                ]
        ),
        NamedStoredProcedureQuery(
                name = "applyStockOutChanging",
                procedureName = "apply_stock_out_changing",
//            resultClasses = { Car.class },
                parameters = [
                    StoredProcedureParameter(name = "cid", type = Integer::class, mode = ParameterMode.IN),
                    StoredProcedureParameter(name = "executor", type = Integer::class, mode = ParameterMode.IN),
                    StoredProcedureParameter(name = "comment", type = String::class, mode = ParameterMode.IN)
                ]
        )
)
data class RepoChanging(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        @ManyToOne(fetch = FetchType.EAGER)
        val repo: Repo? = null,

        /**
         *  1 = in-stock, 入库; -1 = out-stock, 出库; 0 = inventory
         */
        val type: Int = 0,

        /**
         * 0 = init; 1 = submitted; 2 = executed; -1 = rejected
         */
        val status: Int = 0,

        val createDate: Date = Date(),

        @ManyToOne//(optional = true, fetch = FetchType.EAGER)
        @JoinColumn(name = "applicant")
        val applicant: User? = null,

        val applyingDate: Date? = null,

        @ManyToOne(optional = true, fetch = FetchType.EAGER)
        val reason: RepoChangingReason? = null,

//        @Column(name = "reason")
        val reasonDetail: String? = null,

        @ManyToOne(optional = true, fetch = FetchType.EAGER)
        val order: Order? = null,

        val department: String? = null,

        val vat: Float = 0f,
        val vatInclusiveValue: Float = 0f,
        val value: Float = 0f,

        val keeper: String? = null,
        val executeDate: Date? = null,
        val comment: String? = null,

        @OneToMany(mappedBy = "repoChanging")
        val items: List<RepoChangingItem> = LinkedList()
)


@Projection(name = "InlineRepoChanging", types = [RepoChanging::class])
interface InlineRepoChanging {
    fun getId(): Int
    fun getRepo(): Repo?
    fun getType(): Int
    fun getStatus(): Int
    fun getCreateDate(): Date
    fun getApplicant(): User
    fun getApplyingDate(): Date?
    fun getReason(): RepoChangingReason
    fun getReasonDetail(): String?
    fun getOrder(): Order?
    fun getDepartment(): String?
    fun getVat(): Float
    fun getVatInclusiveValue(): Float
    fun getValue(): Float
    fun getKeeper(): String?
    fun getExecuteDate(): Date?
    fun getComment(): String?
}


@Entity
data class RepoChangingItem(
        @EmbeddedId
        val id: RepoChangingItemKey,

        @MapsId(value = "repoChanging")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_repo_changing_item_repo_changing"))
        val repoChanging: RepoChanging,

        @MapsId(value = "material")
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_repo_changing_material"))
        val material: Material,

        val quantity: Float = 0f,

        val vatInclusivePrice: Float = 0f,
        val price: Float = 0f
) : Serializable

@Embeddable
data class RepoChangingItemKey(
        val repoChanging: Int = 0,
        val material: Long = 0
) : Serializable


//@SqlResultSetMapping(name = "stockInPreview",
//        classes = [ConstructorResult(targetClass = StockInPreview::class,
//                columns = [
//                    ColumnResult(name = "material_id", type = Long::class),
//                    ColumnResult(name = "current_quantity", type = Float::class),
//                    ColumnResult(name = "current_price", type = Float::class),
//                    ColumnResult(name = "in_quantity", type = Float::class),
//                    ColumnResult(name = "in_price", type = Float::class),
//                    ColumnResult(name = "new_quantity", type = Float::class),
//                    ColumnResult(name = "new_price", type = Float::class)
//                ])])
data class StockInPreview(
        val repoId: Int,
        val materialId: Int,

        val currentQuantity: Float = 0f,
        val currentPrice: Float = 0f,

        val inQuantity: Float = 0f,
        val inPrice: Float = 0f,

        val newQuantity: Float = 0f,
        val newPrice: Float = 0f
)

//@SqlResultSetMapping(name = "stockOutPreview",
//        classes = [ConstructorResult(targetClass = StockOutPreview::class,
//                columns = [
//                    ColumnResult(name = "material_id", type = Long::class),
//                    ColumnResult(name = "quantity", type = Float::class),
//                    ColumnResult(name = "require_quantity", type = Float::class),
//                    ColumnResult(name = "fulfilled", type = Boolean::class)
//                ])])
data class StockOutPreview(
//        @Id
        val repoId: Int,
        val materialId: Int,

//        @MapsId
//        @OneToOne
//        val material: Material? = null,

        val repoQuantity: Float = 0f,
        val requireQuantity: Float = 0f,

        val fulfilled: Boolean = false
)


@Entity
data class Organization(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        @ManyToOne
        @JoinColumn(name = "parent")
        val parent: Organization? = null,

        val hs: String? = null,

        val type: Int = 0,

        val info: String? = null
)


@Entity
//@NamedNativeQueries(
//        NamedNativeQuery(name = "User.findAll",
//                query = "select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1",
//                resultClass = User::class,
//                resultSetMapping = "UserMapping"
//        ),
//        NamedNativeQuery(name = "User.findById",
//                query = "select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1 and id=:id",
//                resultClass = User::class,
//                resultSetMapping = "UserMapping"
//        ),
//        NamedNativeQuery(name = "User.findByPhone",
//                query = "select id, info->>'\$.name' name, info->>'\$.phone' phone, " +
//            "info->>'\$.title' title, info->>'\$.pwd' password " +
//            "from organization o where o.type = 1 and phone=:phone",
//                resultClass = User::class,
//                resultSetMapping = "UserMapping"
//        )
//)
//
//@SqlResultSetMappings(SqlResultSetMapping(name = "UserMapping",
//        classes = [ConstructorResult(targetClass = User::class,
//                columns = [
//                    ColumnResult(name = "id", type = Int::class),
//                    ColumnResult(name = "name", type = String::class),
//                    ColumnResult(name = "phone", type = String::class),
//                    ColumnResult(name = "title", type = String::class),
//                    ColumnResult(name = "password", type = String::class)
//                ])])
//)

data class User(
        @Id
        val id: Int,

        val name: String? = null,

        val phone: String? = null,

//        val title: String? = null,

        @JsonIgnore
        val password: String? = null,

        val disabled: Boolean = false,

        @ManyToMany//(fetch = FetchType.EAGER)
        @JoinTable(name = "user_role",
                joinColumns = [JoinColumn(name = "user_id", referencedColumnName = "id")],
                inverseJoinColumns = [JoinColumn(name = "role_id", referencedColumnName = "id")]
        )
        val roles: List<Role> = ArrayList()
)


@Entity
data class Role(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        val code: String? = null,

        val name: String? = null,

        @JsonInclude(JsonInclude.Include.NON_NULL)
        val comment: String? = null,

        @ManyToMany//(fetch = FetchType.EAGER)
        @JoinTable(name = "role_privilege",
                joinColumns = [JoinColumn(name = "role_id", referencedColumnName = "id")],
                inverseJoinColumns = [JoinColumn(name = "privilege_id", referencedColumnName = "id")]
        )
        val privileges: List<Privilege> = ArrayList()
)


@Entity
data class Privilege(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        val code: String? = null,

        val name: String? = null,

        @JsonInclude(JsonInclude.Include.NON_NULL)
        val comment: String? = null
)
