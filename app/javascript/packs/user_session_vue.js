import Vue from 'vue/dist/vue.esm'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#training-image-form',
    data: {
      imgUrl: ''
    },
    methods: {
      uploadFile: function(e) {
        const file = e.target.files[0];
        this.imgUrl = URL.createObjectURL(file);
      }
    }
  })
});