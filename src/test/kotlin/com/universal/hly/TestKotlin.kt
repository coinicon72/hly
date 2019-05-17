package com.universal.hly

import com.universal.hly.model.RepoHistory
import com.universal.hly.model.RepoHistoryKey
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test

class TestKotlin {
    @Test
    fun testString() {
        val i = "100".toInt()
        println(i)
    }


    @Test
    fun testCollectionContains() {
        val list: MutableList<RepoHistory> = mutableListOf()

        list.add(RepoHistory(id = RepoHistoryKey(1, 2, 3), quantity = 1f))

        // another RepoHistory with same id
        val hist = RepoHistory(id = RepoHistoryKey(1, 2, 3), quantity = 2f)

        assertTrue(list.contains(hist))
        assertTrue(list.indexOf(hist) >= 0)

        list.remove(hist)
        assertEquals(0, list.size)

        list.add(hist)
        assertEquals(1, list.size)

        assertEquals(2f, list[0].quantity)
    }
}