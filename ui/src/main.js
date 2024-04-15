import Vue from 'vue'

import Cookies from 'js-cookie'

import Element from 'element-ui'
import './assets/styles/element-variables.scss'

import '@/assets/styles/index.scss'
import '@/assets/styles/ruoyi.scss'
import App from './App'
import store from './store'
import router from './router'
import directive from './directive'
import plugins from './plugins'
import { download } from '@/utils/request'

import './assets/icons'
import './permission'
import { getDicts } from "@/api/system/dict/data";
import { getConfigKey } from "@/api/system/config";
import { parseTime, resetForm, addDateRange, selectDictLabel, selectDictLabels, handleTree } from "@/utils/ruoyi";
import Pagination from "@/components/Pagination";
import RightToolbar from "@/components/RightToolbar"
import Editor from "@/components/Editor"
import FileUpload from "@/components/FileUpload"
import ImageUpload from "@/components/ImageUpload"
import ImagePreview from "@/components/ImagePreview"
import DictTag from '@/components/DictTag'
import VueMeta from 'vue-meta'
import DictData from '@/components/DictData'


import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import locale from 'element-ui/lib/locale/lang/en'; // 引入英文语言包


Vue.prototype.getDicts = getDicts
Vue.prototype.getConfigKey = getConfigKey
Vue.prototype.parseTime = parseTime
Vue.prototype.resetForm = resetForm
Vue.prototype.addDateRange = addDateRange
Vue.prototype.selectDictLabel = selectDictLabel
Vue.prototype.selectDictLabels = selectDictLabels
Vue.prototype.download = download
Vue.prototype.handleTree = handleTree

Vue.component('DictTag', DictTag)
Vue.component('Pagination', Pagination)
Vue.component('RightToolbar', RightToolbar)
Vue.component('Editor', Editor)
Vue.component('FileUpload', FileUpload)
Vue.component('ImageUpload', ImageUpload)
Vue.component('ImagePreview', ImagePreview)

Vue.use(directive)
Vue.use(plugins)
Vue.use(VueMeta)
Vue.use(ElementUI, { locale });
DictData.install()

Vue.use(Element, {
  size: Cookies.get('size') || 'medium'
})

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
