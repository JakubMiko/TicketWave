import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  static targets = ["list"];
  static values = { eventId: Number };

  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "TicketBatchesChannel", event_id: this.eventIdValue },
      {
        received: (data) => {
          this.listTarget.innerHTML = data.html;
        },
      }
    );
  } 

  disconnect() {
    if (this.subscription) {
      consumer.subscriptions.remove(this.subscription);
    }
  }
}
