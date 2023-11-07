import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading-organization"
export default class extends Controller {
  static targets = ["loader", "form"]

  loading(event) {
    event.preventDefault();
    this.loaderTarget.classList.remove('d-none')
    fetch(this.formTarget.action, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.response) {
          window.location.replace(`${window.location.origin}/`);
        }
      })
  }
}
