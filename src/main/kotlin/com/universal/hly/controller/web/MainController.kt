package com.universal.hly.controller.web

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping


/**
 * Created by swm on 2018-4-6
 */
@Controller
class MainController {

    @RequestMapping(value = ["/"])
    fun index(): String {
        return "index.html"
    }

}