<template>
  <el-form ref="form" :model="user" :rules="rules" label-width="80px">
    <el-form-item label="old password" prop="oldPassword">
      <el-input v-model="user.oldPassword" placeholder="please enter old password" type="password" show-password/>
    </el-form-item>
    <el-form-item label="new password" prop="newPassword">
      <el-input v-model="user.newPassword" placeholder="please enter new password" type="password" show-password/>
    </el-form-item>
    <el-form-item label="confirm password" prop="confirmPassword">
      <el-input v-model="user.confirmPassword" placeholder="please confirm password" type="password" show-password/>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" size="mini" @click="submit">save</el-button>
      <el-button type="danger" size="mini" @click="close">close</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { updateUserPwd } from "@/api/system/user";

export default {
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.user.newPassword !== value) {
        callback(new Error("password does not match"));
      } else {
        callback();
      }
    };
    return {
      user: {
        oldPassword: undefined,
        newPassword: undefined,
        confirmPassword: undefined
      },
      rules: {
        oldPassword: [
          { required: true, message: "old password can not be empty", trigger: "blur" }
        ],
        newPassword: [
          { required: true, message: "new password can not be empty", trigger: "blur" },
          { min: 6, max: 20, message: "length has to be between 6 ad 20 characters", trigger: "blur" }
        ],
        confirmPassword: [
          { required: true, message: "confirm password can not be empty", trigger: "blur" },
          { required: true, validator: equalToPassword, trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    submit() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          updateUserPwd(this.user.oldPassword, this.user.newPassword).then(response => {
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
