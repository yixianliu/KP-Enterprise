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
                        :label="t('ai.invoke.log.log_uuid')"
                        type="string"
                        v-model="baTable.form.items!.log_uuid"
                        prop="log_uuid"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.log_uuid') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.model_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.model_id"
                        prop="model_id"
                        :input-attr="{ pk: 'manager.id', field: 'name', remoteUrl: '/admin/ai.Manager/index' }"
                        :placeholder="t('Please select field', { field: t('ai.invoke.log.model_id') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.ref_user_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.ref_user_id"
                        prop="ref_user_id"
                        :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }"
                        :placeholder="t('Please select field', { field: t('ai.invoke.log.ref_user_id') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.prompt')"
                        type="textarea"
                        v-model="baTable.form.items!.prompt"
                        prop="prompt"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.prompt') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.response')"
                        type="textarea"
                        v-model="baTable.form.items!.response"
                        prop="response"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.response') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.tokens_used')"
                        type="number"
                        v-model="baTable.form.items!.tokens_used"
                        prop="tokens_used"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.tokens_used') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.cost')"
                        type="number"
                        v-model="baTable.form.items!.cost"
                        prop="cost"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.cost') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.duration')"
                        type="number"
                        v-model="baTable.form.items!.duration"
                        prop="duration"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.duration') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{
                            content: {
                                success: t('ai.invoke.log.status success'),
                                failed: t('ai.invoke.log.status failed'),
                                timeout: t('ai.invoke.log.status timeout'),
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('ai.invoke.log.status') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.error_message')"
                        type="textarea"
                        v-model="baTable.form.items!.error_message"
                        prop="error_message"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.error_message') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.ip')"
                        type="string"
                        v-model="baTable.form.items!.ip"
                        prop="ip"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.ip') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.user_agent')"
                        type="string"
                        v-model="baTable.form.items!.user_agent"
                        prop="user_agent"
                        :placeholder="t('Please input field', { field: t('ai.invoke.log.user_agent') })"
                    />
                    <FormItem
                        :label="t('ai.invoke.log.metadata')"
                        type="select"
                        v-model="baTable.form.items!.metadata"
                        prop="metadata"
                        :input-attr="{ content: {} }"
                        :placeholder="t('Please select field', { field: t('ai.invoke.log.metadata') })"
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
    tokens_used: [buildValidatorData({ name: 'number', title: t('ai.invoke.log.tokens_used') })],
    cost: [buildValidatorData({ name: 'number', title: t('ai.invoke.log.cost') })],
    duration: [buildValidatorData({ name: 'number', title: t('ai.invoke.log.duration') })],
    status: [buildValidatorData({ name: 'required', title: t('ai.invoke.log.status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('ai.invoke.log.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('ai.invoke.log.create_time') })],
})
</script>

<style scoped lang="scss"></style>
