package com.universal.hly.dao

import com.universal.hly.model.*
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.NoRepositoryBean
import org.springframework.data.repository.query.Param
import org.springframework.data.rest.core.annotation.RepositoryRestResource
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


interface BomRepository : MyBaseRepository<Bom, Long> {
}


interface BomItemRepository : MyBaseRepository<BomItem, BomItemKey> {
}
