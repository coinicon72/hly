package com.universal.hly.model

import org.hibernate.annotations.NaturalId
import org.springframework.data.rest.core.config.Projection
import java.io.Serializable
import java.util.*
import javax.persistence.*

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
        @GeneratedValue
        val id: Long? = null,

        @Column(nullable = false, length = 50)
        val name: String = ""
) //: MetaData()


@Entity
//@Table(uniqueConstraints = [UniqueConstraint(name = "uniq_Client_contract_no", columnNames = ["contractNo"])])
data class Client(
        @Id
        @GeneratedValue
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

        @OneToMany(mappedBy = "client", cascade = [CascadeType.ALL]) // mappedBy is the key to remove join table
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
@Table(name = "[order]")
//,
//        uniqueConstraints = [(UniqueConstraint(name = "uniq_order_no", columnNames = ["no"]))])
data class Order(
        @Id
        @GeneratedValue//(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

        @Column(unique = true, nullable = false, length = 20)
        val no: String = "",

        @ManyToOne
//        @JoinColumn(name = "client", foreignKey = ForeignKey(name = "fk_client_order"))
        @JoinColumn(foreignKey = ForeignKey(name = "fk_client_order"))
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

        val value: Float,
        val actualValue: Float,

        val comment: String? = null,

        @Column(length = 500)
        val metadata: String? = null
) {
    override fun toString(): String {
        return "Order(id=$id, no='$no', client=$client, orderDate=$orderDate, deliveryDate=$deliveryDate, tax=$tax, value=$value, actualValue=$actualValue)"
    }
}


@Entity
@IdClass(OrderItemKey::class)
data class OrderItem(
        @Id
//        @GeneratedValue//(strategy = GenerationType.IDENTITY)
//        val id: Long? = null,

        @MapsId
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_item_order"))
        val order: Order? = null,

        @Id
        @MapsId
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_item_product"))
        val product: Product? = null,

        @Column(nullable = false)
        val quantity: Float = 0f,
        val actualQuantity: Float? = null,

        val price: Float = 0f
) : Serializable


data class OrderItemKey(
        val order: Long,
        val product: Long
) : Serializable


@Entity
data class Product(
        @Id
        @GeneratedValue
        val id: Long? = null,

        @NaturalId
        @Column(unique = true, nullable = false, length = 20)
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
        @OneToMany(mappedBy = "product", cascade = [CascadeType.ALL], orphanRemoval = true)
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
        @GeneratedValue
        val id: Long,

//        @Id
//        @GeneratedValue(strategy = GenerationType.SEQUENCE)
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

        @OneToOne//(cascade = [CascadeType.ALL], orphanRemoval = true)
//        @JoinColumn(name = "produce_condition", foreignKey = ForeignKey(name = "fk_product_produce_cond"))
        @PrimaryKeyJoinColumn
        var produceCondition: ProduceCondition? = null,

        @OneToMany(mappedBy = "formula")
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
        @OneToOne(cascade = [CascadeType.PERSIST, CascadeType.MERGE], fetch = FetchType.LAZY)
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
// id and formula/material obj are all need
//
// following to add new row, id has no used, fk identified by {"formula": {"id": 2}, "material": {"id": 2}}
// {"quantity": 8, "id": {"formula": ?, "material": ?}, "formula": {"id": 2}, "material": {"id": 2}}
//
// following to update row, id used to identify row, {"formula": {"id": 2}, "material": {"id": 2}} will not used
// {"quantity": 8, "id": {"formula": 2, "material": 2}, "formula": {"id": ?}, "material": {"id": ?}}

@Entity
//@IdClass(FormulaItemKey::class)
data class FormulaItem(
        @EmbeddedId
        val id: FormulaItemKey,

//        @Id
        @MapsId("formula")
        @ManyToOne//(cascade = [CascadeType.MERGE], fetch = FetchType.LAZY)
        @JoinColumn( foreignKey = ForeignKey(name = "fk_formula_item_formula"))
//        @JoinColumns(value = [JoinColumn(name = "product_id", referencedColumnName = "product_id"),
//            JoinColumn(name = "formula_revision", referencedColumnName = "revision")])
        val formula: Formula,

//        @Id
        @MapsId("material")
        @ManyToOne//(cascade = [CascadeType.MERGE], fetch = FetchType.LAZY)
        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_item_material"))
        val material: Material,

        val quantity: Float
) : Serializable

@Embeddable
data class FormulaItemKey(
        @Column//(name = "formula_id")//, insertable = false, updatable = false)
        val formula: Long = 0,

        @Column//(name = "material_id")//, insertable = false, updatable = false)
        val material: Long = 0
) : Serializable

interface InlineMaterial {

}

@Entity
data class Material(
        @Id
        @GeneratedValue
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
    fun getComment(): String
    fun getMetadata(): String
}


@Entity
data class MaterialType(
        @Id
        @GeneratedValue
        val id: Long? = null,

        @Column(nullable = false, length = 50)
        val name: String = ""
)

//data class RecipyItemKey (
//        val material: Material,
//        val quantity: Float
//) : Serializable
//
//
//@Embeddable
//data class Recipe(
////        @Id
////        @GeneratedValue(strategy = GenerationType.IDENTITY)
////        val id: Long,
//
//        @NotBlank
//        val code: String,
//
//        @NotBlank
//        val name: String,
//
//        val comment: String,
//
//        val reversion: RecipeReversion
//)


//@Entity
//data class ProductTest(
//        val product: Product,
//
//        val mixTime: Int,
//
//        val inputTemperature: Int,
//        val outputTemperature: Int,
//
//        val mesh: Int,
//
//        val mainMillerRpm: Int,
//        val secondMillerRpm: Int,
//        val screwRpm: Int
//)
