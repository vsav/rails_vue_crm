<template lang="pug">
  q-table(
    title="Equipment List"
    :data="equipmentList"
    :columns="columns"
    :pagination.sync="pagination"
    row-key="id"
  )
    template(v-slot:body-cell-actions="equipment")
      q-td(:equipment="equipment")
        q-btn(@click.prevent="deleteEquipment(equipment)" icon="delete" round)
        q-btn(@click="editEquipment(equipment)" icon="edit" round v-model="equipment")
    template(v-slot:top-right)
      q-btn.q-ma-md.right(label="Create Equipment" color="primary" @click="showForm")
</template>
<script>
import EquipmentForm from './form'

export default {
  name: 'EquipmentTable',
  data () {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      equipmentList: [],
      equipment: {},
      columns: [
        {
          name: 'name',
          label: 'Name',
          field: 'name',
          align: 'left',
          sortable: true
        },
        {
          name: 'kind',
          label: 'Kind',
          field: 'kind',
          align: 'left',
          sortable: true
        },
        {
          name: 'serial',
          label: 'Serial Number',
          field: 'serial',
          align: 'left',
          sortable: true
        },
        {
          name: 'actions',
          label: 'Actions',
          align: 'left'
        }
      ]
    }
  },
  created () {
    this.fetchEquipment()
  },
  methods: {
    fetchEquipment () {
      this.$api.equipment.index()
        .then(({ data }) => { this.equipmentList = data.equipment })
        .catch((error) => { this.errors.fetch = error })
    },
    deleteEquipment (equipment) {
      const equipmentId = equipment.row.id
      this.$api.equipment.delete(equipmentId)
        .then(() => this.fetchEquipment())
        .catch((error) => { this.errors.delete = error })
    },
    setEquipment (equipment) {
      this.equipment = equipment
    },
    showForm () {
      this.$router.push({ name: 'new_equipment' })
      this.$q.dialog({
        component: EquipmentForm,
        parent: this
      })
    },
    editEquipment (equipment) {
      this.setEquipment(equipment.row)
      this.$router.push({ name: 'edit_equipment', params: { id: equipment.row.id } })
      this.$q.dialog({
        component: EquipmentForm,
        parent: this,
        editedEquipment: this.equipment
      })
    }
  }
}
</script>
