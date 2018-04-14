package com.universal.hly.config

import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider
import org.springframework.context.annotation.Configuration
import org.springframework.core.type.filter.RegexPatternTypeFilter
import org.springframework.data.rest.core.config.RepositoryRestConfiguration
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurerAdapter
import java.util.regex.Pattern


/**
 * Created by swm on 2018-4-14
 */
@Configuration
class DataRestConfig : RepositoryRestConfigurerAdapter() {

    override fun configureRepositoryRestConfiguration(config: RepositoryRestConfiguration) {

        val provider = ClassPathScanningCandidateComponentProvider(false)
        provider.addIncludeFilter(RegexPatternTypeFilter(Pattern.compile(".*")))

        val beans = provider.findCandidateComponents("com.universal.hly.model")

        for (bean in beans) {
            var idExposedClasses: Class<*>?
            try {
                idExposedClasses = Class.forName(bean.beanClassName)
                config.exposeIdsFor(Class.forName(idExposedClasses!!.name))
            } catch (e: ClassNotFoundException) {
                // Can't throw ClassNotFoundException due to the method signature. Need to cast it
                throw RuntimeException("Failed to expose `id` field due to", e)
            }

        }
    }
}