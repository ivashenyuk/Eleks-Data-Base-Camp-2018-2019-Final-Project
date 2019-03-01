package Services.Traits.Kafka

import Entities.BetRequest

trait BetProducerService {
      def sendBetToKafka(bet: BetRequest): Unit
}
