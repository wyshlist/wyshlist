import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-wishes"
export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    console.log("search wishes");
  }

  search(event) {
    console.log('open search bar');
    this.inputTarget.classList.toggle('active')
    event.currentTarget.classList.toggle('active')
  }
}
