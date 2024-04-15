<template>
  <el-form ref="form" :model="user" :rules="rules" label-width="80px">
    <el-form-item label="user name" prop="nickName">
      <el-input v-model="user.nickName" maxlength="30" />
    </el-form-item> 
    <el-form-item label="phone number" prop="phonenumber">
      <el-input v-model="user.phonenumber" maxlength="12" />
    </el-form-item>
    <el-form-item label="email" prop="email">
      <el-input v-model="user.email" maxlength="50" />
    </el-form-item>
    <el-form-item label="gender">
      <el-radio-group v-model="user.sex">
        <el-radio label="0">male</el-radio>
        <el-radio label="1">female</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" size="mini" @click="submit">save</el-button>
      <el-button type="danger" size="mini" @click="close">close</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { updateUserProfile } from "@/api/system/user";

export default {
  props: {
    user: {
      type: Object
    }
  },
  data() {
    return {
      rules: {
        nickName: [
          { required: true, message: "user name can not be empty", trigger: "blur" }
        ],
        email: [
          { required: true, message: "email address can not be empty", trigger: "blur" },
          {
            type: "email",
            message: "please enter correct email address",
            trigger: ["blur", "change"]
          }
        ],
        phonenumber: [
          { required: true, message: "phone number can not be empty", trigger: "blur" },
          {
            pattern: /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/,
            message: "please enter correct phone number",
            trigger: "blur"
          }
        ]
      }
    };
  },
  methods: {
    submit() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          updateUserProfile(this.user).then(response => {
            this.$modal.msgSuccess("modify success");
          });
        }
      });
    },
    close() {
      this.$tab.closePage();
    }
  }
};
</script>
