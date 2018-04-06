package com.universal.hly.model

import java.io.Serializable
import java.util.*
import javax.persistence.*

/**
 * Created by swm on 2018-4-5
 */


@Entity
data class Client(
        @Id
        @GeneratedValue
        val id: Long? = null,

        @Column(nullable = false, length = 50)
//        @NaturalId
        val name: String = "",

        @Column(length = 100)
        val fullName: String? = null,

        @OneToMany(mappedBy = "client", cascade = [CascadeType.ALL]) // mappedBy is the key to remove join table
        val orders: MutableList<Order> = mutableListOf()
) {
//    fun addOrder(order: Order) {
//        orders.add()
//    }

    override fun toString(): String {
        return "Client(id=$id, name='$name', fullName=$fullName)"
    }
}


@Entity
@Table(name = "[order]",
        uniqueConstraints = [(UniqueConstraint(name = "uniq_order_no", columnNames = ["no"]))])
data class Order(
        @Id
        @GeneratedValue//(strategy = GenerationType.IDENTITY)
        val id: Long? = null,

        @Column(nullable = false, length = 20)
        val no: String = "",

        @ManyToOne
//        @JoinColumn(name = "client", foreignKey = ForeignKey(name = "fk_client_order"))
        @JoinColumn(foreignKey = ForeignKey(name = "fk_client_order"))
        val client: Client? = null,

        @Column(nullable = false)
        val orderDate: Date = Date(),

        @Column(nullable = false)
        val deliveryDate: Date = Date(),

        @ManyToOne
//        @JoinColumn(name = "product", foreignKey = ForeignKey(name = "fk_order_product"))
        @JoinColumn(foreignKey = ForeignKey(name = "fk_order_product"))
        val product: Product? = null,

        val quantity: Float = 0f
) {
    override fun toString(): String {
        return "Order(id=$id, no='$no', orderDate=$orderDate, deliveryDate=$deliveryDate, quantity=$quantity)"
    }
}


@Entity
data class Product(
        @Id
        @GeneratedValue
        val id: Long? = null,

        @Column(nullable = false, length = 20)
        val code: String = "",

        @Column(length = 20)
        val color: String = "",

        @Column(length = 50)
        val base: String = "",

        @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true)
//        @JoinColumn(name = "produce_condition", foreignKey = ForeignKey(name = "fk_product_produce_cond"))
        @PrimaryKeyJoinColumn
        var produceCondition: ProduceCondition? = null,

//        @OneToOne
////        @JoinColumns(value = [JoinColumn(name="id", referencedColumnName = "product_id", updatable = false), JoinColumn(name = "formula_revision", referencedColumnName = "revision", updatable = false)], foreignKey = ForeignKey(name = "fk_product_formula"))
////        val formulaRevision: FormulaRevision
//        @JoinColumn(foreignKey = ForeignKey(name = "fk_product_formula"))
//        val formula: Formula
        @OneToMany(mappedBy = "product", cascade = [CascadeType.ALL], orphanRemoval = true)
        val formulas: List<FormulaRevision> = LinkedList()
)


@Entity
data class ProduceCondition(
        @Id
        val id: Long? = null,

        @MapsId
        @OneToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_produce_cond_product"))
        val product: Product? = null,

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
        return "ProduceCondition(id=$id, mixTime=$mixTime, inputTemperature=$inputTemperature, outputTemperature=$outputTemperature, mesh=$mesh, mainMillerRpm=$mainMillerRpm, secondMillerRpm=$secondMillerRpm, screwRpm=$screwRpm)"
    }
}


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
//        val revisions: List<FormulaRevision>
//)


@Entity
@IdClass(FormulaRevisionKey::class)
data class FormulaRevision(
//        val id: Long,

        @Id
        @MapsId
        @ManyToOne
        @JoinColumn(foreignKey = ForeignKey(name = "fk_formula_rev_product"))
//        @Column(insertable = false, updatable = false)
        val product: Product,
//        val formula: Formula,

        @Id
//        @GeneratedValue(strategy = GenerationType.SEQUENCE)
        val revision: Int,

        @Column(nullable = false)
        val date: Date,

        @Column(length = 200)
        val changeLog: String,

        @Column(length = 200)
        val comment: String,

        @OneToMany(mappedBy = "formulaRevision")
        val items: List<FormulaItem>
)


data class FormulaRevisionKey(
        val product: Product,
//        val formula: Formula,
        val revision: Int
) : Serializable


@Entity
data class FormulaItem(
        @Id
        @ManyToOne
        @JoinColumns(value = [JoinColumn(name = "product_id", referencedColumnName = "product_id"),
            JoinColumn(name = "formula_revision", referencedColumnName = "revision")])
        val formulaRevision: FormulaRevision,

        @Id
        @ManyToOne
        val material: Material,

        val quantity: Float
) : Serializable


@Entity
data class Material(
        @Id
        @GeneratedValue
        val id: Long? = null,

        @Column(nullable = false, length = 20)
        val code: String = "",

        @Column(nullable = false, length = 50)
        val name: String = "",

//        val unit: String,
        @Column(length = 100)
        val comment: String? = null
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
