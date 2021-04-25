import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#flash-notice',
    data: {
      isActive: false,
    },
    computed: {
      flashClassObject: function() {
        return {
          hidden: this.isActive
        }
      }
    },
    components: { App }
  })
})
