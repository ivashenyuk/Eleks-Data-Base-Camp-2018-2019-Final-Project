package Configurations

import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Configuration



@EnableAutoConfiguration
@Configuration
@ConfigurationProperties(prefix = "file")
class FileStorageProperties {
  private var uploadDir: String = null

  def getUploadDir: String =  uploadDir

  def setUploadDir(uploadDir: String): Unit = {
    this.uploadDir = uploadDir
  }
}