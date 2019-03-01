package Services.Traits.Kafka

import Entities.Information


trait ProducerService {
    def sendInformation(information: AnyRef)
}
