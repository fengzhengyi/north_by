import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
    static targets = ['elementToHide', 'elementWithText']
    static classes = ['hidden'];
    static values = {visible: Boolean}

    toggle() {
        this.toggleVisible()
    }

    toggleVisible() {
        this.visibleValue = !this.visibleValue
    }

    visibleValueChanged() {
        this.updateHiddenClass()
        this.updateText()
    }

    updateHiddenClass() {
        this.elementToHideTarget?.classList.toggle(this.hiddenClass, !this.visibleValue)
    }

    newText() {
        return this.visibleValue ? 'Hide' : 'Show'
    }

    updateText() {
        this.elementWithTextTarget.innerText = this.newText()
    }

}
