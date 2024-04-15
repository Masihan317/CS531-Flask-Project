export default [
  {
    layout: 'colFormItem',
    tagIcon: 'input',
    label: 'phone number',
    vModel: 'mobile',
    formId: 6,
    tag: 'el-input',
    placeholder: 'please input phone number',
    defaultValue: '',
    span: 24,
    style: { width: '100%' },
    clearable: true,
    prepend: '',
    append: '',
    'prefix-icon': 'el-icon-mobile',
    'suffix-icon': '',
    maxlength: 11,
    'show-word-limit': true,
    readonly: false,
    disabled: false,
    required: true,
    changeTag: true,
    regList: [{
      pattern: '/^[0-9]{3}-[0-9]{3}-[0-9]{4}$/',
      message: 'wrong phone number format'
    }]
  }
]
