import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image", "caption"]

  open(event) {
    event.preventDefault()
    const url = event.currentTarget.dataset.url
    const caption = event.currentTarget.dataset.caption || ""
    this.imageTarget.src = url
    this.imageTarget.alt = caption
    this.captionTarget.textContent = caption
    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.imageTarget.src = ""
    document.body.classList.remove("overflow-hidden")
  }

  keydown(event) {
    if (event.key === "Escape") this.close()
  }
}
