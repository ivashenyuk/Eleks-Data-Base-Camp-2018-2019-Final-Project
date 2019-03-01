import Configurations.KafkaConfigurations.ProducerConfig
import Configurations.{DatabaseConfig, FileStorageProperties, StartConfig}
import org.springframework.boot.Banner
import org.springframework.boot.builder.SpringApplicationBuilder

object Main {
  def main(args: Array[String]): Unit = {
    new SpringApplicationBuilder()
      .sources(classOf[StartConfig])
      .sources(classOf[ProducerConfig])
      .sources(classOf[DatabaseConfig])
      .sources(classOf[FileStorageProperties])
      .bannerMode(Banner.Mode.OFF)
      .run(args: _*)
  }
}
