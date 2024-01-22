// app/javascript/controllers/dashboard_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown"];

  connect() {
    this.setupEventListeners();
  }

  setupEventListeners() {
    const calendarLinks = this.element.querySelectorAll(".dropdown-menu a");
    calendarLinks.forEach((link) => {
      link.addEventListener("click", this.handleDropdownClick.bind(this));
    });
  }

  handleDropdownClick(event) {
    event.preventDefault();
    const view = event.target.dataset.view;

    Turbo.visit(window.location.pathname + `?view=${view}`, {
      action: "replace",
    });
  }
}
