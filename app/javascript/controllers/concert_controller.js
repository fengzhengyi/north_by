import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="concert"
export default class extends Controller {
    static values = {id: Number, soldOut: Boolean, ticketsRemaining: Number}
    static targets = ["tickets"]

    soldOutValueChanged(newValue, oldValue) {
        if (this.soldOutValue) {
            this.ticketsTarget.textContent = "Sold Out"
        } else {
            this.ticketsTarget.textContent = `${this.ticketsRemainingValue} Tickets Remaining`
        }
    }

    ticketsRemainingValueChanged() {
        this.ticketsTarget.textContent = `${this.ticketsRemainingValue} Tickets Remaining`
    }
}
