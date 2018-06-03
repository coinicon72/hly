package com.universal.hly

import org.apache.shiro.crypto.hash.Md5Hash
import org.junit.Assert
import org.junit.Test

class TestJava {
    @Test
    fun testShiroMd5() {
        val h = Md5Hash("123").toString()
        Assert.assertEquals(h, "202cb962ac59075b964b07152d234b70")
    }
}