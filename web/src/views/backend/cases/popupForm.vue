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
                        :label="t('cases.case_uuid')"
                        type="string"
                        v-model="baTable.form.items!.case_uuid"
                        prop="case_uuid"
                        :placeholder="t('Please input field', { field: t('cases.case_uuid') })"
                    />
                    <FormItem
                        :label="t('cases.ref_user_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.ref_user_id"
                        prop="ref_user_id"
                        :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }"
                        :placeholder="t('Please select field', { field: t('cases.ref_user_id') })"
                    />
                    <FormItem
                        :label="t('cases.enterprise_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.enterprise_id"
                        prop="enterprise_id"
                        :input-attr="{ pk: 'enterprise.id', field: 'title', remoteUrl: '/admin/Enterprise/index' }"
                        :placeholder="t('Please select field', { field: t('cases.enterprise_id') })"
                    />
                    <FormItem
                        :label="t('cases.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('cases.lang_key') })"
                    />
                    <FormItem
                        :label="t('cases.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('cases.title') })"
                    />
                    <FormItem
                        :label="t('cases.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('cases.slug') })"
                    />
                    <FormItem
                        :label="t('cases.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('cases.content') })"
                    />
                    <FormItem
                        :label="t('cases.introduction')"
                        type="textarea"
                        v-model="baTable.form.items!.introduction"
                        prop="introduction"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('cases.introduction') })"
                    />
                    <FormItem
                        :label="t('cases.category')"
                        type="string"
                        v-model="baTable.form.items!.category"
                        prop="category"
                        :placeholder="t('Please input field', { field: t('cases.category') })"
                    />
                    <FormItem
                        :label="t('cases.tags')"
                        type="string"
                        v-model="baTable.form.items!.tags"
                        prop="tags"
                        :placeholder="t('Please input field', { field: t('cases.tags') })"
                    />
                    <FormItem
                        :label="t('cases.thumbnail')"
                        type="string"
                        v-model="baTable.form.items!.thumbnail"
                        prop="thumbnail"
                        :placeholder="t('Please input field', { field: t('cases.thumbnail') })"
                    />
                    <FormItem :label="t('cases.images')" type="images" v-model="baTable.form.items!.images" prop="images" />
                    <FormItem
                        :label="t('cases.meta_title')"
                        type="string"
                        v-model="baTable.form.items!.meta_title"
                        prop="meta_title"
                        :placeholder="t('Please input field', { field: t('cases.meta_title') })"
                    />
                    <FormItem
                        :label="t('cases.meta_description')"
                        type="string"
                        v-model="baTable.form.items!.meta_description"
                        prop="meta_description"
                        :placeholder="t('Please input field', { field: t('cases.meta_description') })"
                    />
                    <FormItem
                        :label="t('cases.meta_keywords')"
                        type="string"
                        v-model="baTable.form.items!.meta_keywords"
                        prop="meta_keywords"
                        :placeholder="t('Please input field', { field: t('cases.meta_keywords') })"
                    />
                    <FormItem
                        :label="t('cases.view_count')"
                        type="number"
                        v-model="baTable.form.items!.view_count"
                        prop="view_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('cases.view_count') })"
                    />
                    <FormItem
                        :label="t('cases.like_count')"
                        type="number"
                        v-model="baTable.form.items!.like_count"
                        prop="like_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('cases.like_count') })"
                    />
                    <FormItem
                        :label="t('cases.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('cases.active_status 0'), '1': t('cases.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('cases.active_status') })"
                    />
                    <FormItem
                        :label="t('cases.featured_status')"
                        type="radio"
                        v-model="baTable.form.items!.featured_status"
                        prop="featured_status"
                        :input-attr="{ content: { '0': t('cases.featured_status 0'), '1': t('cases.featured_status 1') } }"
                        :placeholder="t('Please select field', { field: t('cases.featured_status') })"
                    />
                    <FormItem
                        :label="t('cases.top_status')"
                        type="radio"
                        v-model="baTable.form.items!.top_status"
                        prop="top_status"
                        :input-attr="{ content: { '0': t('cases.top_status 0'), '1': t('cases.top_status 1') } }"
                        :placeholder="t('Please select field', { field: t('cases.top_status') })"
                    />
                    <FormItem
                        :label="t('cases.weight')"
                        type="number"
                        v-model="baTable.form.items!.weight"
                        prop="weight"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('cases.weight') })"
                    />
                    <FormItem
                        :label="t('cases.client_name')"
                        type="string"
                        v-model="baTable.form.items!.client_name"
                        prop="client_name"
                        :placeholder="t('Please input field', { field: t('cases.client_name') })"
                    />
                    <FormItem
                        :label="t('cases.project_date')"
                        type="date"
                        v-model="baTable.form.items!.project_date"
                        prop="project_date"
                        :placeholder="t('Please select field', { field: t('cases.project_date') })"
                    />
                    <FormItem
                        :label="t('cases.project_url')"
                        type="string"
                        v-model="baTable.form.items!.project_url"
                        prop="project_url"
                        :placeholder="t('Please input field', { field: t('cases.project_url') })"
                    />
                    <FormItem
                        :label="t('cases.published_at')"
                        type="number"
                        v-model="baTable.form.items!.published_at"
                        prop="published_at"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('cases.published_at') })"
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
    content: [buildValidatorData({ name: 'editorRequired', title: t('cases.content') })],
    view_count: [buildValidatorData({ name: 'number', title: t('cases.view_count') })],
    like_count: [buildValidatorData({ name: 'number', title: t('cases.like_count') })],
    active_status: [buildValidatorData({ name: 'required', title: t('cases.active_status') })],
    featured_status: [buildValidatorData({ name: 'required', title: t('cases.featured_status') })],
    top_status: [buildValidatorData({ name: 'required', title: t('cases.top_status') })],
    weight: [buildValidatorData({ name: 'number', title: t('cases.weight') })],
    project_date: [buildValidatorData({ name: 'date', title: t('cases.project_date') })],
    published_at: [buildValidatorData({ name: 'number', title: t('cases.published_at') })],
    update_time: [buildValidatorData({ name: 'date', title: t('cases.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('cases.create_time') })],
})
</script>

<style scoped lang="scss"></style>
