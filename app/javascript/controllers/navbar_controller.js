import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.handleScroll = this.handleScroll.bind(this)
    window.addEventListener("scroll", this.handleScroll)
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  handleScroll() {
    if (window.scrollY > 10) {
      this.element.classList.add("shadow-md")
      this.element.classList.replace("glass", "bg-white")
    } else {
      this.element.classList.remove("shadow-md")
      this.element.classList.replace("bg-white", "glass")
    }
  }
}
