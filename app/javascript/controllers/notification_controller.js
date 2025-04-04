import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    setTimeout(() => {
      this.close()
    }, 5000)
  }

  close() {
    this.element.style.opacity = "0"
    this.element.style.transition = "opacity 0.5s ease"

    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}