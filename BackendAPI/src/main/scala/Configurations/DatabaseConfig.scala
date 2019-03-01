package Configurations

import javax.sql.DataSource
import org.springframework.beans.factory.annotation.{Qualifier, Value}
import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.context.annotation.{Bean, Configuration}
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.datasource.DriverManagerDataSource

@EnableAutoConfiguration
@Configuration
class DatabaseConfig {

  @Value("${spring.datasource.url}")
  var connectionUrl: String = _

  @Value("${spring.datasource.username}")
  var user: String = _

  @Value("${spring.datasource.password}")
  var pass: String = _

  @Value("${spring.datasource.driverClassName}")
  var driveClassName: String = _


  @Bean(name = Array("mssqlDb"))
  def mssqlDataSource(): DataSource = {

    val ds: DriverManagerDataSource = new DriverManagerDataSource
    ds.setDriverClassName(driveClassName)
    ds.setUrl(connectionUrl)
    ds.setUsername(user)
    ds.setPassword(pass)

    return ds
  }

  @Bean(name = Array("mssqlJdbcTemplate"))
  def jdbcTemplate(@Qualifier("mssqlDb") dsMSSQL: DataSource) = new JdbcTemplate(dsMSSQL)
}
