import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { offset: { type: Number, default: 57 } }

  scroll(event) {
    event.preventDefault()

    const href = event.currentTarget.getAttribute("href")
    const target = document.querySelector(href)
    if (!target) return

    const top = target.getBoundingClientRect().top + window.scrollY - this.offsetValue
    window.scrollTo({ top, behavior: "smooth" })
  }
}
