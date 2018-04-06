package com.universal.hly.controller

import org.apache.shiro.authz.AuthorizationException
import org.apache.shiro.authz.UnauthenticatedException
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.ResponseStatus

/**
 * Created by swm on 2018-4-5
 */

@Configuration
class ControllerConfig {
    private val log: Logger = LoggerFactory.getLogger(ControllerConfig::class.java)

    @ExceptionHandler(UnauthenticatedException::class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    fun handleException(e: UnauthenticatedException) {
        log.debug("{} was thrown", e.javaClass, e)
    }

    @ExceptionHandler(AuthorizationException::class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    fun handleException(e: AuthorizationException) {
        log.debug("{} was thrown", e.javaClass, e)
    }

    @ExceptionHandler(NotFoundException::class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ResponseBody
    fun handleException(e: NotFoundException): ErrorMessage {
        return ErrorMessage("Data Not Found: ${e.id}")
    }
}