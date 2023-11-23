import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="active-navbar"
export default class extends Controller {
  connect() {
    // add active class to current page
    const currentPath = window.location.pathname
    const navLinks = document.querySelectorAll('.navbar a')
    navLinks.forEach((link) => {
      if (link.getAttribute('href') === currentPath) {
        link.classList.add('active')
      }
    })
  }
}
