import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-comment"
export default class extends Controller {
  static targets = ["button"]

  showButton() {
    this.buttonTarget.classList.remove('d-none')
  }

  hideButton() {
    this.buttonTarget.classList.add('d-none')
  }

  activateButton(event) {
    this.buttonTarget.disabled = false

    if (event.currentTarget.value.length == 0) {
      this.buttonTarget.disabled = true
    }
  }
}
