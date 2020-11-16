<template lang="pug">
  q-dialog(ref="organizationFormDialog" persistent)
    q-card(class="q-dialog-plugin")
      q-card-section
        q-form(
          ref="organizationForm"
          class="form q-gutter-md"
        )
          q-select(
            v-model="organization.inn"
            use-input
            emit-value
            :options="dadataSuggestions"
            label="Search with DaData"
            @filter="fetchDadataInfo"
            @input="populateFormFields"
          )
            template(v-slot:no-option="")
              q-item
                q-item-section.text-grey
                  | Nothing found

          q-input(
            outlined
            v-model="organization.name"
            label="Name *"
            hint="Organization name"
            lazy-rules="ondemand"
            :error="!organizationNameUniq"
            :error-message="uniqueness.organization_name"
            :rules="validationRules.organization_name"
            @blur="validateUniqueness(organization)"
            @input="organizationNameUniq = true"
          )
          q-input(
            outlined
            v-model="organization.structure"
            label="Structure *"
            hint="OOO, OAO, ZAO..."
            lazy-rules="ondemand"
            :rules="validationRules.structure"
          )
          q-input(
            outlined
            v-model="organization.inn"
            label="INN *"
            hint='Please enter valid INN (9-12 digits)'
            lazy-rules="ondemand"
            :rules="validationRules.inn"
            :error="!innUniq"
            :error-message="uniqueness.inn"
            @blur="validateUniqueness(organization)"
            @input="innUniq = true"
          )
          q-input(
            outlined
            v-model='organization.ogrn'
            label="OGRN *"
            hint='Please enter valid OGRN (13 digits)'
            lazy-rules="ondemand"
            :rules="validationRules.ogrn"
          )
      q-card-actions
        q-btn(type="submit" color="primary" @click="validate()") {{formAction}}
        q-btn(@click.prevent="hide()" label="Cancel" class="q-ma-md")
</template>

<script>
import { validationRules } from 'utils/validations'
import { DadataClient } from '../../utils/dadataClient'

export default {
  name: 'OrganizationForm',
  props: {
    editedOrganization: Object
  },
  data: function () {
    return {
      loading: false,
      uniqueness: {},
      errors: [],
      organization: {
        name: '',
        structure: '',
        inn: '',
        ogrn: '',
        clients: []
      },
      dadataSuggestions: [],
      requestInn: '',
      organizationNameUniq: true,
      innUniq: true,
      validationRules,
      formAction: 'Create Organization'
    }
  },
  methods: {
    createOrganization () {
      this.loading = true
      const organization = this.organization
      this.$api.organizations.create({ organization })
        .catch((error) => { this.errors.create = error })
        .finally(() => {
          this.loading = false
          this.clearForm()
        })
    },
    updateOrganization (organization) {
      this.loading = true
      this.$api.organizations.update(organization)
        .catch((error) => { this.errors.update = error })
        .finally(() => {
          this.loading = false
        })
    },
    clearForm () {
      this.organization.name = ''
      this.organization.structure = ''
      this.organization.inn = ''
      this.organization.ogrn = ''
    },
    validate () {
      this.$refs.organizationForm.validate()
        .then((response) => {
          if (response === true) {
            this.editedOrganization ? this.updateOrganization(this.organization) : this.createOrganization()
          }
        })
    },
    validateUniqueness (organization) {
      this.$api.organizations.validate(organization)
        .then(({ data }) => {
          if (data.uniqueness.organization_name) {
            this.uniqueness.organization_name = data.uniqueness.organization_name
            this.organizationNameUniq = false
          } else if (data.uniqueness.inn) {
            this.uniqueness.inn = data.uniqueness.inn
            this.innUniq = false
          } else {
            delete this.uniqueness.organization_name
            delete this.uniqueness.inn
            this.organizationNameUniq = true
            this.innUniq = true
          }
        })
    },
    show () {
      this.$refs.organizationFormDialog.show()
    },
    hide () {
      this.$router.push({ name: 'organizations' })
      this.$refs.organizationFormDialog.hide()
    },
    populateFormFields (val) {
      this.organization.name = val.data.name.short
      this.organization.structure = val.data.opf.short
      this.organization.inn = val.data.inn
      this.organization.ogrn = val.data.ogrn
    },
    fetchDadataInfo (val, update, abort) {
      if (val.length < 2) {
        abort()
        return
      }
      update(() => {
        new DadataClient(val).then(result => {
          this.dadataSuggestions = result.suggestions.map(suggestion => ({
            value: suggestion,
            label: suggestion.value
          }))
        })
      })
    }
  },
  created () {
    if (this.editedOrganization) {
      this.organization = this.editedOrganization
      this.formAction = 'Update Organization'
    } else {
      this.organization = {}
      this.formAction = 'Create Organization'
    }
  }
}
</script>
<style lang="sass" scoped>
</style>
