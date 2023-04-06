import { Application } from "@hotwired/stimulus"
import Clipboard from 'stimulus-clipboard'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
application.register('clipboard', Clipboard)

window.Stimulus   = application
export { application }
