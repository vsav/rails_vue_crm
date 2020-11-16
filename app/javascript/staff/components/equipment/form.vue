<template lang="pug">
  q-dialog(ref="equipmentFormDialog" persistent)
    q-card.q-dialog-plugin
      q-card-section
        q-form.form.q-gutter-md(ref="equipmentForm")
          q-input(
            outlined
            v-model="equipment.name"
            label="Name *"
            hint="Only letters. Minimum 3"
            lazy-rules="ondemand"
            :rules="validationRules.equipment_name")
          q-input(
            outlined
            v-model="equipment.kind"
            label="Kind *"
            hint="Only letters. Minimum 3"
            lazy-rules="ondemand"
            :rules="validationRules.equipment_kind"
          )
          q-input(
            outlined
            v-model="equipment.serial"
            label="Serial Number *"
            hint="Letters and digits. Minimum 5"
            lazy-rules="ondemand"
            :error="!serialUniq"
            :error-message="uniqueness.serial"
            :rules="validationRules.equipment_serial"
            @input="validateUniqueness(equipment)"
          )
      q-card-actions
        q-btn(type="submit" color="primary" @click="validate()") {{formAction}}
        q-btn.q-ma-md(@click.prevent="hide()" label="Cancel")
</template>

<script>
import { validationRules } from 'utils/validations'

export default {
  name: 'EquipmentForm',
  props: {
    editedEquipment: Object
  },
  data: function () {
    return {
      loading: false,
      uniqueness: {},
      errors: [],
      equipment: {
        name: '',
        kind: '',
        serial: ''
      },
      serialUniq: true,
      validationRules,
      formAction: 'Create Equipment'
    }
  },
  methods: {
    createEquipment () {
      this.loading = true
      const equipment = this.equipment
      this.$api.equipment.create({ equipment })
        .catch((error) => { this.errors.create = error })
        .finally(() => {
          this.loading = false
          this.clearForm()
        })
    },
    updateEquipment (equipment) {
      this.loading = true
      this.$api.equipment.update(equipment)
        .catch((error) => { this.errors.update = error })
        .finally(() => {
          this.loading = false
        })
    },

    clearForm () {
      this.equipment.name = ''
      this.equipment.kind = ''
      this.equipment.serial = ''
    },
    validate () {
      this.$refs.equipmentForm.validate()
        .then((response) => {
          if (response === true && this.serialUniq) {
            this.editedEquipment ? this.updateEquipment(this.equipment) : this.createEquipment()
          }
        })
    },
    validateUniqueness (equipment) {
      this.$api.equipment.validate(equipment)
        .then(({ data }) => {
          if (data.uniqueness.serial) {
            this.uniqueness.serial = data.uniqueness.serial
            this.serialUniq = false
          } else {
            delete this.uniqueness.serial
            this.serialUniq = true
          }
        })
    },
    show () {
      this.$refs.equipmentFormDialog.show()
    },
    hide () {
      this.$router.push({ name: 'equipment_list' })
      this.$refs.equipmentFormDialog.hide()
    }
  },
  created () {
    if (this.editedEquipment) {
      this.equipment = this.editedEquipment
      this.formAction = 'Update Equipment'
    } else {
      this.equipment = {}
      this.formAction = 'Create Equipment'
    }
  }
}
</script>

<style lang="sass" scoped>
</style>
