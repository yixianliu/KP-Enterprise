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
                        :label="t('post.posts.post_uuid')"
                        type="string"
                        v-model="baTable.form.items!.post_uuid"
                        prop="post_uuid"
                        :placeholder="t('Please input field', { field: t('post.posts.post_uuid') })"
                    />
                    <FormItem
                        :label="t('post.posts.ref_user_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.ref_user_id"
                        prop="ref_user_id"
                        :input-attr="{ pk: 'admin.id', field: 'username', remoteUrl: '/admin/auth.Admin/index' }"
                        :placeholder="t('Please select field', { field: t('post.posts.ref_user_id') })"
                    />
                    <FormItem
                        :label="t('post.posts.category_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.category_id"
                        prop="category_id"
                        :input-attr="{ pk: 'categories.id', field: 'name', remoteUrl: '/admin/post.Categories/index' }"
                        :placeholder="t('Please select field', { field: t('post.posts.category_id') })"
                    />
                    <FormItem
                        :label="t('post.posts.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('post.posts.lang_key') })"
                    />
                    <FormItem
                        :label="t('post.posts.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('post.posts.title') })"
                    />
                    <FormItem
                        :label="t('post.posts.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('post.posts.slug') })"
                    />
                    <FormItem
                        :label="t('post.posts.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('post.posts.content') })"
                    />
                    <FormItem
                        :label="t('post.posts.summary')"
                        type="textarea"
                        v-model="baTable.form.items!.summary"
                        prop="summary"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('post.posts.summary') })"
                    />
                    <FormItem
                        :label="t('post.posts.thumbnail')"
                        type="string"
                        v-model="baTable.form.items!.thumbnail"
                        prop="thumbnail"
                        :placeholder="t('Please input field', { field: t('post.posts.thumbnail') })"
                    />
                    <FormItem
                        :label="t('post.posts.tags')"
                        type="string"
                        v-model="baTable.form.items!.tags"
                        prop="tags"
                        :placeholder="t('Please input field', { field: t('post.posts.tags') })"
                    />
                    <FormItem
                        :label="t('post.posts.view_count')"
                        type="number"
                        v-model="baTable.form.items!.view_count"
                        prop="view_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.posts.view_count') })"
                    />
                    <FormItem
                        :label="t('post.posts.comment_count')"
                        type="number"
                        v-model="baTable.form.items!.comment_count"
                        prop="comment_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.posts.comment_count') })"
                    />
                    <FormItem
                        :label="t('post.posts.like_count')"
                        type="number"
                        v-model="baTable.form.items!.like_count"
                        prop="like_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.posts.like_count') })"
                    />
                    <FormItem
                        :label="t('post.posts.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('post.posts.active_status 0'), '1': t('post.posts.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('post.posts.active_status') })"
                    />
                    <FormItem
                        :label="t('post.posts.featured_status')"
                        type="radio"
                        v-model="baTable.form.items!.featured_status"
                        prop="featured_status"
                        :input-attr="{ content: { '0': t('post.posts.featured_status 0'), '1': t('post.posts.featured_status 1') } }"
                        :placeholder="t('Please select field', { field: t('post.posts.featured_status') })"
                    />
                    <FormItem
                        :label="t('post.posts.top_status')"
                        type="radio"
                        v-model="baTable.form.items!.top_status"
                        prop="top_status"
                        :input-attr="{ content: { '0': t('post.posts.top_status 0'), '1': t('post.posts.top_status 1') } }"
                        :placeholder="t('Please select field', { field: t('post.posts.top_status') })"
                    />
                    <FormItem
                        :label="t('post.posts.allow_comment')"
                        type="radio"
                        v-model="baTable.form.items!.allow_comment"
                        prop="allow_comment"
                        :input-attr="{ content: { '0': t('post.posts.allow_comment 0'), '1': t('post.posts.allow_comment 1') } }"
                        :placeholder="t('Please select field', { field: t('post.posts.allow_comment') })"
                    />
                    <FormItem
                        :label="t('post.posts.password')"
                        type="string"
                        v-model="baTable.form.items!.password"
                        prop="password"
                        :placeholder="t('Please input field', { field: t('post.posts.password') })"
                    />
                    <FormItem
                        :label="t('post.posts.meta_title')"
                        type="string"
                        v-model="baTable.form.items!.meta_title"
                        prop="meta_title"
                        :placeholder="t('Please input field', { field: t('post.posts.meta_title') })"
                    />
                    <FormItem
                        :label="t('post.posts.meta_description')"
                        type="string"
                        v-model="baTable.form.items!.meta_description"
                        prop="meta_description"
                        :placeholder="t('Please input field', { field: t('post.posts.meta_description') })"
                    />
                    <FormItem
                        :label="t('post.posts.meta_keywords')"
                        type="string"
                        v-model="baTable.form.items!.meta_keywords"
                        prop="meta_keywords"
                        :placeholder="t('Please input field', { field: t('post.posts.meta_keywords') })"
                    />
                    <FormItem
                        :label="t('post.posts.published_at')"
                        type="number"
                        v-model="baTable.form.items!.published_at"
                        prop="published_at"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.posts.published_at') })"
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
    title: [buildValidatorData({ name: 'required', title: t('post.posts.title') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('post.posts.content') })],
    view_count: [buildValidatorData({ name: 'number', title: t('post.posts.view_count') })],
    comment_count: [buildValidatorData({ name: 'number', title: t('post.posts.comment_count') })],
    like_count: [buildValidatorData({ name: 'number', title: t('post.posts.like_count') })],
    active_status: [buildValidatorData({ name: 'required', title: t('post.posts.active_status') })],
    featured_status: [buildValidatorData({ name: 'required', title: t('post.posts.featured_status') })],
    top_status: [buildValidatorData({ name: 'required', title: t('post.posts.top_status') })],
    allow_comment: [buildValidatorData({ name: 'required', title: t('post.posts.allow_comment') })],
    published_at: [buildValidatorData({ name: 'number', title: t('post.posts.published_at') })],
    update_time: [buildValidatorData({ name: 'date', title: t('post.posts.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('post.posts.create_time') })],
})
</script>

<style scoped lang="scss"></style>
