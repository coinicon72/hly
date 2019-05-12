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


