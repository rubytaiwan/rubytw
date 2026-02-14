import "@hotwired/turbo"
import { Application } from "@hotwired/stimulus"

import ScrollController from "./controllers/scroll_controller.js"
import NavbarController from "./controllers/navbar_controller.js"
import ToggleController from "./controllers/toggle_controller.js"
import ModalController from "./controllers/modal_controller.js"
import CarouselController from "./controllers/carousel_controller.js"

const application = Application.start()
application.register("scroll", ScrollController)
application.register("navbar", NavbarController)
application.register("toggle", ToggleController)
application.register("modal", ModalController)
application.register("carousel", CarouselController)
