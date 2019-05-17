package com.universal.hly

import com.universal.hly.security.getUserIdFromJWT
import com.universal.hly.security.signJWT
import com.universal.hly.security.verifyJWT
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit.jupiter.SpringExtension
import org.springframework.test.context.junit4.SpringRunner

@SpringBootTest
@ExtendWith(SpringExtension::class)
class TestJWT {

    val uid = 1
    val secret = "cao.123"

    @Test
    fun testSignJWT() {
        val jwt = signJWT(uid, secret) ?: throw RuntimeException("signJWT failed")

        assertNotNull(jwt)

        assertTrue(verifyJWT(jwt, uid, secret))

        assertEquals(getUserIdFromJWT(jwt), uid)
    }
}


class TestJson {

    @Test
    fun testJson() {
//        val order = Order()
//        val orderItemKey = OrderItemKey(5, 6)
//        val deliverySheetItem = DeliverySheetItem(
//                DeliverySheetItemKey(2, orderItemKey),
//                DeliverySheet(2, order, Date()),
//                OrderItem(orderItemKey, order, Product())
//        )
//
//        val objectMapper = ObjectMapper()
//
//        val json = objectMapper.writeValueAsString(deliverySheetItem)
//        println(json)
//
//        val dsi = objectMapper.readValue<DeliverySheetItem>("""{"id": {"deliverySheet": 2, "orderItem": {"order": 5, "product":6 }}, "deliverySheet": {"id": 2}, "orderItem": {"id": {"order": 5,"product": 6}, "order": {"id":5}, "product": {"id":6}}, "quantity": 10, "boxes": 1, "price": 5.3, "comment": "test" }""")
//        println(dsi)
    }
}
