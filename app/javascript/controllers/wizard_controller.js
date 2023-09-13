import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['step', 'provider', 'workspace', 'project'];

  async getWorkspaces() {
    try {
      const provider = this.providerTargets[0].childNodes[1].innerText;
      const api_token = document.getElementById("integration_api_token").value;
      const workspaces = document.getElementById("integration_workspace");

      if (provider.replace(/\s/g,'') == "Asana") {
        const base_url = "https://app.asana.com/api/1.0";
        const url = `${base_url}/workspaces`;
        const headers = {
          'Authorization': `Bearer ${api_token}`
        };

        const response = await fetch(url, { headers });
        if (!response.ok) {
          throw new Error("Failed to fetch workspaces from Asana API.");
        }

        const data = await response.json();

        const options = data.data.map(workspace => {
          return `<option name="workspace" value="${workspace.gid}" data-action="change->integration#showProjects">${workspace.name}</option>`;
        });
        workspaces.innerHTML = options.join("");
      }
    } catch (error) {
      console.error(error);
      alert(`${error} Please try again.`);
      // Handle the error (e.g., display an error message to the user)
    }
  }

  async getProjects() {
    try {
      const provider = this.providerTargets[0].childNodes[1].innerText;
      const api_token = document.getElementById("integration_api_token").value;
      const workspace = document.getElementById("integration_workspace").value;
      const projects = document.getElementById("integration_project");

      if (provider.replace(/\s/g,'') == "Asana") {
        const base_url = "https://app.asana.com/api/1.0";
        const url = `${base_url}/projects?workspace=${workspace}`;
        const headers = {
          'Authorization': `Bearer ${api_token}`
        };

        const response = await fetch(url, { headers });
        if (!response.ok) {
          throw new Error("Failed to fetch projects from Asana API.");
        }

        const data = await response.json();
        console.log(data);

        const options = data.data.map(project => {
          return `<option name="project" value="${project.gid}">${project.name}</option>`;
        });
        projects.innerHTML = options.join("");
      }
    } catch (error) {
      console.error(error);
      alert(`${error} Please try again.`);
      // Handle the error (e.g., display an error message to the user)
    }
  }

  goToNext(event) {
    const nextStep = event.target.dataset.nextStep - 1;
    const actualStep = event.target.dataset.nextStep;

    if (nextStep === 0) {
      this.getWorkspaces();
    } else if (nextStep === 1) {
      this.getProjects();
    }

    this.stepTargets[nextStep].classList.add("hidden");
    this.stepTargets[actualStep].classList.remove("hidden");
  }

  goToPrevious(event) {
    const previousStep = event.target.dataset.previousStep - 1;
    const actualStep = event.target.dataset.previousStep;

    this.stepTargets[actualStep].classList.add("hidden");
    this.stepTargets[previousStep].classList.remove("hidden");
  }
}