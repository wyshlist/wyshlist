import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ticket-popup"
export default class extends Controller {
  static targets = ["popup"]

  show() {
    this.popupTarget.classList.remove('d-none')
  }

  hide() {
    this.popupTarget.classList.add('d-none')
  }
}
