<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="job name" prop="jobName">
        <el-input
          v-model="queryParams.jobName"
          placeholder="please enter job name"
          clearable
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="job group name" prop="jobGroup">
        <el-select
          v-model="queryParams.jobGroup"
          placeholder="please select job group name"
          clearable
          style="width: 240px"
        >
          <el-option
            v-for="dict in dict.type.sys_job_group"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="execution status" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="please select execution status"
          clearable
          style="width: 240px"
        >
          <el-option
            v-for="dict in dict.type.sys_common_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="execution time">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="start date"
          end-placeholder="end date"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">search</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">reset</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['monitor:job:remove']"
        >delete</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          @click="handleClean"
          v-hasPermi="['monitor:job:remove']"
        >clear</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['monitor:job:export']"
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

    <el-table v-loading="loading" :data="jobLogList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="log id" width="80" align="center" prop="jobLogId" />
      <el-table-column label="job name" align="center" prop="jobName" :show-overflow-tooltip="true" />
      <el-table-column label="job group name" align="center" prop="jobGroup" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_job_group" :value="scope.row.jobGroup"/>
        </template>
      </el-table-column>
      <el-table-column label="invoke target string" align="center" prop="invokeTarget" :show-overflow-tooltip="true" />
      <el-table-column label="log information" align="center" prop="jobMessage" :show-overflow-tooltip="true" />
      <el-table-column label="execution status" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_common_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="execution time" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="operation" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
            v-hasPermi="['monitor:job:query']"
          >detail</el-button>
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

    <el-dialog title="scheduling log details" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" label-width="100px" size="mini">
        <el-row>
          <el-col :span="12">
            <el-form-item label="log number:">{{ form.jobLogId }}</el-form-item>
            <el-form-item label="job name:">{{ form.jobName }}</el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="job group:">{{ form.jobGroup }}</el-form-item>
            <el-form-item label="execution time:">{{ form.createTime }}</el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="invoke method:">{{ form.invokeTarget }}</el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="log information:">{{ form.jobMessage }}</el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="execution status:">
              <div v-if="form.status == 0">normal</div>
              <div v-else-if="form.status == 1">failed</div>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="exception information:" v-if="form.status == 1">{{ form.exceptionInfo }}</el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="open = false">close</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getJob} from "@/api/monitor/job";
import { listJobLog, delJobLog, cleanJobLog } from "@/api/monitor/jobLog";

export default {
  name: "JobLog",
  dicts: ['sys_common_status', 'sys_job_group'],
  data() {
    return {
      loading: true,
      ids: [],
      multiple: true,
      showSearch: true,
      total: 0,
      jobLogList: [],
      open: false,
      dateRange: [],
      form: {},
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        jobName: undefined,
        jobGroup: undefined,
        status: undefined
      }
    };
  },
  created() {
    const jobId = this.$route.query.jobId;
    if (jobId !== undefined && jobId != 0) {
      getJob(jobId).then(response => {
        this.queryParams.jobName = response.data.jobName;
        this.queryParams.jobGroup = response.data.jobGroup;
        this.getList();
      });
    } else {
      this.getList();
    }
  },
  methods: {
    getList() {
      this.loading = true;
      listJobLog(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
          this.jobLogList = response.rows;
          this.total = response.total;
          this.loading = false;
        }
      );
    },
    handleClose() {
      const obj = { path: "/monitor/job" };
      this.$tab.closeOpenPage(obj);
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.jobLogId);
      this.multiple = !selection.length;
    },
    handleView(row) {
      this.open = true;
      this.form = row;
    },
    handleDelete(row) {
      const jobLogIds = this.ids;
      this.$modal.confirm('sure delete job log id"' + jobLogIds + '"data?').then(function() {
        return delJobLog(jobLogIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("delete success");
      }).catch(() => {});
    },
    handleClean() {
      this.$modal.confirm('sure clear all job log data?').then(function() {
        return cleanJobLog();
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("clear success");
      }).catch(() => {});
    },
    handleExport() {
      this.download('/monitor/jobLog/export', {
        ...this.queryParams
      }, `log_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
