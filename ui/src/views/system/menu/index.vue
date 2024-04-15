<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="menu name" prop="menuName">
        <el-input
          v-model="queryParams.menuName"
          placeholder="please enter menu name"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="status" prop="status">
        <el-select v-model="queryParams.status" placeholder="menu status" clearable>
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">search</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">reset</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:menu:add']"
        >add</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="el-icon-sort"
          size="mini"
          @click="toggleExpandAll"
        >unfold/fold</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="menuList"
      row-key="menuId"
      :default-expand-all="isExpandAll"
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
    >
      <el-table-column prop="menuName" label="menu name" :show-overflow-tooltip="true" width="160"></el-table-column>
      <el-table-column prop="icon" label="icon" align="center" width="100">
        <template slot-scope="scope">
          <svg-icon :icon-class="scope.row.icon" />
        </template>
      </el-table-column>
      <el-table-column prop="orderNum" label="order number" width="60"></el-table-column>
      <el-table-column prop="perms" label="perm identifier" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="component" label="component path" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="status" label="status" width="80">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="time of creation" align="center" prop="createTime">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="operation" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button 
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:menu:edit']"
          >modify</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-plus"
            @click="handleAdd(scope.row)"
            v-hasPermi="['system:menu:add']"
          >add</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:menu:remove']"
          >delete</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="title" :visible.sync="open" width="680px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="upper menu">
              <treeselect
                v-model="form.parentId"
                :options="menuOptions"
                :normalizer="normalizer"
                :show-count="true"
                placeholder="select upper menu"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="menu type" prop="menuType">
              <el-radio-group v-model="form.menuType">
                <el-radio label="M">Category</el-radio>
                <el-radio label="C">Menu</el-radio>
                <el-radio label="F">Button</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24" v-if="form.menuType != 'F'">
            <el-form-item label="menu icon" prop="icon">
              <el-popover
                placement="bottom-start"
                width="460"
                trigger="click"
                @show="$refs['iconSelect'].reset()"
              >
                <IconSelect ref="iconSelect" @selected="selected" />
                <el-input slot="reference" v-model="form.icon" placeholder="click select icon" readonly>
                  <svg-icon
                    v-if="form.icon"
                    slot="prefix"
                    :icon-class="form.icon"
                    class="el-input__icon"
                    style="height: 32px;width: 16px;"
                  />
                  <i v-else slot="prefix" class="el-icon-search el-input__icon" />
                </el-input>
              </el-popover>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="menu name" prop="menuName">
              <el-input v-model="form.menuName" placeholder="please enter menu name" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="show order number" prop="orderNum">
              <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType != 'F'">
            <el-form-item>
              <span slot="label">
                <el-tooltip content="select external link should start with `http(s)://`" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                external link
              </span>
              <el-radio-group v-model="form.isFrame">
                <el-radio label="0">Yes</el-radio>
                <el-radio label="1">No</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType != 'F'">
            <el-form-item prop="path">
              <span slot="label">
                <el-tooltip content="internal path like `user`" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                route path
              </span>
              <el-input v-model="form.path" placeholder="please enter route path" />
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType == 'C'">
            <el-form-item prop="component">
              <span slot="label">
                <el-tooltip content="component path like `system/user/index`, default under `views`" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                component path
              </span>
              <el-input v-model="form.component" placeholder="please enter component path" />
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType != 'M'">
            <el-form-item>
              <el-input v-model="form.perms" placeholder="please enter perm identifier" maxlength="100" />
              <span slot="label">
                <el-tooltip content="perm identifier like @PreAuthorize(`@ss.hasPermi('system:user:list')`)" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                perm identifier
              </span>
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType == 'C'">
            <el-form-item>
              <el-input v-model="form.query" placeholder="please enter route param" maxlength="255" />
              <span slot="label">
                <el-tooltip content='rooute default param like `{"id": 1, "name": "app"}`' placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                route param
              </span>
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType == 'C'">
            <el-form-item>
              <span slot="label">
                <el-tooltip content="select will be cached by `keep-alive`, matching component `name` and path is required" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                cache
              </span>
              <el-radio-group v-model="form.isCache">
                <el-radio label="0">cache</el-radio>
                <el-radio label="1">no cache</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType != 'F'">
            <el-form-item>
              <span slot="label">
                <el-tooltip content="select hide, route will not show on the side bar, but still accessible" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                show status
              </span>
              <el-radio-group v-model="form.visible">
                <el-radio
                  v-for="dict in dict.type.sys_show_hide"
                  :key="dict.value"
                  :label="dict.value"
                >{{dict.label}}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12" v-if="form.menuType != 'F'">
            <el-form-item>
              <span slot="label">
                <el-tooltip content="select disable, route will not show and not accessible" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                menu status
              </span>
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.sys_normal_disable"
                  :key="dict.value"
                  :label="dict.value"
                >{{dict.label}}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">confirm</el-button>
        <el-button @click="cancel">cancel</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMenu, getMenu, delMenu, addMenu, updateMenu } from "@/api/system/menu";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import IconSelect from "@/components/IconSelect";

export default {
  name: "Menu",
  dicts: ['sys_show_hide', 'sys_normal_disable'],
  components: { Treeselect, IconSelect },
  data() {
    return {
      loading: true,
      showSearch: true,
      menuList: [],
      menuOptions: [],
      title: "",
      open: false,
      isExpandAll: false,
      refreshTable: true,
      queryParams: {
        menuName: undefined,
        visible: undefined
      },
      form: {},
      rules: {
        menuName: [
          { required: true, message: "menu name can not be empty", trigger: "blur" }
        ],
        orderNum: [
          { required: true, message: "menu order can not be empty", trigger: "blur" }
        ],
        path: [
          { required: true, message: "route path can not be empty", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    selected(name) {
      this.form.icon = name;
    },
    getList() {
      this.loading = true;
      listMenu(this.queryParams).then(response => {
        this.menuList = this.handleTree(response.data, "menuId");
        this.loading = false;
      });
    },
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
    getTreeselect() {
      listMenu().then(response => {
        this.menuOptions = [];
        const menu = { menuId: 0, menuName: 'main category', children: [] };
        menu.children = this.handleTree(response.data, "menuId");
        this.menuOptions.push(menu);
      });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    reset() {
      this.form = {
        menuId: undefined,
        parentId: 0,
        menuName: undefined,
        icon: undefined,
        menuType: "M",
        orderNum: undefined,
        isFrame: "1",
        isCache: "0",
        visible: "0",
        status: "0"
      };
      this.resetForm("form");
    },
    handleQuery() {
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleAdd(row) {
      this.reset();
      this.getTreeselect();
      if (row != null && row.menuId) {
        this.form.parentId = row.menuId;
      } else {
        this.form.parentId = 0;
      }
      this.open = true;
      this.title = "add menu";
    },
    toggleExpandAll() {
      this.refreshTable = false;
      this.isExpandAll = !this.isExpandAll;
      this.$nextTick(() => {
        this.refreshTable = true;
      });
    },
    handleUpdate(row) {
      this.reset();
      this.getTreeselect();
      getMenu(row.menuId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "modify menu";
      });
    },
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.menuId != undefined) {
            updateMenu(this.form).then(response => {
              this.$modal.msgSuccess("modify success");
              this.open = false;
              this.getList();
            });
          } else {
            addMenu(this.form).then(response => {
              this.$modal.msgSuccess("add success");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    handleDelete(row) {
      this.$modal.confirm('sure delete menu name"' + row.menuName + '"data?').then(function() {
        return delMenu(row.menuId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("delete success");
      }).catch(() => {});
    }
  }
};
</script>
