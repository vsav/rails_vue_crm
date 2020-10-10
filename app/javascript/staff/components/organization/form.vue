<template lang="pug">
  q-dialog(ref="organizationFormDialog")
    q-card(class="q-dialog-plugin")
      q-card-section
        q-form(
          ref="organizationForm"
          class="form q-gutter-md"
        )
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
</template>

<script>
import { validationRules } from "../../utils/validations";

export default {
  name: 'OrganizationForm',
  props: {
    edited_organization: Object,
  },
  data: function() {
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
      organizationNameUniq: true,
      innUniq: true,
      validationRules,
      formAction: 'Create Organization'
    }
  },
  methods: {
    createOrganization() {
      this.loading = true
      const organization = this.organization
      this.$api.organizations.create({organization})
          .catch((error) => this.errors['create'] = error)
          .finally(() => {
            this.loading = false
            this.clearForm()
          })
    },
    updateOrganization(organization) {
      this.loading = true
      this.$api.organizations.update(organization)
          .catch((error) => this.errors['update'] = error)
          .finally(() => {
            this.loading = false
          })
    },
    clearForm() {
      this.organization.name = ''
      this.organization.structure = ''
      this.organization.inn = ''
      this.organization.ogrn = ''
    },
    validate() {
      this.$refs.organizationForm.validate()
          .then((response) => {
            if(response === true) {
              this.edited_organization? this.updateOrganization(this.organization) : this.createOrganization()
            }
          })
    },
    validateUniqueness(organization) {
      this.$api.organizations.validate(organization)
          .then(({data}) => {
            if(data.uniqueness.organization_name) {
              this.uniqueness.organization_name = data.uniqueness.organization_name
              this.organizationNameUniq = false
            }
            else if(data.uniqueness.inn) {
              this.uniqueness.inn = data.uniqueness.inn
              this.innUniq = false
            }
            else {
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
      this.$refs.organizationFormDialog.hide()
    }
  },
  created() {
    if(this.edited_organization) {
      this.organization = this.edited_organization
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
