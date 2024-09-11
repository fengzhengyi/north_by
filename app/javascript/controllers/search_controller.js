import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
    static targets = ["form", "input", "results"]

    resetOnOutsideClick(event) {
        if (!this.element.contains(event.target)) {
            this.reset()
        }
    }

    reset() {
        this.resultsTarget.classList.add("hidden")
        this.resultsTarget.innerText = ""
        this.inputTarget.value = ""
    }

    basicSubmit() {
        debugger
        if (this.inputTarget.value === '') {
            this.reset()
        } else {
            this.formTarget.requestSubmit()
        }
    }

    submit = debounce(this.basicSubmit.bind(this))
}

function debounce(functionToDebounce, wait = 500) {
    let timeoutId = undefined
    return (...args) => {
        clearTimeout(timeoutId)
        timeoutId = window.setTimeout(() => {
            timeoutId = undefined
            functionToDebounce(...args)
        }, wait)
    }
}

