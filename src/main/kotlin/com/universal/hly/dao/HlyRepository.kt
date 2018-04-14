package com.universal.hly.dao

import com.universal.hly.model.*
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.NoRepositoryBean
import java.io.Serializable
import java.util.*
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import javax.transaction.Transactional


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

//@RepositoryRestResource(collectionResourceRel = "/api/data/client", path = "/api/data/client")
interface ClientRepository : MyBaseRepository<Client, Long>, ClientRepositoryCustom {
    fun findByName(name: String): List<Client>
}

interface OrderRepository : MyBaseRepository<Order, Long> {
    fun findByNo(no: String): Optional<Order>
}

interface OrderItemRepository : MyBaseRepository<OrderItem, Long> {
}

interface ProductRepository : MyBaseRepository<Product, Long> {
    fun findByCode(code: String): Optional<Product>
}

interface ProduceConditionRepository : MyBaseRepository<ProduceCondition, Long> {
    fun findByFormula(id: Long): Optional<ProduceCondition>
}

interface FormulaRepository : MyBaseRepository<Formula, Long> {
    fun findByProduct(id: Long): List<Formula>
}

interface FormulaItemRepository : MyBaseRepository<FormulaItem, Long> {
//    fun findByProduct(id: Long): List<FormulaItem>
}

interface MaterialRepository : MyBaseRepository<Material, Long> {
    fun findByCode(code: String): Optional<Material>
    fun findByName(name: String): Optional<Material>
}

interface MaterialTypeRepository : MyBaseRepository<MaterialType, Long> {
}

