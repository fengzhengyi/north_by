import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"
// Connects to data-controller="cable-receiver"
export default class extends Controller {
    static values = { concertId: Number, channelName: String }
    static targets = ["form"]

    connect() {
        this.channel ??= this.createChannel(this)
    }

    createChannel(source) {
        debugger
        return consumer.subscriptions.create(
            { channel: 'concertChannel', concertId: this.concertIdValue },
            {
                received(ticket) {
                    source.seatUpdated(ticket)
                }
            }
        )
    }

    seatUpdated(ticket) {
        debugger
        const seatElement = document.getElementById(ticket.seat)
        if (!seatElement || seatElement.dataset.status !== ticket.status) {
            this.formTarget.requestSubmit()
        }
    }
}
