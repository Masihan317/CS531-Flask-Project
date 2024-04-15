<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
      <el-form-item label="login ip" prop="ipaddr">
        <el-input
          v-model="queryParams.ipaddr"
          placeholder="please enter login ip"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="user name" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="please enter user name"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">search</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">reset</el-button>
      </el-form-item>

    </el-form>
    <el-table
      v-loading="loading"
      :data="list.slice((pageNum-1)*pageSize,pageNum*pageSize)"
      style="width: 100%;"
    >
      <el-table-column label="serial number" type="index" align="center">
        <template slot-scope="scope">
          <span>{{(pageNum - 1) * pageSize + scope.$index + 1}}</span>
        </template>
      </el-table-column>
      <el-table-column label="session id" align="center" prop="tokenId" :show-overflow-tooltip="true" />
      <el-table-column label="user name" align="center" prop="userName" :show-overflow-tooltip="true" />
      <el-table-column label="dept name" align="center" prop="deptName" />
      <el-table-column label="host" align="center" prop="ipaddr" :show-overflow-tooltip="true" />
      <el-table-column label="login location" align="center" prop="loginLocation" :show-overflow-tooltip="true" />
      <el-table-column label="browser" align="center" prop="browser" />
      <el-table-column label="os" align="center" prop="os" />
      <el-table-column label="login time" align="center" prop="loginTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.loginTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="operation" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleForceLogout(scope.row)"
            v-hasPermi="['monitor:online:forceLogout']"
          >force logout</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="pageNum" :limit.sync="pageSize" />
  </div>
</template>

<script>
import { list, forceLogout } from "@/api/monitor/online";

export default {
  name: "Online",
  data() {
    return {
      loading: true,
      total: 0,
      list: [],
      pageNum: 1,
      pageSize: 10,
      queryParams: {
        ipaddr: undefined,
        userName: undefined
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      list(this.queryParams).then(response => {
        this.list = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    handleQuery() {
      this.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleForceLogout(row) {
      this.$modal.confirm('sure force logout user"' + row.userName + '"?').then(function() {
        return forceLogout(row.tokenId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("force logout success");
      }).catch(() => {});
    }
  }
};
</script>

