package com.universal.hly.config

import org.springframework.context.annotation.Configuration
import org.springframework.http.MediaType
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import java.util.*


@Configuration
@EnableWebMvc
class JsonConverterConfig : WebMvcConfigurer {
    override fun configureMessageConverters(converters: MutableList<HttpMessageConverter<*>>?) {
        val jsonConverter = MappingJackson2HttpMessageConverter()
        jsonConverter.supportedMediaTypes = Collections.singletonList(MediaType.APPLICATION_JSON)
        converters!!.add(jsonConverter)
    }
}