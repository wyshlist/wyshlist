// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AddCommentController from "./add_comment_controller"
application.register("add-comment", AddCommentController)

import CharacterCounterController from "./character_counter_controller"
application.register("character-counter", CharacterCounterController)

import ClipboardController from "./clipboard_controller"
application.register("clipboard", ClipboardController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import LoadingOrganizationController from "./loading_organization_controller"
application.register("loading-organization", LoadingOrganizationController)

import ModalPassValueController from "./modal_pass_value_controller"
application.register("modal-pass-value", ModalPassValueController)

import PhotoPreviewController from "./photo_preview_controller"
application.register("photo-preview", PhotoPreviewController)

import SearchWishesController from "./search_wishes_controller"
application.register("search-wishes", SearchWishesController)

import ShowTicketDetailsController from "./show_ticket_details_controller"
application.register("show-ticket-details", ShowTicketDetailsController)

import TabController from "./tab_controller"
application.register("tab", TabController)

import WizardController from "./wizard_controller"
application.register("wizard", WizardController)
