package com.universal.hly.controller.web

import com.universal.hly.dao.OrderRepository
import com.universal.hly.model.Order
import freemarker.template.Configuration
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.servlet.ModelAndView
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfig
import javax.servlet.http.HttpServletResponse
import java.util.HashMap
import javax.transaction.Transactional


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

@Controller
@RequestMapping(value = ["/export"],
        produces = ["application/x-download", "application/vnd.ms-excel"])
class ExportController {

    @Autowired
    var orderRepository: OrderRepository? = null

    @Autowired
    var freeMarkerConfiguration: Configuration? = null

//    @Autowired
//    var orderService : OrderService? = null

//    @GetMapping(value = ["/orders"])
//    fun exportOrdersToExcel(): ModelAndView {
//
//        val orders = orderRepository?.findAll()
//
//        val modelAndView = ModelAndView("orders")
//        modelAndView.addObject("orders", orders)
//
//        return modelAndView
//    }

    @GetMapping(value = ["/orders"])
    fun exportOrdersToExcel(response: HttpServletResponse) {
        val orders = orderRepository?.findAll()
//        val orders = orderService?.listOrders()

        val model = HashMap<String, Any>()
        model.put("orders", orders!!)

        exportExcel(response, "orders.ftl", model)
    }

    private fun exportExcel(response: HttpServletResponse, templateName: String, model: Any) {
        response.addHeader("Content-disposition", "attachment;filename=orders.xls");
        response.setContentType("application/vnd.ms-excel");
        response.characterEncoding = "utf-8"

        val template = freeMarkerConfiguration?.getTemplate(templateName)
        template?.process(model, response.writer)
        response.flushBuffer()
    }
}

@Component
class OrderService {

    @Autowired
    var orderRepository: OrderRepository? = null

    @Transactional
    fun listOrders(): List<Order> {
        val orders = orderRepository?.findAll()
//        orders?.forEach({
//            it.
//        })
        return orders!!
    }
}