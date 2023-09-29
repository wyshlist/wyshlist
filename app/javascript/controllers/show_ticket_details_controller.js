import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-ticket-details"
export default class extends Controller {
  static targets = ["ticket"]

  connect() {
    this.activeTicket = null
  }

  active(event) {
    // this.ticketTargets.forEach((ticket) => {
    //   ticket.classList.remove('active')
    // })
    if (this.activeTicket) {
      this.activeTicket.classList.remove('active')
    }
    this.activeTicket = event.currentTarget
    event.currentTarget.classList.add('active')
  }
}
