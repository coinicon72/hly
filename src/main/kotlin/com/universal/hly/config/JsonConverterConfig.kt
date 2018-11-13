package com.universal.hly.config

import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Configuration
import org.springframework.http.MediaType
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import java.text.SimpleDateFormat
import java.util.*


@Configuration
@EnableWebMvc
class JsonConverterConfig : WebMvcConfigurer {
    @Value("\${spring.jackson.date-format}")
    private lateinit var dateFormatStr: String

    override fun configureMessageConverters(converters: MutableList<HttpMessageConverter<*>>?) {
        val jsonConverter = MappingJackson2HttpMessageConverter()
        jsonConverter.supportedMediaTypes = Collections.singletonList(MediaType.APPLICATION_JSON)

        val mapper = ObjectMapper()
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
        mapper.dateFormat = SimpleDateFormat(dateFormatStr)
        // IMPORTANT to avoid infinity recursion when handling bidirectional-relationships
        mapper.registerModule(Hibernate5Module())
        jsonConverter.objectMapper = mapper

        converters!!.add(jsonConverter)
    }
}
