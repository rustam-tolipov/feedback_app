import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search"
export default class extends Controller {
  static values = { url: String }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 300)
  }
}