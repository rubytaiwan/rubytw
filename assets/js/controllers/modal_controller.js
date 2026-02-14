import { Controller } from "@hotwired/stimulus"

const IDLE = "idle"
const OPEN = "open"
const CLOSING = "closing"
const TRANSITION_DURATION = 300

export default class extends Controller {
  static targets = ["dialog"]

  connect() {
    this.forceClose()
    this.state = IDLE
    window.addEventListener("popstate", this.onPopstate)
  }

  disconnect() {
    window.removeEventListener("popstate", this.onPopstate)
    this.forceClose()
  }

  open() {
    if (this.state !== IDLE) return

    this.dialogTarget.style.display = "block"
    document.body.classList.add("modal-open")
    this.addBackdrop()
    requestAnimationFrame(() => this.dialogTarget.classList.add("in"))
    this.state = OPEN
  }

  close() {
    if (this.state !== OPEN) return
    this.state = CLOSING
    this.dialogTarget.classList.remove("in")
    this.removeBackdrop()

    setTimeout(() => {
      this.dialogTarget.style.display = "none"
      document.body.classList.remove("modal-open")
      this.state = IDLE
      history.back()
    }, TRANSITION_DURATION)
  }

  closeOnOverlay(event) {
    if (event.target === this.dialogTarget) this.close()
  }

  onPopstate = () => {
    if (this.state === OPEN) this.forceClose()
  }

  forceClose() {
    this.dialogTarget.classList.remove("in")
    this.dialogTarget.style.display = "none"
    document.body.classList.remove("modal-open")
    this.removeBackdrop()
    this.state = IDLE
  }

  addBackdrop() {
    this.removeBackdrop()
    this.backdrop = document.createElement("div")
    this.backdrop.className = "modal-backdrop fade in"
    this.backdrop.addEventListener("click", () => this.close())
    document.body.appendChild(this.backdrop)
  }

  removeBackdrop() {
    document.querySelectorAll(".modal-backdrop").forEach((el) => el.remove())
    this.backdrop = null
  }
}
