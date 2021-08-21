import Vue from 'vue'
import App from './App.vue'
import router from './router'
import Chakra, {
  CThemeProvider,
  CColorModeProvider,
  CBox,
  CReset
} from "@chakra-ui/vue";

Vue.use(Chakra)


Vue.config.productionTip = false
Vue.prototype.$currency = 'MATIC'
new Vue({
  router,
  // render: h => h(App)
  render(h) {
    // Mount our application inside the
    // ThemeProvider and ColorModeProvider components :)

    // You can also do this inside the App.vue file if you wish :)
    // See example at https://github.com/chakra-ui/chakra-ui-vue#usage
    return h(CThemeProvider, [
      h(CColorModeProvider, [h(CBox, [h(CReset), h(App)])])
    ]);
  }
}).$mount('#app')
