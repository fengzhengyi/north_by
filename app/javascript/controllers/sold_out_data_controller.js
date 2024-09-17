import {Controller} from "@hotwired/stimulus"
import {createConsumer} from "@rails/actioncable";

// Connects to data-controller="sold-out-data"
export default class extends Controller {
    static targets = ["concert"]

    connect() {
        this.subscription ??= this.createSubscription(this)
    }

    createSubscription(source) {
        return createConsumer().subscriptions.create('ScheduleChannel', {
            received({concerts}) {
                source.updateData(concerts)
            }
        })
    }

    updateData(concerts) {
        concerts.forEach(({ concertId, ticketsRemaining }) => {
            this.concertTargets.forEach((e) => {
              if (e.dataset.concertIdValue === concertId.toString()) {
                e.dataset.concertTicketsRemainingValue =
                  ticketsRemaining.toString()
                e.dataset.concertSoldOutValue = (ticketsRemaining === 0).toString()

              }
            })
          })
    }
}
