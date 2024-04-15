export const formConf = {
  formRef: 'elForm',
  formModel: 'formData',
  size: 'medium',
  labelPosition: 'right',
  labelWidth: 100,
  formRules: 'rules',
  gutter: 15,
  disabled: false,
  span: 24,
  formBtns: true
}

export const inputComponents = [
  {
    label: 'single line text',
    tag: 'el-input',
    tagIcon: 'input',
    placeholder: 'please input',
    defaultValue: undefined,
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    clearable: true,
    prepend: '',
    append: '',
    'prefix-icon': '',
    'suffix-icon': '',
    maxlength: null,
    'show-word-limit': false,
    readonly: false,
    disabled: false,
    required: true,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/input'
  },
  {
    label: 'multi-line text',
    tag: 'el-input',
    tagIcon: 'textarea',
    type: 'textarea',
    placeholder: 'please input',
    defaultValue: undefined,
    span: 24,
    labelWidth: null,
    autosize: {
      minRows: 4,
      maxRows: 4
    },
    style: { width: '100%' },
    maxlength: null,
    'show-word-limit': false,
    readonly: false,
    disabled: false,
    required: true,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/input'
  },
  {
    label: 'password',
    tag: 'el-input',
    tagIcon: 'password',
    placeholder: 'please input',
    defaultValue: undefined,
    span: 24,
    'show-password': true,
    labelWidth: null,
    style: { width: '100%' },
    clearable: true,
    prepend: '',
    append: '',
    'prefix-icon': '',
    'suffix-icon': '',
    maxlength: null,
    'show-word-limit': false,
    readonly: false,
    disabled: false,
    required: true,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/input'
  },
  {
    label: 'counter',
    tag: 'el-input-number',
    tagIcon: 'number',
    placeholder: '',
    defaultValue: undefined,
    span: 24,
    labelWidth: null,
    min: undefined,
    max: undefined,
    step: undefined,
    'step-strictly': false,
    precision: undefined,
    'controls-position': '',
    disabled: false,
    required: true,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/input-number'
  }
]

