package com.universal.hly

import com.universal.hly.security.getUserIdFromJWT
import com.universal.hly.security.signJWT
import com.universal.hly.security.verifyJWT
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit4.SpringRunner

@SpringBootTest
@RunWith(SpringRunner::class)
class TestJWT {

    val uid = 1
    val secret = "cao.123"

    @Test
    fun testSignJWT() {
        val jwt = signJWT(uid, secret) ?: throw RuntimeException("signJWT failed")

        Assert.assertNotNull(jwt)

        Assert.assertTrue(verifyJWT(jwt, uid, secret))

        Assert.assertEquals(getUserIdFromJWT(jwt), uid)
    }
}