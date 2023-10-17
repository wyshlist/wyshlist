import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-down"
export default class extends Controller {
  static targets = ["form", "comments"]

  connect() {
    console.log("data-controller");
  }

  scroll(event) {
    event.preventDefault()
    console.log(this.formTarget.action);
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        if (data.inserted_item) {
          // beforeend could also be dynamic with Stimulus values
          this.commentsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
          this.commentsTarget.scrollTo(0, this.commentsTarget.scrollHeight)
        }
        this.formTarget.outerHTML = data.form
      })

  }
}
