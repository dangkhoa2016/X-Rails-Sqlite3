import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-tweets"
export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html' }

  connect() {
    console.log("Hello, Stimulus!");
    window.addEventListener('scroll', () => {
      if (window.innerHeight + window.pageYOffset >= document.body.offsetHeight) {
        if (this.element.dataset.lastPage === 'false') {
          // alert('this is not the last page');
          fetch(`/?page=${this.element.dataset.nextPage}`, { headers: this.headers }).then(response => response.text()).then(html => Turbo.renderStreamMessage(html));
        }
      }
    });
  }
}
