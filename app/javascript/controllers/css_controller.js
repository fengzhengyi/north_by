import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="css"
export default class extends Controller {
  static targets = ["elementToChange"];
  static classes = ["css"];
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
  }
}
