import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wish-status-update"
export default class extends Controller {
  static targets = ["form", "submit", "select"]

  update() {
    this.selectTarget.dataset.bsToggle = "modal"
    this.selectTarget.dataset.bsTarget = "#statusModal"
    this.selectTarget.click()
  }
}
