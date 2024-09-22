import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="calender"
export default class extends Controller {
    static targets = ['calenderDay']

    everyDayUnselected() {
        return this.calenderDayTargets.every((day) => {
            return day.dataset.cssStatusValue === 'false'
        })
    }

    filter() {
        const everyDayUnselected = this.everyDayUnselected()
        this.calenderDayTargets.forEach((day) => {
            const show = everyDayUnselected || day.dataset.cssStatusValue === 'true'
            this.toggleAssociatedConcerts(day.dataset.scheduleAttribute, !show)
        })
    }

    showAll() {
        this.calenderDayTargets.forEach((day) => {
            day.dataset.cssStatusValue = 'false'

            this.toggleAssociatedConcerts(day.dataset.scheduleAttribute, !show)
        })
    }

    toggleAssociatedConcerts(attributeName, toggleValue) {
        document
            .querySelectorAll(`.concert[${attributeName}]`)
            .forEach((element) => {
                element.classList.toggle("hidden", toggleValue)
            })
    }
}
