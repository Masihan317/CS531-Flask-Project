<template>
  <el-form ref="genInfoForm" :model="info" :rules="rules" label-width="150px">
    <el-row>
      <el-col :span="12">
        <el-form-item prop="tplCategory">
          <span slot="label">generate template</span>
          <el-select v-model="info.tplCategory" @change="tplSelectChange">
            <el-option label="table(crud)" value="crud" />
            <el-option label="tree(crud)" value="tree" />
            <el-option label="sub-main table(crud)" value="sub" />
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item prop="packageName">
          <span slot="label">
            generate package path
            <el-tooltip content="where to generate java package, such as com.app.system" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.packageName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="moduleName">
          <span slot="label">
            generate module name
            <el-tooltip content="sub-system name, such as system" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.moduleName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="businessName">
          <span slot="label">
            generate part name
            <el-tooltip content="part functional name, such as user" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.businessName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="functionName">
          <span slot="label">
            generate function name
            <el-tooltip content="used to describe class, such as user action" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.functionName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            previous menu
            <el-tooltip content="allocate to certain menu, such as system management" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <treeselect
            :append-to-body="true"
            v-model="info.parentMenuId"
            :options="menus"
            :normalizer="normalizer"
            :show-count="true"
            placeholder="please select system menu"
          />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="genType">
          <span slot="label">
            generate code method
            <el-tooltip content="default zip download, or customized path" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-radio v-model="info.genType" label="0">zip package</el-radio>
          <el-radio v-model="info.genType" label="1">customized path</el-radio>
        </el-form-item>
      </el-col>

      <el-col :span="24" v-if="info.genType == '1'">
        <el-form-item prop="genPath">
          <span slot="label">
            customized path
            <el-tooltip content="input path, otherwise, Web app folder" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.genPath">
            <el-dropdown slot="append">
              <el-button type="primary">
                nearest path quick select
                <i class="el-icon-arrow-down el-icon--right"></i>
              </el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item @click.native="info.genPath = '/'">recover default generate path</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </el-input>
        </el-form-item>
      </el-col>
    </el-row>

    <el-row v-show="info.tplCategory == 'tree'">
      <h4 class="form-header">other info</h4>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            tree encoding field
            <el-tooltip content="the field name of the encoding displayed in the tree, such as: dept_id" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.treeCode" placeholder="please select">
            <el-option
              v-for="(column, index) in info.columns"
              :key="index"
              :label="column.columnName + ':' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            tree parent code field
            <el-tooltip content="the field name of the parent code displayed in the tree, such as: parent_Id" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.treeParentCode" placeholder="please select">
            <el-option
              v-for="(column, index) in info.columns"
              :key="index"
              :label="column.columnName + ':' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            tree name field
            <el-tooltip content="the field name for displaying the tree node name, such as: dept_name" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.treeName" placeholder="please select">
            <el-option
              v-for="(column, index) in info.columns"
              :key="index"
              :label="column.columnName + ':' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
    </el-row>
    <el-row v-show="info.tplCategory == 'sub'">
      <h4 class="form-header">related information</h4>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            sub-table name
            <el-tooltip content="the name of the associated sub-table, such as: sys_user" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.subTableName" placeholder="please select" @change="subSelectChange">
            <el-option
              v-for="(table, index) in tables"
              :key="index"
              :label="table.tableName + ':' + table.tableComment"
              :value="table.tableName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            foreign key name of the sub-table
            <el-tooltip content="the name of the foreign key associated with the sub-table, such as: user_id" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.subTableFkName" placeholder="please select">
            <el-option
              v-for="(column, index) in subColumns"
              :key="index"
              :label="column.columnName + ':' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";

export default {
  components: { Treeselect },
  props: {
    info: {
      type: Object,
      default: null
    },
    tables: {
      type: Array,
      default: null
    },
    menus: {
      type: Array,
      default: []
    },
  },
  data() {
    return {
      subColumns: [],
      rules: {
        tplCategory: [
          { required: true, message: "please select a template to generate", trigger: "blur" }
        ],
        packageName: [
          { required: true, message: "please enter the package path to generate", trigger: "blur" }
        ],
        moduleName: [
          { required: true, message: "please enter the module name to generate", trigger: "blur" }
        ],
        businessName: [
          { required: true, message: "please enter the part name to generate", trigger: "blur" }
        ],
        functionName: [
          { required: true, message: "please enter the function name to generate", trigger: "blur" }
        ],
      }
    };
  },
  created() {},
  watch: {
    'info.subTableName': function(val) {
      this.setSubTableColumns(val);
    }
  },
  methods: {
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children;
      }
      return {
        id: node.menuId,
        label: node.menuName,
        children: node.children
      };
    },
    subSelectChange(value) {
      this.info.subTableFkName = '';
    },
    tplSelectChange(value) {
      if(value !== 'sub') {
        this.info.subTableName = '';
        this.info.subTableFkName = '';
      }
    },
    setSubTableColumns(value) {
      for (var item in this.tables) {
        const name = this.tables[item].tableName;
        if (value === name) {
          this.subColumns = this.tables[item].columns;
          break;
        }
      }
    }
  }
};
</script>
