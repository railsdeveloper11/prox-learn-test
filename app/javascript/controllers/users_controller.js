import { Controller } from "@hotwired/stimulus"
import BaseController from './base_controller'

export default class extends BaseController {
  static targets = [
    "firstName",
    "lastName",
    "nickName",
    "email",
    "form",
    "submitBtn",
    "phone",
  ]

  connect() {
    this.appendModalTitle()
    this.disableSubmitBtn()
    this.formValidator = {
      firstName: {
        maxChar: 25,
        valid: false
      },
      lastName: {
        maxChar: 25,
        valid: false
      },
      email: {
        valid: false
      },
      phone: {
        maxChar: 12,
        valid: true
      }
    }
  }

  validateEmail() {
    const isValidEmail = /.+@.+\.[A-Za-z]+$/.test(this.emailTarget?.value)
    if (isValidEmail) {
      this.formValidator.email.valid = true
      this.removeError("email")
    } else {
      this.formValidator.email.valid = false
      this.addError("email", "Invalid Email")
    }
    this.toggleSubmitBtn()
  }

  validatePhone(e) {
    var x = this.phoneTarget.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
    this.phoneTarget.value = !x[2] ? x[1] : + x[1] + '-' + x[2] + (x[3] ? '-' + x[3] : ''); 
    if (!this.phoneTarget.value.length) {
      return this.addError('phone', 'This field is required')
    }

    if (this.phoneTarget.value.length !== this.formValidator.phone.maxChar) {
      return this.addError('phone', 'Invalid phone number')
    }

    this.removeError('phone')
    this.formValidator.phone.valid = true  
    this.toggleSubmitBtn()
  }

  appendModalTitle() {
    const el = document.getElementById('modal_title')
    el.innerHTML = 'Personal Data'
  }
}
