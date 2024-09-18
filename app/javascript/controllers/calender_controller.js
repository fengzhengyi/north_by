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
            const dayBody = document.getElementById(day.dataset.scheduleId)
            dayBody.classList.toggle('hidden',!show)
        })
    }

    showAll(){
        this.calenderDayTargets.forEach((day) => {
            day.dataset.cssStatusValue = 'false'
            const dayBody = document.getElementById(day.dataset.scheduleId)
            dayBody.classList.toggle('hidden',false)
        })
    }
}
