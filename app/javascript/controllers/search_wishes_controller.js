import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-wishes"
export default class extends Controller {
  static targets = ["form", "input"]

  search(event) {
    this.formTarget.classList.toggle('d-none')
    this.inputTarget.classList.toggle('active')
    event.currentTarget.classList.toggle('active')
  }
}
