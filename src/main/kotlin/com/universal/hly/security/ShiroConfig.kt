package com.universal.hly.security

import org.apache.shiro.cache.CacheManager
import org.apache.shiro.cache.MemoryConstrainedCacheManager
import org.apache.shiro.realm.Realm
import org.apache.shiro.realm.text.PropertiesRealm
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

/**
 * Created by swm on 2018-4-5
 */
@Configuration
class ShiroConfig {

    @Bean
    fun realm(): Realm {
        // uses 'classpath:shiro-users.properties' by default
        val realm = PropertiesRealm()
//        val realm = TextConfigurationRealm()
//        realm.userDefinitions = """joe.coder=password,user
//            jill.coder=password,admin"""
//        realm.roleDefinitions = "admin=document:read,document:write\nuser=document:read"

        // Caching isn't needed in this example, but we can still turn it on
        realm.isCachingEnabled = true

        return realm
    }

    @Bean
    fun shiroFilterChainDefinition(): ShiroFilterChainDefinition {
        val chainDefinition = DefaultShiroFilterChainDefinition()

//        // logged in users with the 'admin' role
//        chainDefinition.addPathDefinition("/admin/**", "authc, roles[admin]")
//
//        // logged in users with the 'document:read' permission
//        chainDefinition.addPathDefinition("/docs/**", "authc, perms[document:read]")
//
//        // all other paths require a logged in user
//        chainDefinition.addPathDefinition("/**", "authc")

        //
//        chainDefinition.addPathDefinition("/**", "anon"); // all paths are managed via annotations

        // or allow basic authentication, but NOT require it.
        chainDefinition.addPathDefinition("/**", "authcBasic[permissive]");

        return chainDefinition
    }

    @Bean
    protected fun cacheManager(): CacheManager {
        return MemoryConstrainedCacheManager()
    }

}