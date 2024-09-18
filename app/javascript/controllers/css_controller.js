import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="css"
export default class extends Controller {
  static targets = ["elementToChange"];
  static classes = ["css","on","off"];
  static values = { status: Boolean };

  toggle() {
    this.flipStatus();
  }

  flipStatus() {
    this.statusValue = !this.statusValue;
  }

  statusValueChanged() {
    this.updateCssClasses();
  }

  updateCssClasses() {
    for (let cssClass of this.cssClasses) {
      this.elementToChangeTarget.classList.toggle(cssClass, this.statusValue);
    }
    for (let onClass of this.onClasses) {
      this.elementToChangeTarget.classList.toggle(onClass, this.statusValue);
    }
    for (let offClass of this.offClasses) {
      this.elementToChangeTarget.classList.toggle(offClass, !this.statusValue);
    }
  }
}
