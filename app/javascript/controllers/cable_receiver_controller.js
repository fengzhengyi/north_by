import {Controller} from "@hotwired/stimulus"
import {createConsumer} from "@rails/actioncable"
// Connects to data-controller="cable-receiver"
export default class extends Controller {
    static values = {concertId: Number, channelName: String}
    static  targets = ["form"]

    connect() {
        this.channel ??= this.createChannel(this)
    }

    createChannel(source) {
        return createConsumer().subscriptions.create(
            {channel: 'concertChannel', concertId: this.concertIdValue},
            {
                received(data) {
                    source.seatUpdated(data)
                }
            }
        )
    }

    seatUpdated(data){
        const seatElement = document.getElementById(data.seat)
        if (!seatElement || seatElement.dataset.status !== data.status) {
            this.formTarget.requestSubmit()
        }
    }
}
