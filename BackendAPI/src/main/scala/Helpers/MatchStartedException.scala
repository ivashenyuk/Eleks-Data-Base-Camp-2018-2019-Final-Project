package Helpers

class MatchStartedException(val message: String = "The beginning of the match. Bids are not accepted.",
                            private val cause: Throwable = None.orNull) extends Exception(message, cause) {

}
