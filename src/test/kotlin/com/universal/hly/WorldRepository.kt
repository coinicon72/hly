package com.universal.hly

import com.universal.hly.dao.FormulaItemRepository
import com.universal.hly.model.Formula
import javafx.application.Application
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.SpringBootConfiguration
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.context.annotation.Bean
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner
import org.springframework.test.context.junit4.SpringRunner

/**
 * Created by swm on 2018-4-3
 */
//@NoRepositoryBean
//interface MyBaseRepository<T, ID : Serializable> : JpaRepository<T, ID> {
//
//    fun findById(id: ID): Optional<T>
//
////    fun <S : T> save(entity: S): S
//}

//interface CityRepository : MyBaseRepository<City, Long> {
//    fun findByName(name: String): City
//    fun findByDistrict(dist: String): List<City>
//}
//fun main(args: Array<String>) {
//    val formula = Formula(1)
//}

//@ContextConfiguration
@SpringBootTest//(classes = [Application::class])
@AutoConfigureTestDatabase
@RunWith(SpringRunner::class)
@DataJpaTest
//@WebMvcTest
class TestJpa {
    @Autowired
    var formulaItemRepository: FormulaItemRepository? = null

    @Test
    fun findFormulaItems() {

        val items = formulaItemRepository?.findByFormula(3)
        items?.forEach(
                System.out::println
        )
    }
}