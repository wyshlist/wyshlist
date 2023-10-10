import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-pass-value"
export default class extends Controller {
  static targets = ["input"]

  passValue(event) {
    console.log(this.inputTarget);
    this.inputTarget.value = event.currentTarget.dataset.value
  }
}
