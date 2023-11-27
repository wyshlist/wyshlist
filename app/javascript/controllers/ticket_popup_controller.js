import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ticket-popup"
export default class extends Controller {
  static targets = ["popup"]

  connect() {
    console.log('connecting');
    this.activeTicket = null
  }

  active(event) {
    if (this.activeTicket) {
      this.activeTicket.classList.remove('active')
    }
    this.activeTicket = event.currentTarget
    event.currentTarget.classList.add('active')
  }

  show(event) {
    if (window.screen.width >= 992) {
      this.active(event)
    }
    this.popupTarget.classList.remove('d-none')
  }

  hide() {
    this.popupTarget.classList.add('d-none')
    if (this.activeTicket) {
      this.activeTicket.classList.remove('active')
    }
  }
}
