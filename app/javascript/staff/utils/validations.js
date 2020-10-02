function validateName(value, errors) {
  if (/^[a-z ,.'-]{5,}/i.test(value)) {
    delete errors.full_name;
  } else {
    errors['full_name'] = 'Name must contain minimum 5 characters';
  }
}

function validateEmail(value, errors) {
  if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value)) {
    delete errors.email;
  } else {
    errors['email'] = 'Invalid Email Address';
  }
}

function validatePhone(value, errors) {
  if (/^[\d]{5,}/i.test(value)) {
    delete errors.phone;
  } else {
    errors['phone'] = 'Phone must contain only digits minimum 5 characters';
  }
}

function validatePassword(value, errors) {
  if (/^[\w]{5,}/i.test(value)) {
    delete errors.password;
  } else {
    errors['password'] = 'Password must contain minimum 5 characters';
  }
}

function validatePasswordConfirmation(password, value, errors) {
  if (password === value) {
    delete errors.password_confirmation;
  } else {
    errors['password_confirmation'] = 'Password didn\'t match';
  }
}

function validateUniqueness(client, errors) {
  this.$api.clients.validate(client)
    .then(({data}) => {
      if(data.validations.phone) {
        errors['phone'] = data.validations.phone }
      else if(data.validations.email) {
        errors['email'] = data.validations.email }
      else {
        delete errors['phone']
        delete errors['email']
      }
    })
}

export { validateName, validateEmail, validatePhone, validatePassword, validatePasswordConfirmation, validateUniqueness }


