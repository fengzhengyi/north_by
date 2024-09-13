import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-all"
export default class extends Controller {
  static targets = ["form", "hiddenField"]
  static values = {
    hiddenId: String
  }

  submit(event) {
    const hiddenValueElement = document.getElementById(this.hiddenIdValue)
    if (hiddenValueElement) {
      this.hiddenFieldTarget.value = hiddenValueElement.value
    }
    this.formTarget.requestSubmit()
  }
}
