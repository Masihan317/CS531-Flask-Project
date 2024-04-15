<template>
  <el-card>
    <el-tabs v-model="activeName">
      <el-tab-pane label="basic information" name="basic">
        <basic-info-form ref="basicInfo" :info="info" />
      </el-tab-pane>
      <el-tab-pane label="field information" name="columnInfo">
        <el-table ref="dragTable" :data="columns" row-key="columnId" :max-height="tableHeight">
          <el-table-column label="serial number" type="index" min-width="5%" class-name="allowDrag" />
          <el-table-column
            label="field column name"
            prop="columnName"
            min-width="10%"
            :show-overflow-tooltip="true"
          />
          <el-table-column label="field description" min-width="10%">
            <template slot-scope="scope">
              <el-input v-model="scope.row.columnComment"></el-input>
            </template>
          </el-table-column>
          <el-table-column
            label="physical type"
            prop="columnType"
            min-width="10%"
            :show-overflow-tooltip="true"
          />
          <el-table-column label="java type" min-width="11%">
            <template slot-scope="scope">
              <el-select v-model="scope.row.javaType">
                <el-option label="Long" value="Long" />
                <el-option label="String" value="String" />
                <el-option label="Integer" value="Integer" />
                <el-option label="Double" value="Double" />
                <el-option label="BigDecimal" value="BigDecimal" />
                <el-option label="Date" value="Date" />
                <el-option label="Boolean" value="Boolean" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="java attribute" min-width="10%">
            <template slot-scope="scope">
              <el-input v-model="scope.row.javaField"></el-input>
            </template>
          </el-table-column>

          <el-table-column label="insert" min-width="5%">
            <template slot-scope="scope">
              <el-checkbox true-label="1" v-model="scope.row.isInsert"></el-checkbox>
            </template>
          </el-table-column>
          <el-table-column label="edit" min-width="5%">
            <template slot-scope="scope">
              <el-checkbox true-label="1" v-model="scope.row.isEdit"></el-checkbox>
            </template>
          </el-table-column>
          <el-table-column label="table" min-width="5%">
            <template slot-scope="scope">
              <el-checkbox true-label="1" v-model="scope.row.isList"></el-checkbox>
            </template>
          </el-table-column>
          <el-table-column label="lookup" min-width="5%">
            <template slot-scope="scope">
              <el-checkbox true-label="1" v-model="scope.row.isQuery"></el-checkbox>
            </template>
          </el-table-column>
          <el-table-column label="lookup method" min-width="10%">
            <template slot-scope="scope">
              <el-select v-model="scope.row.queryType">
                <el-option label="=" value="EQ" />
                <el-option label="!=" value="NE" />
                <el-option label=">" value="GT" />
                <el-option label=">=" value="GTE" />
                <el-option label="<" value="LT" />
                <el-option label="<=" value="LTE" />
                <el-option label="LIKE" value="LIKE" />
                <el-option label="BETWEEN" value="BETWEEN" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="required" min-width="5%">
            <template slot-scope="scope">
              <el-checkbox true-label="1" v-model="scope.row.isRequired"></el-checkbox>
            </template>
          </el-table-column>
          <el-table-column label="display type" min-width="12%">
            <template slot-scope="scope">
              <el-select v-model="scope.row.htmlType">
                <el-option label="textbox" value="input" />
                <el-option label="textarea" value="textarea" />
                <el-option label="dropdown" value="select" />
                <el-option label="radio button" value="radio" />
                <el-option label="checkbox" value="checkbox" />
                <el-option label="datetime picker" value="datetime" />
                <el-option label="image upload" value="imageUpload" />
                <el-option label="file upload" value="fileUpload" />
                <el-option label="rich text editor" value="editor" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="dictionary type" min-width="12%">
            <template slot-scope="scope">
              <el-select v-model="scope.row.dictType" clearable filterable placeholder="please select">
                <el-option
                  v-for="dict in dictOptions"
                  :key="dict.dictType"
                  :label="dict.dictName"
                  :value="dict.dictType">
                  <span style="float: left">{{ dict.dictName }}</span>
                  <span style="float: right; color: #8492a6; font-size: 13px">{{ dict.dictType }}</span>
              </el-option>
              </el-select>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="generation information" name="genInfo">
        <gen-info-form ref="genInfo" :info="info" :tables="tables" :menus="menus"/>
      </el-tab-pane>
    </el-tabs>
    <el-form label-width="100px">
      <el-form-item style="text-align: center;margin-left:-100px;margin-top:10px;">
        <el-button type="primary" @click="submitForm()">submit</el-button>
        <el-button @click="close()">back</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { getGenTable, updateGenTable } from "@/api/tool/gen";
import { optionselect as getDictOptionselect } from "@/api/system/dict/type";
import { listMenu as getMenuTreeselect } from "@/api/system/menu";
import basicInfoForm from "./basicInfoForm";
import genInfoForm from "./genInfoForm";
import Sortable from 'sortablejs'

export default {
  name: "GenEdit",
  components: {
    basicInfoForm,
    genInfoForm
  },
  data() {
    return {
      activeName: "columnInfo",
      tableHeight: document.documentElement.scrollHeight - 245 + "px",
      tables: [],
      columns: [],
      dictOptions: [],
      menus: [],
      info: {}
    };
  },
  created() {
    const tableId = this.$route.params && this.$route.params.tableId;
    if (tableId) {
      getGenTable(tableId).then(res => {
        this.columns = res.data.rows;
        this.info = res.data.info;
        this.tables = res.data.tables;
      });
      getDictOptionselect().then(response => {
        this.dictOptions = response.data;
      });
      getMenuTreeselect().then(response => {
        this.menus = this.handleTree(response.data, "menuId");
      });
    }
  },
  methods: {
    submitForm() {
      const basicForm = this.$refs.basicInfo.$refs.basicInfoForm;
      const genForm = this.$refs.genInfo.$refs.genInfoForm;
      Promise.all([basicForm, genForm].map(this.getFormPromise)).then(res => {
        const validateResult = res.every(item => !!item);
        if (validateResult) {
          const genTable = Object.assign({}, basicForm.model, genForm.model);
          genTable.columns = this.columns;
          genTable.params = {
            treeCode: genTable.treeCode,
            treeName: genTable.treeName,
            treeParentCode: genTable.treeParentCode,
            parentMenuId: genTable.parentMenuId
          };
          updateGenTable(genTable).then(res => {
            this.$modal.msgSuccess(res.msg);
            if (res.code === 200) {
              this.close();
            }
          });
        } else {
          this.$modal.msgError("form validation failed, please recheck and resubmit the content");
        }
      });
    },
    getFormPromise(form) {
      return new Promise(resolve => {
        form.validate(res => {
          resolve(res);
        });
      });
    },
    close() {
      const obj = { path: "/tool/gen", query: { t: Date.now(), pageNum: this.$route.query.pageNum } };
      this.$tab.closeOpenPage(obj);
    }
  },
  mounted() {
    const el = this.$refs.dragTable.$el.querySelectorAll(".el-table__body-wrapper > table > tbody")[0];
    const sortable = Sortable.create(el, {
      handle: ".allowDrag",
      onEnd: evt => {
        const targetRow = this.columns.splice(evt.oldIndex, 1)[0];
        this.columns.splice(evt.newIndex, 0, targetRow);
        for (let index in this.columns) {
          this.columns[index].sort = parseInt(index) + 1;
        }
      }
    });
  }
};
</script>
