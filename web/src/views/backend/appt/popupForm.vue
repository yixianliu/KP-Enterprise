<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
        width="70%"
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
                        :label="t('appt.appt_uuid')"
                        type="string"
                        v-model="baTable.form.items!.appt_uuid"
                        prop="appt_uuid"
                        :placeholder="t('Please input field', { field: t('appt.appt_uuid') })"
                    />
                    <FormItem
                        :label="t('appt.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('appt.name') })"
                    />
                    <FormItem
                        :label="t('appt.tel_phone')"
                        type="string"
                        v-model="baTable.form.items!.tel_phone"
                        prop="tel_phone"
                        :placeholder="t('Please input field', { field: t('appt.tel_phone') })"
                    />
                    <FormItem
                        :label="t('appt.email')"
                        type="string"
                        v-model="baTable.form.items!.email"
                        prop="email"
                        :placeholder="t('Please input field', { field: t('appt.email') })"
                    />
                    <FormItem
                        :label="t('appt.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('appt.content') })"
                    />
                    <FormItem
                        :label="t('appt.login_ip')"
                        type="string"
                        v-model="baTable.form.items!.login_ip"
                        prop="login_ip"
                        :placeholder="t('Please input field', { field: t('appt.login_ip') })"
                    />
                    <FormItem
                        :label="t('appt.read_status')"
                        type="radio"
                        v-model="baTable.form.items!.read_status"
                        prop="read_status"
                        :input-attr="{ content: { '0': t('appt.read_status 0'), '1': t('appt.read_status 1') } }"
                        :placeholder="t('Please select field', { field: t('appt.read_status') })"
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
    name: [buildValidatorData({ name: 'required', title: t('appt.name') })],
    tel_phone: [buildValidatorData({ name: 'required', title: t('appt.tel_phone') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('appt.content') })],
    read_status: [buildValidatorData({ name: 'required', title: t('appt.read_status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('appt.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('appt.create_time') })],
})
</script>

<style scoped lang="scss"></style>
