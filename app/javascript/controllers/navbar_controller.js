import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu", "burger"];

  connect() {
    console.log("Navbar controller connected");
  }

  toggle() {
    // Dodaj lub usuń klasę "is-active" dla burgera i menu
    this.burgerTarget.classList.toggle("is-active");
    this.menuTarget.classList.toggle("is-active");
  }
}
