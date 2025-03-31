import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "background"];

  connect() {
    console.log("Modal controller connected");
    this.modalTarget.classList.add("is-active");
    document.body.classList.add("is-clipped");
  }

  close(event) {
    if (event) event.preventDefault();
    console.log("Closing modal...");
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
      console.log("Closing modal on background click...");
      this.close(event);
    }
  }
  
  disconnect() {
    document.body.classList.remove("is-clipped");
  }
}
