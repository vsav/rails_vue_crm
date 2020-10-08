const validationRules = {
  fullName: [
    v => !!v || 'Can\'t be blank',
    v => (v && v.length >= 5) || 'Must be at least 5 characters'
  ],
  phone: [
    v => !!v || 'Can\'t be blank',
    v => (v && /^[\d]/i.test(v)) || 'Phone must be only digits',
    v => (v && v.length >= 5) || 'Must be at least 5 digits'
  ],
  email: [
    v => !!v || 'Can\'t be blank',
    v => (v && /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(v)) || 'Must be valid email address'
  ],
  password: [
    v => !!v || 'Can\'t be blank',
    v => (v && v.length >= 5) || 'Must be at least 5 characters'
  ],
  organization_name: [
    v => !!v || 'Can\'t be blank'
  ],
  structure: [
    v => !!v || 'Can\'t be blank',
    v => (v && /^[\w]/i.test(v)) || 'Letters only'
  ],
  inn: [
    v => !!v || 'Can\'t be blank',
    v => (v && /^[\d]/i.test(v)) || 'INN must be only digits',
    v => (v && v.length >= 9 && v.length <= 12) || 'Must be 9 to 12 digits'
  ],
  ogrn: [
    v => !!v || 'Can\'t be blank',
    v => (v && /^[\d]/i.test(v)) || 'INN must be only digits',
    v => (v && v.length === 13) || 'Must be 13 digits'
  ]
}

export { validationRules }

