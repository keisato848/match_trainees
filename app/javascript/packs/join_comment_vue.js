import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '.training-right-content',
    data: {
      isActive: true,
    },
    computed: {
      classObject: function() {
        return {
          visible: !this.isActive,
          hidden: this.isActive
        }
      }
    },
    components: { App }
  })
})
