package com.universal.hly

//import com.universal.hly.model.Order
import com.universal.hly.dao.ClientRepository
import com.universal.hly.dao.MaterialRepository
import org.apache.shiro.spring.LifecycleBeanPostProcessor
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.DependsOn
import org.springframework.web.bind.annotation.ControllerAdvice
import javax.persistence.EntityManager


/**
 * Created by swm on 2018-4-2
 */
@ControllerAdvice
@SpringBootApplication
class Application {
    val log: Logger = LoggerFactory.getLogger("Application")

//    @Bean
//    fun dbTest1(repository: MaterialRepository): CommandLineRunner {
//        return CommandLineRunner {
//            // save a couple of citys
////            repository.save(Material(code = "c1234", name = "n322"))
//
//            // fetch all citys
//            log.info("findAll():")
//            log.info("-------------------------------")
//            for (city in repository.findAll()) {
//                log.info(city.toString())
//            }
//            log.info("")
//
//            // fetch an individual city by ID
////            repository.getById(1L)
////                    .ifPresent({ city ->
////                        log.info("getById(1L):")
////                        log.info("--------------------------------")
////                        log.info(city.toString())
////                        log.info("")
////                    })
////
////            // fetch citys by last name
////            log.info("findByCode():")
////            log.info("--------------------------------------------")
////            repository.findByCode("Gelderland").forEach { city -> log.info(city.toString()) }
//            // for (City bauer : repository.findByLastName("Bauer")) {
//            // 	log.info(bauer.toString());
//            // }
//            log.info("")
//        }
//    }

//    @Bean
//    fun dbTest2(repository: ClientRepository): CommandLineRunner {
//        return CommandLineRunner {
//            //            repository.save(Client(name = "c123"))
////            val client = Client(name = "c12")
////            repository.save(client)
////            client.orders = arrayListOf(
////                    Order(no = "o123", orderDate = Date(), deliveryDate = Date(), quantity = 2.3f),
////                    Order(no = "o1234", orderDate = Date(), deliveryDate = Date(), quantity = 4.3f)
////            )
////            repository.save(client)
//
//            // fetch all citys
//            log.info("findAll():")
//            log.info("-------------------------------")
//            for (city in repository.findAll()) {
////                Hibernate.initialize(city.orders)
//                log.info(city.toString())
//            }
//            log.info("")
//        }
//    }

//    @Bean
//    fun aopChecker(entityManager: EntityManager) : CommandLineRunner {
//        return CommandLineRunner {
//            val r = entityManager.createNativeQuery("call preview_stock_out_changing(:cid)", "StockOutPreview")
//                    .setParameter("cid", 5)
//                    .resultList
//            println(r)
//        }
//    }


    @Bean
    fun lifecycleBeanPostProcessor(): LifecycleBeanPostProcessor {
        return LifecycleBeanPostProcessor()
    }


    // fix spring mvc controller annotation not working with shiro annotation by using cglib class proxy
    @DependsOn("lifecycleBeanPostProcessor")
    @Bean
    fun defaultAdvisorAutoProxyCreator(): DefaultAdvisorAutoProxyCreator {
        val proxyCreator = DefaultAdvisorAutoProxyCreator()
        proxyCreator.isProxyTargetClass = true
        return proxyCreator
    }
}

fun main(args: Array<String>) {
    SpringApplication.run(Application::class.java, *args)
}


