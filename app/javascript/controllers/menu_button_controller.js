import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  connect() {
    console.log("The menu_button controller is connected");
  }
  click(){
    window.alert('click in controller')
  }
}
