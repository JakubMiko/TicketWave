import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "background"];

  connect() {
    this.modalTarget.classList.add("is-active");
    document.body.classList.add("is-clipped");
  }

  close(event) {
    if (event) event.preventDefault();
    this.modalTarget.classList.remove("is-active");
    document.body.classList.remove("is-clipped");

    const frame = document.getElementById("modal_frame");
    if (frame) {
      setTimeout(() => {
        frame.innerHTML = "";
      }, 300);
    }
  }

  closeOnBackgroundClick(event) {
    if (event.target === this.backgroundTarget) {
      this.close(event);
    }
  }

  disconnect() {
    document.body.classList.remove("is-clipped");
  }
}
