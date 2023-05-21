import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core";

export default class extends Controller {
  static targets = ["workspaces", "providerInfo", "actions"];

  connect() {
    console.log("in controller")
    // this.actionSelectTarget.disabled = true;
  }

  
  showWorkspaces(event) {
    const provider = this.element.childNodes[3][1].innerText
    const api_token = this.element.childNodes[3][2].value
    if (provider === "asana") {
      const base_url = "https://app.asana.com/api/1.0"
      const url = `${base_url}/workspaces`
      const headers = {
        'Authorization': `Bearer ${api_token}`
      }
      fetch(url, { headers })
        .then(response => response.json())
        .then(data => {
          const options = data.data.map(workspace => {
            return `<option name="workspace" value="${workspace.gid}" data-action="change->integration#showProjects">${workspace.name}</option>`;
          });
          this.workspacesTarget.innerHTML = options.join("");
        }
      )
    }
    this.providerInfoTarget.style.display = "none";
  }
  
  showProjects(event) {
    this.workspacesTarget.style.display = "block";
    const provider = this.element.childNodes[3][1].innerText
    const api_token = this.element.childNodes[3][2].value
    const workspace = this.element.childNodes[3][4].value
    console.log(workspace)
  }
}
