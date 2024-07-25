import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
    static targets = ['elementToHide', 'elementWithText']
    static  values = {visible: Boolean}

    toggle() {
        this.toggleVisible()
    }

    toggleVisible() {
        this.visibleValue = !this.visibleValue
    }

    visibleValueChanged() {
        window.alert('changed')
        this.updateHiddenClass()
        this.updateText()
    }

    updateHiddenClass() {
        this.elementToHideTarget?.classList.toggle('hidden', !this.visibleValue)
    }

    newText() {
        return this.visibleValue ? 'Hide' : 'Show'
    }

    updateText() {
        this.elementWithTextTarget.innerText = this.newText()
    }

}
