<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
    >
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate ? t(baTable.form.operate) : '' }}
            </div>
        </template>
        <el-scrollbar v-loading="baTable.form.loading" class="ba-table-form-scrollbar">
            <div
                class="ba-operate-form"
                :class="'ba-' + baTable.form.operate + '-form'"
                :style="config.layout.shrink ? '' : 'width: calc(100% - ' + baTable.form.labelWidth! / 2 + 'px)'"
            >
                <el-form
                    v-if="!baTable.form.loading"
                    ref="formRef"
                    @submit.prevent=""
                    @keyup.enter="baTable.onSubmit(formRef)"
                    :model="baTable.form.items"
                    :label-position="config.layout.shrink ? 'top' : 'right'"
                    :label-width="baTable.form.labelWidth + 'px'"
                    :rules="rules"
                >
                    <FormItem
                        :label="t('user.ref.address.user_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.user_id"
                        prop="user_id"
                        :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }"
                        :placeholder="t('Please select field', { field: t('user.ref.address.user_id') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('user.ref.address.name') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.phone')"
                        type="string"
                        v-model="baTable.form.items!.phone"
                        prop="phone"
                        :placeholder="t('Please input field', { field: t('user.ref.address.phone') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.province')"
                        type="string"
                        v-model="baTable.form.items!.province"
                        prop="province"
                        :placeholder="t('Please input field', { field: t('user.ref.address.province') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.city')"
                        type="city"
                        v-model="baTable.form.items!.city"
                        prop="city"
                        :placeholder="t('Please select field', { field: t('user.ref.address.city') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.district')"
                        type="string"
                        v-model="baTable.form.items!.district"
                        prop="district"
                        :placeholder="t('Please input field', { field: t('user.ref.address.district') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.address')"
                        type="string"
                        v-model="baTable.form.items!.address"
                        prop="address"
                        :placeholder="t('Please input field', { field: t('user.ref.address.address') })"
                    />
                    <FormItem
                        :label="t('user.ref.address.default_status')"
                        type="radio"
                        v-model="baTable.form.items!.default_status"
                        prop="default_status"
                        :input-attr="{ content: { '0': t('user.ref.address.default_status 0'), '1': t('user.ref.address.default_status 1') } }"
                        :placeholder="t('Please select field', { field: t('user.ref.address.default_status') })"
                    />
                </el-form>
            </div>
        </el-scrollbar>
        <template #footer>
            <div :style="'width: calc(100% - ' + baTable.form.labelWidth! / 1.8 + 'px)'">
                <el-button @click="baTable.toggleForm()">{{ t('Cancel') }}</el-button>
                <el-button v-blur :loading="baTable.form.submitLoading" @click="baTable.onSubmit(formRef)" type="primary">
                    {{ baTable.form.operateIds && baTable.form.operateIds.length > 1 ? t('Save and edit next item') : t('Save') }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script setup lang="ts">
import type { FormItemRule } from 'element-plus'
import { inject, reactive, useTemplateRef } from 'vue'
import { useI18n } from 'vue-i18n'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'

const config = useConfig()
const formRef = useTemplateRef('formRef')
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    name: [buildValidatorData({ name: 'required', title: t('user.ref.address.name') })],
    phone: [buildValidatorData({ name: 'required', title: t('user.ref.address.phone') })],
    address: [buildValidatorData({ name: 'required', title: t('user.ref.address.address') })],
    default_status: [buildValidatorData({ name: 'required', title: t('user.ref.address.default_status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('user.ref.address.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('user.ref.address.create_time') })],
})
</script>

<style scoped lang="scss"></style>
