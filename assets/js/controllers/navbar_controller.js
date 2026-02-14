import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["collapse"]
  static values = {
    affixOffset: { type: Number, default: 100 },
    scrollSpyOffset: { type: Number, default: 60 },
  }

  connect() {
    window.addEventListener("scroll", this.handleScroll, { passive: true })
    this.handleScroll()

    this.setupScrollSpy()
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll)

    if (this.observer) {
      this.observer.disconnect()
    }
  }

  handleScroll = () => {
    if (window.scrollY >= this.affixOffsetValue) {
      this.element.classList.add("affix")
      this.element.classList.remove("affix-top")
    } else {
      this.element.classList.remove("affix")
      this.element.classList.add("affix-top")
    }
  }

  setupScrollSpy() {
    const links = this.element.querySelectorAll("a.page-scroll[href^='#']")
    const sections = []

    links.forEach((link) => {
      const href = link.getAttribute("href")
      const section = document.querySelector(href)
      if (section) {
        sections.push({ link, section })
      }
    })

    if (sections.length === 0) return

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            links.forEach((link) => {
              link.closest("li")?.classList.remove("active")
            })

            const match = sections.find((s) => s.section === entry.target)
            if (match) {
              match.link.closest("li")?.classList.add("active")
            }
          }
        })
      },
      {
        rootMargin: `-${this.scrollSpyOffsetValue}px 0px -40% 0px`,
        threshold: 0,
      }
    )

    sections.forEach(({ section }) => this.observer.observe(section))
  }

  toggleCollapse() {
    this.collapseTarget.classList.toggle("in")
  }

  closeCollapse() {
    this.collapseTarget.classList.remove("in")
  }
}
