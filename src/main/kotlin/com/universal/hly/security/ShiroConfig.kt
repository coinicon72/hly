package com.universal.hly.security

import org.apache.shiro.cache.CacheManager
import org.apache.shiro.cache.MemoryConstrainedCacheManager
import org.apache.shiro.mgt.DefaultSessionStorageEvaluator
import org.apache.shiro.mgt.DefaultSubjectDAO
import org.apache.shiro.realm.Realm
import org.apache.shiro.realm.text.PropertiesRealm
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor
import org.apache.shiro.spring.web.ShiroFilterFactoryBean
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition
import org.apache.shiro.web.mgt.DefaultWebSecurityManager
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.util.HashMap
import javax.servlet.Filter

/**
 * Created by swm on 2018-4-5
 */
@Configuration
class ShiroConfig {

    @Bean
    fun realm(realm: HlyRealm): Realm {
        // uses 'classpath:shiro-users.properties' by default
//        val realm = PropertiesRealm()
//        val realm = TextConfigurationRealm()
//        realm.userDefinitions = """joe.coder=password,user
//            jill.coder=password,admin"""
//        realm.roleDefinitions = "admin=document:read,document:write\nuser=document:read"

        // Caching isn't needed in this example, but we can still turn it on
        realm.isCachingEnabled = true

        return realm
    }

//    @Bean
//    fun shiroFilterChainDefinition(): ShiroFilterChainDefinition {
//        val chainDefinition = DefaultShiroFilterChainDefinition()
//
//        // logged in users with the 'admin' role
//        chainDefinition.addPathDefinition("/admin/**", "jwt, roles[admin]")
//
//        // logged in users with the 'document:read' permission
//        chainDefinition.addPathDefinition("/docs/**", "jwt, perms[document:read]")
//
//        // allow all access /api/token
//        chainDefinition.addPathDefinition("/api/token", "anon")
//
//        // all other paths require a logged in user
//        chainDefinition.addPathDefinition("/**", "jwt")
//
//        //
////        chainDefinition.addPathDefinition("/**", "anon"); // all paths are managed via annotations
//
//        // or allow basic authentication, but NOT require it.
////        chainDefinition.addPathDefinition("/**", "authcBasic[permissive]");
//
//        return chainDefinition
//    }

    @Bean//("securityManager")
    fun securityManager(realm: Realm): DefaultWebSecurityManager {
        val manager = DefaultWebSecurityManager()

        // 使用自己的realm
        manager.setRealm(realm)

        /*
         * 关闭shiro自带的session，详情见文档
         * http://shiro.apache.org/session-management.html#SessionManagement-StatelessApplications%28Sessionless%29
         */
        val subjectDAO = DefaultSubjectDAO()
        val defaultSessionStorageEvaluator = DefaultSessionStorageEvaluator()
        defaultSessionStorageEvaluator.isSessionStorageEnabled = false
        subjectDAO.sessionStorageEvaluator = defaultSessionStorageEvaluator
        manager.subjectDAO = subjectDAO

        return manager
    }

    @Bean//("shiroFilter")
    fun shiroFilterFactoryBean(securityManager: DefaultWebSecurityManager): ShiroFilterFactoryBean {
        val factoryBean = ShiroFilterFactoryBean()

        // 添加自己的过滤器并且取名为jwt
        val filterMap = HashMap<String, Filter>()
        filterMap["jwt"] = JWTFilter()
        factoryBean.filters = filterMap

        factoryBean.securityManager = securityManager
        factoryBean.unauthorizedUrl = "/401"

        /*
         * 自定义url规则
         * http://shiro.apache.org/web.html#urls-
         */
        val filterRuleMap = HashMap<String, String>()

        // 访问401和404页面不通过我们的Filter
        filterRuleMap["/401"] = "anon"
        filterRuleMap["/api/token"] = "anon"
//        filterRuleMap["/api/data/**"] = "anon"

        // 所有请求通过我们自己的JWT Filter
        filterRuleMap["/**"] = "jwt"

        factoryBean.filterChainDefinitionMap = filterRuleMap

        return factoryBean
    }

    @Bean
    protected fun cacheManager(): CacheManager {
        return MemoryConstrainedCacheManager()
    }

    @Bean
    fun authorizationAttributeSourceAdvisor(securityManager: DefaultWebSecurityManager): AuthorizationAttributeSourceAdvisor {
        val advisor = AuthorizationAttributeSourceAdvisor()
        advisor.securityManager = securityManager
        return advisor
    }
}