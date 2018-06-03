package com.universal.hly.controller.rest

import com.universal.hly.dao.UserRepository
import com.universal.hly.security.signJWT
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authz.UnauthenticatedException
import org.apache.shiro.crypto.hash.Md5Hash
import org.apache.shiro.subject.Subject
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping(path = ["/api"],
        produces = [MediaType.APPLICATION_JSON_UTF8_VALUE])
class AuthController {
    @Autowired
    lateinit var userRepository: UserRepository

    /**
     * return jwt token which include user id
     */
    @PostMapping(path = ["/token"])
    fun getToken(@RequestParam("uid") phone: String,
                 @RequestParam("pwd") password: String): GenericRestResult {

        val user = userRepository.getByPhone(phone) ?: throw UnauthenticatedException()

        return if (user.password != null && user.password == Md5Hash(password).toString()) {
            GenericRestResult(200, "Login success", signJWT(user.id, user.password), user)
        } else {
            throw UnauthenticatedException()
        }
    }

    /**
     * return jwt token which include user id
     */
    @GetMapping(path = ["/user"])
    fun getUser(): GenericRestResult {

        val subject = SecurityUtils.getSubject()

        if (subject.principal == null)
            throw UnauthenticatedException()

        return GenericRestResult(200, null, subject.principal, null)
    }
}