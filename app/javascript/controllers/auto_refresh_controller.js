import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = {
    url: String,
    interval: { type: Number, default: 5000 }
  }

  connect() {
    console.log("AutoRefresh kontroler połączony")
    this.startRefreshing()
  }

  disconnect() {
    this.stopRefreshing()
  }

  startRefreshing() {
    this.refreshInterval = setInterval(() => {
      this.refresh()
    }, this.intervalValue)
  }

  stopRefreshing() {
    if (this.refreshInterval) {
      clearInterval(this.refreshInterval)
    }
  }

  refresh() {
    const url = this.urlValue || window.location.pathname
    const timestamp = new Date().getTime()

    fetch(`${url}?_=${timestamp}`, {
      headers: {
        "Accept": "text/html",
        "X-Requested-With": "XMLHttpRequest"
      }
    })
    .then(response => response.text())
    .then(html => {
      const parser = new DOMParser()
      const doc = parser.parseFromString(html, 'text/html')
      const newContent = doc.getElementById('ticket_batches_list')

      if (newContent && this.hasContentTarget) {
        this.contentTarget.innerHTML = newContent.innerHTML
      }
    })
    .catch(error => console.error("Błąd odświeżania:", error))
  }
}
