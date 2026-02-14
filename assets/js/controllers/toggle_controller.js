import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wrapper"]

  toggle() {
    this.wrapperTarget.classList.toggle("more--visible")
  }
}
