<template>
  <el-form ref="basicInfoForm" :model="info" :rules="rules" label-width="150px">
    <el-row>
      <el-col :span="12">
        <el-form-item label="table name" prop="tableName">
          <el-input placeholder="please input the warehouse name" v-model="info.tableName" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="table comment" prop="tableComment">
          <el-input placeholder="please input" v-model="info.tableComment" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="entity class name" prop="className">
          <el-input placeholder="please input" v-model="info.className" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="author" prop="functionAuthor">
          <el-input placeholder="please input" v-model="info.functionAuthor" />
        </el-form-item>
      </el-col>
      <el-col :span="24">
        <el-form-item label="remarks" prop="remark">
          <el-input type="textarea" :rows="3" v-model="info.remark"></el-input>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
export default {
  props: {
    info: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      rules: {
        tableName: [
          { required: true, message: "please input the table name", trigger: "blur" }
        ],
        tableComment: [
          { required: true, message: "please input the table comment", trigger: "blur" }
        ],
        className: [
          { required: true, message: "please input the entity class name", trigger: "blur" }
        ],
        functionAuthor: [
          { required: true, message: "please input the author", trigger: "blur" }
        ]
      }
    };
  }
};
</script>
