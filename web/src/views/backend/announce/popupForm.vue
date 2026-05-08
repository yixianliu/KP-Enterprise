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
                        :label="t('announce.announce_uuid')"
                        type="string"
                        v-model="baTable.form.items!.announce_uuid"
                        prop="announce_uuid"
                        :placeholder="t('Please input field', { field: t('announce.announce_uuid') })"
                    />
                    <FormItem
                        :label="t('announce.admin_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.admin_id"
                        prop="admin_id"
                        :input-attr="{ pk: 'admin.id', field: 'username', remoteUrl: '/admin/auth.Admin/index' }"
                        :placeholder="t('Please select field', { field: t('announce.admin_id') })"
                    />
                    <FormItem
                        :label="t('announce.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('announce.lang_key') })"
                    />
                    <FormItem
                        :label="t('announce.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('announce.title') })"
                    />
                    <FormItem
                        :label="t('announce.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('announce.slug') })"
                    />
                    <FormItem
                        :label="t('announce.summary')"
                        type="textarea"
                        v-model="baTable.form.items!.summary"
                        prop="summary"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('announce.summary') })"
                    />
                    <FormItem
                        :label="t('announce.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('announce.content') })"
                    />
                    <FormItem
                        :label="t('announce.type')"
                        type="radio"
                        v-model="baTable.form.items!.type"
                        prop="type"
                        :input-attr="{
                            content: {
                                system: 'type system',
                                maintenance: 'type maintenance',
                                feature: 'type feature',
                                security: 'type security',
                                general: 'type general',
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('announce.type') })"
                    />
                    <FormItem
                        :label="t('announce.priority')"
                        type="radio"
                        v-model="baTable.form.items!.priority"
                        prop="priority"
                        :input-attr="{
                            content: { low: 'priority low', normal: 'priority normal', high: 'priority high', urgent: 'priority urgent' },
                        }"
                        :placeholder="t('Please select field', { field: t('announce.priority') })"
                    />
                    <FormItem
                        :label="t('announce.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('announce.active_status 0'), '1': t('announce.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('announce.active_status') })"
                    />
                    <FormItem
                        :label="t('announce.pinned_status')"
                        type="radio"
                        v-model="baTable.form.items!.pinned_status"
                        prop="pinned_status"
                        :input-attr="{ content: { '0': t('announce.pinned_status 0'), '1': t('announce.pinned_status 1') } }"
                        :placeholder="t('Please select field', { field: t('announce.pinned_status') })"
                    />
                    <FormItem
                        :label="t('announce.popup_status')"
                        type="radio"
                        v-model="baTable.form.items!.popup_status"
                        prop="popup_status"
                        :input-attr="{ content: { '0': t('announce.popup_status 0'), '1': t('announce.popup_status 1') } }"
                        :placeholder="t('Please select field', { field: t('announce.popup_status') })"
                    />
                    <FormItem
                        :label="t('announce.weight')"
                        type="number"
                        v-model="baTable.form.items!.weight"
                        prop="weight"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('announce.weight') })"
                    />
                    <FormItem
                        :label="t('announce.published_at')"
                        type="number"
                        v-model="baTable.form.items!.published_at"
                        prop="published_at"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('announce.published_at') })"
                    />
                    <FormItem
                        :label="t('announce.expires_at')"
                        type="number"
                        v-model="baTable.form.items!.expires_at"
                        prop="expires_at"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('announce.expires_at') })"
                    />
                    <FormItem
                        :label="t('announce.view_count')"
                        type="number"
                        v-model="baTable.form.items!.view_count"
                        prop="view_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('announce.view_count') })"
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
    title: [buildValidatorData({ name: 'required', title: t('announce.title') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('announce.content') })],
    active_status: [buildValidatorData({ name: 'required', title: t('announce.active_status') })],
    pinned_status: [buildValidatorData({ name: 'required', title: t('announce.pinned_status') })],
    popup_status: [buildValidatorData({ name: 'required', title: t('announce.popup_status') })],
    weight: [buildValidatorData({ name: 'number', title: t('announce.weight') })],
    published_at: [buildValidatorData({ name: 'number', title: t('announce.published_at') })],
    expires_at: [buildValidatorData({ name: 'number', title: t('announce.expires_at') })],
    view_count: [buildValidatorData({ name: 'number', title: t('announce.view_count') })],
    update_time: [buildValidatorData({ name: 'date', title: t('announce.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('announce.create_time') })],
})
</script>

<style scoped lang="scss"></style>
