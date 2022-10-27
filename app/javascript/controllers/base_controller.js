import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  validateRequiredField(e) {
    const target = `${e.target.dataset.target.split(".")[1]}`
    if (this[`${target}Target`].value === "") {
      this.addError(target, 'This field is required')
      this.formValidator[target].valid = false
    } else if(this.invalidMaxLength(target)) {
      const maxLenMsg = `Max length required is ${this.formValidator[target].maxChar} char`
      this.addError(target, maxLenMsg)
      this.formValidator[target].valid = false
    } else {
      this.formValidator[target].valid = true
      this.removeError(target)
    }
    this.toggleSubmitBtn()
  }

  invalidMaxLength(target) {
    return this[`${target}Target`].value.length > this.formValidator[target].maxChar
  }

  addError(target, msg) {
    this[`${target}Target`].classList.remove("border-gray-200")
    this[`${target}Target`].classList.add("border-red-500")
    this.addErrorMessage(target, msg)
  }

  removeErrorMessage(target) {
    const el = this[`${target}Target`]?.parentNode.getElementsByTagName('span')

    if (el.length > 0) {
      el.item(0).remove()
    }
  }

  addErrorMessage(target, msg) {
    const el = this[`${target}Target`]?.parentNode.getElementsByTagName('span')

    if (el.length > 0) {
      el.item(0).remove()
    }

    const span = document.createElement("span");
    span.className += 'flex items-center error-msg font-medium tracking-wide text-red-500 text-xs mt-1 ml-1'
    span.innerHTML = msg
    this[`${target}Target`].parentNode.append(span)
    
  }

  removeError(target) {
    this[`${target}Target`].classList.add("border-gray-200")
    this[`${target}Target`].classList.remove("border-red-500")
    this.removeErrorMessage(target)
  }

  toggleSubmitBtn() {
    const isFormInValid = Object.keys(this.formValidator).some((field) => {
      return this.formValidator[field].valid === false
    })

    if (isFormInValid === true) {
      this.disableSubmitBtn()
    } else {
      this.enableSubmitBtn()
    }
  }

  disableSubmitBtn() {
    this.submitBtnTarget.disabled = true
    this.submitBtnTarget.classList.add('opacity-25')
  }

  enableSubmitBtn() {
    this.submitBtnTarget.disabled = false
    this.submitBtnTarget.classList.remove('opacity-25')
  }
}