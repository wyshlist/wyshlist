import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="character-counter"
export default class extends Controller {
  static targets = ["input", "message"];

  updateMessage() {
    const maxLength = parseInt(this.inputTarget.getAttribute("maxlength"));
    const remainingCharacters = maxLength - this.inputTarget.value.length;

    this.messageTarget.textContent = `Remaining characters: ${remainingCharacters}`;
    if (remainingCharacters < 0) {
      this.messageTarget.classList.add("error");
    } else {
      this.messageTarget.classList.remove("error");
    }
  }
}
