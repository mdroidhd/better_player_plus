package  com.sarthak.better_player_enhanced

import android.net.Uri
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.okhttp.OkHttpDataSource
import okhttp3.OkHttpClient
import okhttp3.Protocol

internal object DataSourceUtils {
    private const val USER_AGENT = "User-Agent"
    private const val USER_AGENT_PROPERTY = "http.agent"
    private const val DEFAULT_USER_AGENT = "BetterPlayer"

    private val okHttpClient: OkHttpClient by lazy {
        OkHttpClient.Builder()
            .followRedirects(true)
            .followSslRedirects(true)
            .retryOnConnectionFailure(true)
            // Some media hosts reset HTTP/2 streams during ranged reads.
            .protocols(listOf(Protocol.HTTP_1_1))
            .build()
    }

    @JvmStatic
    fun getUserAgent(headers: Map<String, String>?): String? {
        var userAgent = System.getProperty(USER_AGENT_PROPERTY)
        if (headers != null && headers.containsKey(USER_AGENT)) {
            val userAgentHeader = headers[USER_AGENT]
            if (userAgentHeader != null) {
                userAgent = userAgentHeader
            }
        }
        return userAgent
    }

    @JvmStatic
    fun getDataSourceFactory(
        userAgent: String?,
        headers: Map<String, String>?
    ): DataSource.Factory {
        val factory = OkHttpDataSource.Factory(okHttpClient)
            .setUserAgent(userAgent ?: DEFAULT_USER_AGENT)
        if (headers != null) {
            val notNullHeaders = mutableMapOf<String, String>()
            headers.forEach { entry ->
                notNullHeaders[entry.key] = entry.value
            }
            factory.setDefaultRequestProperties(notNullHeaders)
        }
        return factory
    }

    @JvmStatic
    fun isHTTP(uri: Uri?): Boolean {
        if (uri == null || uri.scheme == null) {
            return false
        }
        val scheme = uri.scheme
        return scheme == "http" || scheme == "https"
    }
}
