import BaseController from './base_controller'

export default class extends BaseController {
  static targets = [
    "employer",
    "startDate",
    "submitBtn",
    "endDate",
    "user_id",
  ]

  connect() {
    this.disableSubmitBtn()
    this.appendModalTitle()
    this.formValidator = {
      employer: {
        maxChar: 25,
        valid: false
      },
      startDate: {
        valid: false
      },
      endDate: {
        valid: false
      },
    }
  }

  appendModalTitle() {
    const el = document.getElementById('modal_title')
    el.innerHTML = 'Create Employment'
  }

  validateStartDateField() {
    if (this.startDateTarget.value === "") {
      this.formValidator.startDate.valid = false
      return this.addError('startDate', 'This field is required')
    }

    const startDate = new Date(this.startDateTarget.value)
    const endDate = new Date(this.endDateTarget.value)
  
    if (endDate <  startDate) {
      this.formValidator.startDate.valid = false
      return this.addError('startDate', 'Start Date should not be greater than end date')
    }

    this.removeError('startDate')
    this.formValidator.startDate.valid = true
    this.toggleSubmitBtn()
  }

  validateEndDateField() {
    if (this.startDateTarget.value === "") {
      this.formValidator.endDate.valid = false
      return this.addError('endDate', 'Start Date is required to select End Date')
    }

    if (this.endDateTarget.value === "") {
      this.formValidator.endDate.valid = false
      return this.addError('endDate', 'This field is required')
    }

    const startDate = new Date(this.startDateTarget.value)
    const endDate = new Date(this.endDateTarget.value)

    if (endDate <  startDate) {
      this.formValidator.endDate.valid = false
      return this.addError('endDate', 'End Date should not be smaller than start date')
    }

    this.removeError('endDate')
    this.formValidator.endDate.valid = true
    this.toggleSubmitBtn()
  }
}