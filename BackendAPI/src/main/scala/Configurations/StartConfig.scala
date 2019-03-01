package Configurations

import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.context.annotation.{ComponentScan, Configuration}

@EnableAutoConfiguration
@Configuration
@ComponentScan(basePackages = Array(
  "Controllers",
  "Controllers.DataLakeControllers",
  "Entities",
  "Services",
  "Services.Implementations",
  "Services.Traits"))
class StartConfig {

}
