package com.universal.hly.controller.rest

import com.universal.hly.model.Greeting
import org.apache.shiro.authz.annotation.RequiresPermissions
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import java.util.concurrent.atomic.AtomicLong

/**
 * Created by swm on 2018-4-2
 */
@RestController
@RequestMapping(path = ["/api"],
        produces = [MediaType.APPLICATION_JSON_UTF8_VALUE])
class GreetingController {

    val counter = AtomicLong()

    @GetMapping("/greeting")
    @RequiresPermissions("document:read")
    fun greeting(@RequestParam(value = "name", defaultValue = "World") name: String) =
            Greeting(counter.incrementAndGet(), "Hello, $name")

}