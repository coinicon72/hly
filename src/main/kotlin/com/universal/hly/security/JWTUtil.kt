package com.universal.hly.security

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.auth0.jwt.exceptions.JWTDecodeException
import java.io.UnsupportedEncodingException
import java.util.*

//class JWTUtil {
//
//    // 过期时间7天
//    private val EXPIRE_TIME = (7 * 24 * 60 * 1000).toLong()
//
//    /**
//     * 校验token是否正确
//     * @param token 密钥
//     * @param secret 用户的密码
//     * @return 是否正确
//     */
//    fun verify(token: String, username: String, secret: String): Boolean {
//        try {
//            val algorithm = Algorithm.HMAC256(secret)
//            val verifier = JWT.require(algorithm)
//                    .withClaim("username", username)
//                    .build()
//            val jwt = verifier.verify(token)
//            return true
//        } catch (exception: Exception) {
//            return false
//        }
//
//    }
//
//    /**
//     * 获得token中的信息无需secret解密也能获得
//     * @return token中包含的用户名
//     */
//    fun getUsername(token: String): String? {
//        try {
//            val jwt = JWT.decode(token)
//            return jwt.getClaim("username").asString()
//        } catch (e: JWTDecodeException) {
//            return null
//        }
//
//    }
//
//    /**
//     * 生成签名, EXPIRE_TIME后过期
//     * @param username 用户名
//     * @param secret 用户的密码
//     * @return 加密的token
//     */
//    fun sign(username: String, secret: String): String? {
//        try {
//            val date = Date(System.currentTimeMillis() + EXPIRE_TIME)
//            val algorithm = Algorithm.HMAC256(secret)
//            // 附带username信息
//            return JWT.create()
//                    .withClaim("username", username)
//                    .withExpiresAt(date)
//                    .sign(algorithm)
//        } catch (e: UnsupportedEncodingException) {
//            return null
//        }
//
//    }
//
//}

// 过期时间7天
const val EXPIRE_TIME = (7 * 24 * 60 * 1000).toLong()

// jwt uid claim
const val UID_CLAIM = "uid"


/**
 * 校验token是否正确
 * @param token 密钥
 * @param secret 用户的密码
 * @return 是否正确
 */
fun verifyJWT(token: String, uid: Int, secret: String): Boolean {
    try {
        val algorithm = Algorithm.HMAC256(secret)
        val verifier = JWT.require(algorithm)
                .withClaim(UID_CLAIM, uid)
                .build()
        val jwt = verifier.verify(token)
        return true
    } catch (exception: Exception) {
        return false
    }
}


/**
 * 获得token中的信息无需secret解密也能获得
 * @return token中包含的用户名
 */
fun getUserIdFromJWT(token: String): Int? {
    try {
        val jwt = JWT.decode(token)
        return jwt.getClaim(UID_CLAIM).asInt()
    } catch (e: JWTDecodeException) {
        return null
    }
}


/**
 * 生成签名, EXPIRE_TIME后过期
 * @param username 用户名
 * @param secret 用户的密码
 * @return 加密的token
 */
fun signJWT(uid: Int, secret: String): String? {
    try {
        val date = Date(System.currentTimeMillis() + EXPIRE_TIME)
        val algorithm = Algorithm.HMAC256(secret)

        // 附带username信息
        return JWT.create()
                .withClaim(UID_CLAIM, uid)
                .withExpiresAt(date)
                .sign(algorithm)
    } catch (e: UnsupportedEncodingException) {
        return null
    }
}
