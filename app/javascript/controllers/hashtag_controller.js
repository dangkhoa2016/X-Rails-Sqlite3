import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="hashtag"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (_) => {
      Turbo.visit(this.element.dataset.url);
    })
  }
}
