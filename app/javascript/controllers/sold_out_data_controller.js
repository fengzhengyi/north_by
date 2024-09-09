import {Controller} from "@hotwired/stimulus"
import {createConsumer} from "@rails/actioncable";

// Connects to data-controller="sold-out-data"
export default class extends Controller {
    static targets = ["concert"]

    connect() {
        this.subscription ??= this.createSubscription(this)
    }

    createSubscription(source) {
        return createConsumer.subscriptions.create('ScheduleChannel', {
            received({soldOutConcertIds}) {
                source.updateData(soldOutConcertIds)
            }
        })
    }

    updateData(soldOutConcertIds) {
        this.concertTargets.forEach(e => {
            e.dataset.concertSoldOutValue = soldOutConcertIds
                .includes(parseInt(e.dataset.concertIdValue,10)).toString()
        })
    }
}
