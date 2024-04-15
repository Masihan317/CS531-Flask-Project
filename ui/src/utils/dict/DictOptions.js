import { mergeRecursive } from "@/utils/ruoyi";
import dictConverter from './DictConverter'

export const options = {
  metas: {
    '*': {
      request: (dictMeta) => {
        console.log(`load dict ${dictMeta.type}`)
        return Promise.resolve([])
      },
      responseConverter,
      labelField: 'label',
      valueField: 'value',
    },
  },
  DEFAULT_LABEL_FIELDS: ['label', 'name', 'title'],
  DEFAULT_VALUE_FIELDS: ['value', 'id', 'uid', 'key'],
}

/**
 * @param {Object} response 
 * @param {DictMeta} dictMeta 
 * @returns {DictData}
 */
function responseConverter(response, dictMeta) {
  const dicts = response.content instanceof Array ? response.content : response
  if (dicts === undefined) {
    console.warn(`no dict data of "${dictMeta.type}" found in the response`)
    return []
  }
  return dicts.map(d => dictConverter(d, dictMeta))
}

export function mergeOptions(src) {
  mergeRecursive(options, src)
}

export default options
