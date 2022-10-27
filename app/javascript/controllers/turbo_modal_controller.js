import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hideModal() {
    const el = document.getElementById("turbo-modal")
    el.classList.add('hidden') // it might be nice to also remove the modal SRC
  }

  handleSuccess({ detail: { success } }) {
    if (success) {
      this.hideModal()
    }
  }
}