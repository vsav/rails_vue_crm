<template lang="pug">
  q-dialog(ref="organizationEquipmentDialog" persistent )
    q-card(style="width: 700px; max-width: 80vw;")
      q-card-section
        q-table(
          :title="organization.name + ' Equipment List'"
          :data="equipment"
          :columns="columns"
          :pagination.sync="pagination"
          selection="multiple"
          :selected.sync="selected"
          row-key="id"
        )
        q-btn(@click.prevent="updateEquipmentList(organization)" label="Update" color="orange" icon="warning" class="q-ma-md")
        q-btn(@click.prevent="hide()" label="Cancel" class="q-ma-md")

</template>
<script>
export default {
  name: 'OrganizationEquipmentTable',
  props: {
    organization: Object
  },
  data() {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      equipment: [],
      selected: [],
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
          label: 'Serial',
          field: 'serial',
          align: 'left',
          sortable: true
        }
      ]
    }
  },
  created() {
    this.fetchEquipment()
  },
  updated() {
    this.organization.equipment = this.selected
  },
  methods: {
    fetchEquipment() {
      this.$api.equipment.index()
          .then(({data}) => this.equipment = data)
          .catch((error) => this.errors['fetch'] = error)
      this.selectEquipment()
    },
    updateEquipmentList(organization) {
      this.loading = true
      this.$api.organizations.update(organization)
          .catch((error) => this.errors['update'] = error)
          .finally(() => {
            this.loading = false
            this.hide()
          })
    },
    show () {
      this.$refs.organizationEquipmentDialog.show()
    },
    hide () {
      this.$router.push({name: 'organizations'})
      this.$refs.organizationEquipmentDialog.hide()
    },
    selectEquipment() {
      this.organization.equipment.forEach(equipment => {
        this.selected.push(equipment)
      })
    }
  }
}
</script>

