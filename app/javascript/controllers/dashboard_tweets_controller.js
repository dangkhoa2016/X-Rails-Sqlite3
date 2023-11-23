import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-tweets"
export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html' }

  connect() {
    window.addEventListener('scroll', () => {
      if (window.innerHeight + window.pageYOffset >= document.body.offsetHeight) {
        if (this.element.dataset.lastPage === 'false') {
          // alert('this is not the last page');
          fetch(`dashboard?page=${this.element.dataset.nextPage}`, { headers: this.headers }).then(response => response.text()).then(html => Turbo.renderStreamMessage(html));
        }
      }
    });
  }
}
