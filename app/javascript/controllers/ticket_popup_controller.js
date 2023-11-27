import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ticket-popup"
export default class extends Controller {
  static targets = ["popup"]
  connect() {
    this.activeTicket = null
  }

  active(event) {
    if (this.activeTicket) {
      this.activeTicket.classList.remove('active')
    }
    this.activeTicket = event.currentTarget
    event.currentTarget.classList.add('active')
  }

  show() {
    this.popupTarget.classList.remove('d-none')
  }

  hide() {
    this.popupTarget.classList.add('d-none')
  }
}
