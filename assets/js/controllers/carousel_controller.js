import { Controller } from "@hotwired/stimulus"

const SWIPE_THRESHOLD = 50
const TRANSITION_FALLBACK_MS = 700

export default class extends Controller {
  static targets = ["slide", "indicator"]
  static values = { interval: { type: Number, default: 5000 } }

  connect() {
    this.currentIndex = 0
    this.touchStartX = 0
    this.transitioning = false

    this.observer = new IntersectionObserver(this.onVisibilityChange, {
      threshold: 0.5,
    })
    this.observer.observe(this.element)
  }

  disconnect() {
    this.stopAutoPlay()
    this.observer?.disconnect()
  }

  onVisibilityChange = ([entry]) => {
    if (entry.isIntersecting) {
      this.startAutoPlay()
    } else {
      this.stopAutoPlay()
    }
  }

  startAutoPlay() {
    this.stopAutoPlay()
    this.timer = setInterval(() => this.next(), this.intervalValue)
  }

  stopAutoPlay() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  next() {
    if (this.transitioning) return
    const nextIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.slideTo(nextIndex, "next")
  }

  prev() {
    if (this.transitioning) return
    const prevIndex =
      (this.currentIndex - 1 + this.slideTargets.length) %
      this.slideTargets.length
    this.slideTo(prevIndex, "prev")
  }

  goToIndicator(event) {
    if (this.transitioning) return
    const index = this.indicatorTargets.indexOf(event.currentTarget)
    if (index >= 0 && index !== this.currentIndex) {
      const direction = index > this.currentIndex ? "next" : "prev"
      this.slideTo(index, direction)
      this.startAutoPlay()
    }
  }

  slideTo(index, direction) {
    const currentSlide = this.slideTargets[this.currentIndex]
    const nextSlide = this.slideTargets[index]
    if (!currentSlide || !nextSlide) return

    this.transitioning = true

    const orderClass = direction === "next" ? "next" : "prev"
    const moveClass = direction === "next" ? "left" : "right"

    nextSlide.classList.add(orderClass)
    nextSlide.offsetHeight

    currentSlide.classList.add(moveClass)
    nextSlide.classList.add(moveClass)

    let called = false
    const onTransitionEnd = () => {
      if (called) return
      called = true

      currentSlide.removeEventListener("transitionend", onTransitionEnd)

      nextSlide.classList.remove(orderClass, moveClass)
      nextSlide.classList.add("active")
      currentSlide.classList.remove("active", moveClass)

      this.transitioning = false
    }

    currentSlide.addEventListener("transitionend", onTransitionEnd)
    setTimeout(onTransitionEnd, TRANSITION_FALLBACK_MS)

    this.indicatorTargets.forEach((ind) => ind.classList.remove("active"))
    this.indicatorTargets[index]?.classList.add("active")
    this.currentIndex = index
  }

  onTouchStart(event) {
    this.touchStartX = event.changedTouches[0].screenX
  }

  onTouchEnd(event) {
    const touchEndX = event.changedTouches[0].screenX
    const diff = this.touchStartX - touchEndX

    if (Math.abs(diff) > SWIPE_THRESHOLD) {
      if (diff > 0) {
        this.next()
      } else {
        this.prev()
      }
      this.startAutoPlay()
    }
  }
}
