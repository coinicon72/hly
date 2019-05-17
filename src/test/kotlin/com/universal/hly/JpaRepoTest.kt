package com.universal.hly

import com.universal.hly.dao.InventoryRepository
import com.universal.hly.dao.RepoHistoryRepository
import com.universal.hly.model.*
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.test.context.junit.jupiter.SpringExtension
import javax.persistence.EntityManager

//@SpringBootTest(classes = [Application::class])
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ExtendWith(SpringExtension::class)
@DataJpaTest // 此注解使用in-memory db，且忽略了其他auto-config（如：权限检测）
//@TestInstance(TestInstance.Lifecycle.PER_CLASS) // for non-static @BeforeAll @AfterAll
class JpaRepoTest {
//    private val log: Logger = LoggerFactory.getLogger(JpaRepoTest::class.simpleName)

    @Autowired
    lateinit var em: EntityManager

    @Autowired
    lateinit var inventoryRepository: InventoryRepository

    @Autowired
    lateinit var repoHistoryRepository: RepoHistoryRepository

//    @BeforeAll
//    fun setUp() {
//    }
//
//    @AfterAll
//    fun tearDown() {
//    }

    @Test
    fun whatIsManagedEntityAndHowToRefreshIt() {
        val repo = Repo(id = 1)
        val reportBy = User(id = 10)

        //
        println("saved entity will be managed by EntityManager")

        val inventory = Inventory(id = 0,
                repo = repo,
                comment = "test",
                reportBy = reportBy)

        assertTrue(!em.contains(inventory))

        inventoryRepository.saveAndFlush(inventory)

        assertTrue(inventory.id > 0)
        assertTrue(em.contains(inventory))


        // save children entities directly (not via managed parent entity)
        val material = Material(id = 2)

        repoHistoryRepository.saveAndFlush(RepoHistory(id = RepoHistoryKey(inventory.id, repo.id, material.id),
                inventory = inventory,
                repo = repo,
                material = material))


        //
        println("refresh managed entity will reload data from database")

        assertEquals(0, inventory.items.size)

        em.refresh(inventory)

        assertEquals(1, inventory.items.size)
    }

    @Test
    fun saveChildrenWithManagedParent() {
        val repo = Repo(id = 1)
        val reportBy = User(id = 10)

        //
        val inventory = Inventory(id = 0,
                repo = repo,
                comment = "test2",
                reportBy = reportBy)

        inventoryRepository.saveAndFlush(inventory)


        // check children
        var histories = repoHistoryRepository.findAll()
        assertEquals(0, histories.size)


        // save children via persist parent entity)
        val material = Material(id = 2)

        val history = RepoHistory(
//                id = RepoHistoryKey(inventory.id, repo.id, material.id),
                id = RepoHistoryKey(0, 0, 0),
                repo = repo,
                material = material,
                price = 1.23f,
                quantity = 3.45f
        )

        inventory.addItem(history)


//        repoHistoryRepository.saveAndFlush()
        inventoryRepository.saveAndFlush(inventory)


        //
        histories = repoHistoryRepository.findAll()
//        em.refresh(histories)

        assertEquals(1, histories.size)
        assertTrue(histories.contains(history))
    }

    @Test
    fun saveChildrenWithTransientParent() {
        val repo = Repo(id = 1)
        val reportBy = User(id = 10)
        val material = Material(id = 2)

        //
        val history = RepoHistory(
//                id = RepoHistoryKey(inventory.id, repo.id, material.id),
                id = RepoHistoryKey(0, 0, 0),
                repo = repo,
                material = material,
                price = 1.23f,
                quantity = 3.45f
        )

        //
        val inventory = Inventory(id = 0,
                repo = repo,
                comment = "test2",
                reportBy = reportBy)

        // MUST persist parent first to make parent be managed
        inventoryRepository.saveAndFlush(inventory)

        // then persist children
        inventory.addItem(history)
        inventoryRepository.saveAndFlush(inventory)


        //
        val histories = repoHistoryRepository.findAll()

        assertEquals(1, histories.size)
        assertEquals(RepoHistoryKey(inventory.id, repo.id, material.id), histories[0].id)
        assertTrue(histories.contains(history))
    }
}