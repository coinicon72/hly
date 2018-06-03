package com.universal.hly.security

import com.universal.hly.dao.UserRepository
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.AuthenticationInfo
import org.apache.shiro.authc.AuthenticationToken
import org.apache.shiro.authc.SimpleAuthenticationInfo
import org.apache.shiro.authz.AuthorizationException
import org.apache.shiro.authz.AuthorizationInfo
import org.apache.shiro.authz.SimpleAuthorizationInfo
import org.apache.shiro.realm.AuthorizingRealm
import org.apache.shiro.subject.PrincipalCollection
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component


@Component
class HlyRealm : AuthorizingRealm() {

    @Autowired
    lateinit var userRepository: UserRepository

    override fun supports(token: AuthenticationToken?): Boolean {
        return token is JWTToken
    }

    override fun doGetAuthenticationInfo(auth: AuthenticationToken): AuthenticationInfo {
        val token = auth.credentials as String

        // 解密获得username，用于和数据库进行对比
        val uid = getUserIdFromJWT(token) ?: throw AuthenticationException("token invalid")

        val optional = userRepository.findById(uid) //?: throw AuthenticationException("User didn't existed!")
        if (!optional.isPresent) throw AuthenticationException("User didn't existed!")

        val user = optional.get()
        if (user.password == null)
            throw AuthenticationException("Username or password error")

        if (!verifyJWT(token, uid, user.password)) {
            throw AuthenticationException("Username or password error")
        }

        return SimpleAuthenticationInfo(user, token, "hly_realm")
    }

    override fun doGetAuthorizationInfo(principals: PrincipalCollection?): AuthorizationInfo {
        val uid = getUserIdFromJWT(principals.toString()) ?: throw AuthorizationException("User didn't existed!")

        val optional = userRepository.findById(uid) //?: throw AuthenticationException("User didn't existed!")
        if (!optional.isPresent) throw AuthenticationException("User didn't existed!")

        val user = optional.get()

        val simpleAuthorizationInfo = SimpleAuthorizationInfo()
//        simpleAuthorizationInfo.addRole(user.getRole())
//
//        val permission = Arrays.asList(user.getPermission().split(","))
//        simpleAuthorizationInfo.addStringPermissions(permission)

        return simpleAuthorizationInfo
    }

}


data class JWTToken(val token: String) : AuthenticationToken {
    override fun getCredentials(): Any {
        return token
    }

    override fun getPrincipal(): Any {
        return token
    }
}
