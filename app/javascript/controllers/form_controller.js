import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
    static targets = ["form"]
    submit(){
        this.formTarget.requestSubmit()
    }
}
