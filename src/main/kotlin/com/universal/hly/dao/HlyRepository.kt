package com.universal.hly.dao

import com.universal.hly.model.*
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.NoRepositoryBean
import java.io.Serializable
import java.util.*

//import com.universal.hly.model.Order

/**
 * Created by swm on 2018-4-5
 */
@NoRepositoryBean
interface MyBaseRepository<T, ID : Serializable> : JpaRepository<T, ID> {

    fun findById(id: ID): Optional<T>

//    fun <S : T> save(entity: S): S
}

interface MaterialRepository : MyBaseRepository<Material, Long> {
    fun findByCode(code: String): List<Material>
    fun findByName(name: String): List<Material>
}

//@RepositoryRestResource(collectionResourceRel = "/api/data/client", path = "/api/data/client")
interface ClientRepository : MyBaseRepository<Client, Long> {
    fun findByName(name: String): List<Client>
}

interface OrderRepository : MyBaseRepository<Order, Long> {
    fun findByNo(code: String): Order
}

interface ProductRepository : MyBaseRepository<Product, Long> {
    fun findByCode(code: String): Product
}

interface ProduceConditionRepository : MyBaseRepository<ProduceCondition, Long> {
}