export const selectComponents = [
  {
    label: 'dropdown select',
    tag: 'el-select',
    tagIcon: 'select',
    placeholder: 'please select',
    defaultValue: undefined,
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    clearable: true,
    disabled: false,
    required: true,
    filterable: false,
    multiple: false,
    options: [{
      label: 'option 1',
      value: 1
    }, {
      label: 'option 2',
      value: 2
    }],
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/select'
  },
  {
    label: 'cascade selection',
    tag: 'el-cascader',
    tagIcon: 'cascader',
    placeholder: 'please select',
    defaultValue: [],
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    props: {
      props: {
        multiple: false
      }
    },
    'show-all-levels': true,
    disabled: false,
    clearable: true,
    filterable: false,
    required: true,
    options: [{
      id: 1,
      value: 1,
      label: 'option 1',
      children: [{
        id: 2,
        value: 2,
        label: 'option 1-1'
      }]
    }],
    dataType: 'dynamic',
    labelKey: 'label',
    valueKey: 'value',
    childrenKey: 'children',
    separator: '/',
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/cascader'
  },
  {
    label: 'radio',
    tag: 'el-radio-group',
    tagIcon: 'radio',
    defaultValue: undefined,
    span: 24,
    labelWidth: null,
    style: {},
    optionType: 'default',
    border: false,
    size: 'medium',
    disabled: false,
    required: true,
    options: [{
      label: 'option 1',
      value: 1
    }, {
      label: 'option 2',
      value: 2
    }],
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/radio'
  },
  {
    label: 'checkbox',
    tag: 'el-checkbox-group',
    tagIcon: 'checkbox',
    defaultValue: [],
    span: 24,
    labelWidth: null,
    style: {},
    optionType: 'default',
    border: false,
    size: 'medium',
    disabled: false,
    required: true,
    options: [{
      label: 'option 1',
      value: 1
    }, {
      label: 'option 2',
      value: 2
    }],
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/checkbox'
  },
  {
    label: 'switch',
    tag: 'el-switch',
    tagIcon: 'switch',
    defaultValue: false,
    span: 24,
    labelWidth: null,
    style: {},
    disabled: false,
    required: true,
    'active-text': '',
    'inactive-text': '',
    'active-color': null,
    'inactive-color': null,
    'active-value': true,
    'inactive-value': false,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/switch'
  },
  {
    label: 'slider',
    tag: 'el-slider',
    tagIcon: 'slider',
    defaultValue: null,
    span: 24,
    labelWidth: null,
    disabled: false,
    required: true,
    min: 0,
    max: 100,
    step: 1,
    'show-stops': false,
    range: false,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/slider'
  },
  {
    label: 'time-picker',
    tag: 'el-time-picker',
    tagIcon: 'time',
    placeholder: 'please select',
    defaultValue: null,
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    disabled: false,
    clearable: true,
    required: true,
    'picker-options': {
      selectableRange: '00:00:00-23:59:59'
    },
    format: 'HH:mm:ss',
    'value-format': 'HH:mm:ss',
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/time-picker'
  },
  {
    label: 'time range',
    tag: 'el-time-picker',
    tagIcon: 'time-range',
    defaultValue: null,
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    disabled: false,
    clearable: true,
    required: true,
    'is-range': true,
    'range-separator': 'to',
    'start-placeholder': 'start time',
    'end-placeholder': 'end time',
    format: 'HH:mm:ss',
    'value-format': 'HH:mm:ss',
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/time-picker'
  },
  {
    label: 'date-picker',
    tag: 'el-date-picker',
    tagIcon: 'date',
    placeholder: 'please select',
    defaultValue: null,
    type: 'date',
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    disabled: false,
    clearable: true,
    required: true,
    format: 'yyyy-MM-dd',
    'value-format': 'yyyy-MM-dd',
    readonly: false,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/date-picker'
  },
  {
    label: 'date range',
    tag: 'el-date-picker',
    tagIcon: 'date-range',
    defaultValue: null,
    span: 24,
    labelWidth: null,
    style: { width: '100%' },
    type: 'daterange',
    'range-separator': 'to',
    'start-placeholder': 'start date',
    'end-placeholder': 'end date',
    disabled: false,
    clearable: true,
    required: true,
    format: 'yyyy-MM-dd',
    'value-format': 'yyyy-MM-dd',
    readonly: false,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/date-picker'
  },
  {
    label: 'rate',
    tag: 'el-rate',
    tagIcon: 'rate',
    defaultValue: 0,
    span: 24,
    labelWidth: null,
    style: {},
    max: 5,
    'allow-half': false,
    'show-text': false,
    'show-score': false,
    disabled: false,
    required: true,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/rate'
  },
  {
    label: 'color-picker',
    tag: 'el-color-picker',
    tagIcon: 'color',
    defaultValue: null,
    labelWidth: null,
    'show-alpha': false,
    'color-format': '',
    disabled: false,
    required: true,
    size: 'medium',
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/color-picker'
  },
  {
    label: 'upload',
    tag: 'el-upload',
    tagIcon: 'upload',
    action: 'https://jsonplaceholder.typicode.com/posts/',
    defaultValue: null,
    labelWidth: null,
    disabled: false,
    required: true,
    accept: '',
    name: 'file',
    'auto-upload': true,
    showTip: false,
    buttonText: 'click upload',
    fileSize: 2,
    sizeUnit: 'MB',
    'list-type': 'text',
    multiple: false,
    regList: [],
    changeTag: true,
    document: 'https://element.eleme.io/#/en-US/component/upload'
  }
]

export const layoutComponents = [
  {
    layout: 'rowFormItem',
    tagIcon: 'row',
    type: 'default',
    justify: 'start',
    align: 'top',
    label: 'row container',
    layoutTree: true,
    children: [],
    document: 'https://element.eleme.io/#/en-US/component/layout'
  },
  {
    layout: 'colFormItem',
    label: 'button',
    changeTag: true,
    labelWidth: null,
    tag: 'el-button',
    tagIcon: 'button',
    span: 24,
    default: 'main button',
    type: 'primary',
    icon: 'el-icon-search',
    size: 'medium',
    disabled: false,
    document: 'https://element.eleme.io/#/en-US/component/button'
  }
]

export const trigger = {
  'el-input': 'blur',
  'el-input-number': 'blur',
  'el-select': 'change',
  'el-radio-group': 'change',
  'el-checkbox-group': 'change',
  'el-cascader': 'change',
  'el-time-picker': 'change',
  'el-date-picker': 'change',
  'el-rate': 'change'
}