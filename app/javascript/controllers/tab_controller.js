import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["first", "second"]  
  connect() {
  }

  // Connects to data-action="click->tab#toggle"
  toggle(event) {
    console.log(this.firstTarget)
    event.preventDefault()
    this.firstTarget.classList.toggle("hidden")
    this.secondTarget.classList.toggle("show")
  }
}
