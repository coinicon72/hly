package com.universal.hly.security

import com.auth0.jwt.exceptions.JWTVerificationException
import com.auth0.jwt.exceptions.TokenExpiredException
import com.universal.hly.dao.UserRepository
import com.universal.hly.model.User
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.AuthenticationInfo
import org.apache.shiro.authc.AuthenticationToken
import org.apache.shiro.authc.SimpleAuthenticationInfo
import org.apache.shiro.authz.AuthorizationInfo
import org.apache.shiro.authz.SimpleAuthorizationInfo
import org.apache.shiro.realm.AuthorizingRealm
import org.apache.shiro.subject.PrincipalCollection
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import javax.transaction.Transactional


@Component
class HlyRealm : AuthorizingRealm() {

    @Autowired
    lateinit var userRepository: UserRepository

    @Autowired
    lateinit var userService: UserService


    override fun supports(token: AuthenticationToken?): Boolean {
        return token is JWTToken
    }

    @Transactional
    override fun doGetAuthenticationInfo(auth: AuthenticationToken): AuthenticationInfo {
        val token = auth.credentials as String

        val user = userService.getUserByToken(token)

        return SimpleAuthenticationInfo(user, token, "hly_realm")
    }

    override fun doGetAuthorizationInfo(principals: PrincipalCollection?): AuthorizationInfo {
        val simpleAuthorizationInfo = SimpleAuthorizationInfo()

        if (principals == null)
            return simpleAuthorizationInfo

        val user = principals.oneByType(User::class.java) ?: return simpleAuthorizationInfo

        val roles = user.roles.map { it.code }
        simpleAuthorizationInfo.addRoles(roles)

        val permissions = user.roles.flatMap { it.privileges }.map { it.code }.toSet()
        simpleAuthorizationInfo.addStringPermissions(permissions)

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


@Component
class UserService {
    @Autowired
    lateinit var userRepository: UserRepository

    @Transactional
    fun getUserByToken(token: String): User {
        // 解密获得username，用于和数据库进行对比
        val uid = getUserIdFromJWT(token) ?: throw AuthenticationException("token invalid")

        val optional = userRepository.findById(uid) //?: throw AuthenticationException("User didn't existed!")
        if (!optional.isPresent) throw AuthenticationException("User didn't existed!")

        val user = optional.get()
        if (user.password == null)
            throw AuthenticationException("Username or password error")

        // call following two to load data
        user.roles.size
        user.roles.forEach { it.privileges.size }

        //
        try {
//            if (!verifyJWT(token, uid, user.password)) {
//                throw AuthenticationException("Username or password error")
//            }
            verifyJWT(token, uid, user.password)
        } catch (e: TokenExpiredException) {
            throw AuthenticationException("token expired")
        } catch (e: JWTVerificationException) {
            throw AuthenticationException("invalid token or username/password error")
        } catch (e: Exception) {
            throw AuthenticationException(e.message)
        }

        return user
    }
}