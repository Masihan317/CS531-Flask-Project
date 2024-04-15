<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="dictionary name" prop="dictType">
        <el-select v-model="queryParams.dictType">
          <el-option
            v-for="item in typeOptions"
            :key="item.dictId"
            :label="item.dictName"
            :value="item.dictType"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="dictionary label" prop="dictLabel">
        <el-input
          v-model="queryParams.dictLabel"
          placeholder="please enter dictionary label"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="status" prop="status">
        <el-select v-model="queryParams.status" placeholder="data status" clearable>
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
          v-hasPermi="['system:dict:add']"
        >add</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:dict:edit']"
        >modify</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:dict:remove']"
        >delete</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:dict:export']"
        >export</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-close"
          size="mini"
          @click="handleClose"
        >close</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="dictionary encode" align="center" prop="dictCode" />
      <el-table-column label="dictionary label" align="center" prop="dictLabel">
        <template slot-scope="scope">
          <span v-if="scope.row.listClass == '' || scope.row.listClass == 'default'">{{scope.row.dictLabel}}</span>
          <el-tag v-else :type="scope.row.listClass == 'primary' ? '' : scope.row.listClass">{{scope.row.dictLabel}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="dictionary value" align="center" prop="dictValue" />
      <el-table-column label="dictionary sort" align="center" prop="dictSort" />
      <el-table-column label="status" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="remark" align="center" prop="remark" :show-overflow-tooltip="true" />
      <el-table-column label="time of creation" align="center" prop="createTime" width="180">
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
            v-hasPermi="['system:dict:edit']"
          >modify</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:dict:remove']"
          >delete</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="dictionary type">
          <el-input v-model="form.dictType" :disabled="true" />
        </el-form-item>
        <el-form-item label="dictionary label" prop="dictLabel">
          <el-input v-model="form.dictLabel" placeholder="please enter dictionary label" />
        </el-form-item>
        <el-form-item label="dictionary value" prop="dictValue">
          <el-input v-model="form.dictValue" placeholder="please enter dictionary value" />
        </el-form-item>
        <el-form-item label="css class" prop="cssClass">
          <el-input v-model="form.cssClass" placeholder="please enter css class" />
        </el-form-item>
        <el-form-item label="dictionary sort" prop="dictSort">
          <el-input-number v-model="form.dictSort" controls-position="right" :min="0" />
        </el-form-item>
        <el-form-item label="list class" prop="listClass">
          <el-select v-model="form.listClass">
            <el-option
              v-for="item in listClassOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="status" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in dict.type.sys_normal_disable"
              :key="dict.value"
              :label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="remark" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="please enter content"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">confirm</el-button>
        <el-button @click="cancel">cancel</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listData, getData, delData, addData, updateData } from "@/api/system/dict/data";
import { optionselect as getDictOptionselect, getType } from "@/api/system/dict/type";

export default {
  name: "Data",
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      dataList: [],
      defaultDictType: "",
      title: "",
      open: false,
      listClassOptions: [
        {
          value: "default",
          label: "default"
        },
        {
          value: "primary",
          label: "primary"
        },
        {
          value: "success",
          label: "success"
        },
        {
          value: "info",
          label: "info"
        },
        {
          value: "warning",
          label: "warning"
        },
        {
          value: "danger",
          label: "danger"
        }
      ],
      typeOptions: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        dictName: undefined,
        dictType: undefined,
        status: undefined
      },
      form: {},
      rules: {
        dictLabel: [
          { required: true, message: "dictionary label can not be empty", trigger: "blur" }
        ],
        dictValue: [
          { required: true, message: "dictionary value can not be empty", trigger: "blur" }
        ],
        dictSort: [
          { required: true, message: "dictionary sort can not be empty", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    const dictId = this.$route.params && this.$route.params.dictId;
    this.getType(dictId);
    this.getTypeList();
  },
  methods: {
    getType(dictId) {
      getType(dictId).then(response => {
        this.queryParams.dictType = response.data.dictType;
        this.defaultDictType = response.data.dictType;
        this.getList();
      });
    },
    getTypeList() {
      getDictOptionselect().then(response => {
        this.typeOptions = response.data;
      });
    },
    getList() {
      this.loading = true;
      listData(this.queryParams).then(response => {
        this.dataList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    reset() {
      this.form = {
        dictCode: undefined,
        dictLabel: undefined,
        dictValue: undefined,
        cssClass: undefined,
        listClass: 'default',
        dictSort: 0,
        status: "0",
        remark: undefined
      };
      this.resetForm("form");
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    handleClose() {
      const obj = { path: "/system/dict" };
      this.$tab.closeOpenPage(obj);
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.queryParams.dictType = this.defaultDictType;
      this.handleQuery();
    },
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "add dictionary type";
      this.form.dictType = this.queryParams.dictType;
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.dictCode)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    handleUpdate(row) {
      this.reset();
      const dictCode = row.dictCode || this.ids
      getData(dictCode).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "modify dictionary data";
      });
    },
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.dictCode != undefined) {
            updateData(this.form).then(response => {
              this.$modal.msgSuccess("modify success");
              this.open = false;
              this.getList();
            });
          } else {
            addData(this.form).then(response => {
              this.$modal.msgSuccess("add success");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    handleDelete(row) {
      const dictCodes = row.dictCode || this.ids;
      this.$modal.confirm('sure delete dictionary encode"' + dictCodes + '"data?').then(function() {
        return delData(dictCodes);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("delete success");
      }).catch(() => {});
    },
    handleExport() {
      this.download('system/dict/data/export', {
        ...this.queryParams
      }, `data_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>