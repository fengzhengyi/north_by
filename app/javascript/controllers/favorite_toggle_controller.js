import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
  static targets = ['elementToHide']
  toggle() {
    this.elementToHideTarget?.classList.toggle('hidden')
  }
}
