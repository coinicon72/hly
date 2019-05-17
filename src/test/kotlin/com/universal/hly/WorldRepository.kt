package com.universal.hly

import com.universal.hly.dao.FormulaItemRepository
import com.universal.hly.dao.UserRepository
import com.universal.hly.model.User
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit.jupiter.SpringExtension
import org.springframework.test.context.junit4.SpringRunner

/**
 * Created by swm on 2018-4-3
 */

//@ContextConfiguration
@SpringBootTest(classes = [Application::class])
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ExtendWith(SpringExtension::class)
@DataJpaTest
class TestJpa {
    @Autowired
    var formulaItemRepository: FormulaItemRepository? = null

    @Autowired
    lateinit var userRepository: UserRepository

    @Test
    fun findFormulaItems() {

        val items = formulaItemRepository?.findByFormula(3)
        items?.forEach(
                System.out::println
        )
    }

    @Test
    fun testUserRepo() {
//        val u1: User = userRepository.findById(1).get()
//        Assert.assertNull(u1)

        val u2 = userRepository.findById(20).get()
        assertNotNull(u2)
        assertEquals(u2.name, "陈锦海")

        val u3 = userRepository.getByPhone("15917885784")
        assertNotNull(u3)
        assertEquals(u3?.name, "邱谷娣")
    }
}