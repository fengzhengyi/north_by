import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="text"
export default class extends Controller {
  static targets = ["elementWithText"];
  static values = {
    status: Boolean,
    off: { type: String, default: "Off" },
    on: { type: String, default: "On" },
  };

  toggle() {
    this.flipStatus();
  }

  flipStatus() {
    this.statusValue =!this.statusValue;
  }

  statusValueChanged() {
    this.updateText();
  }

  updateText() {
    this.elementWithTextTarget.innerText = this.statusValue
      ? this.onValue
      : this.offValue;
  }
}
