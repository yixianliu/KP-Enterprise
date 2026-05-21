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
                        :label="t('post.categories.parent_id')"
                        type="number"
                        v-model="baTable.form.items!.parent_id"
                        prop="parent_id"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.categories.parent_id') })"
                    />
                    <FormItem
                        :label="t('post.categories.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('post.categories.lang_key') })"
                    />
                    <FormItem
                        :label="t('post.categories.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('post.categories.title') })"
                    />
                    <FormItem
                        :label="t('post.categories.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('post.categories.slug') })"
                    />
                    <FormItem
                        :label="t('post.categories.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('post.categories.content') })"
                    />
                    <FormItem
                        :label="t('post.categories.weigh')"
                        type="number"
                        v-model="baTable.form.items!.weigh"
                        prop="weigh"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.categories.weigh') })"
                    />
                    <FormItem
                        :label="t('post.categories.post_count')"
                        type="number"
                        v-model="baTable.form.items!.post_count"
                        prop="post_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.categories.post_count') })"
                    />
                    <FormItem
                        :label="t('post.categories.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{ content: { '0': t('post.categories.status 0'), '1': t('post.categories.status 1') } }"
                        :placeholder="t('Please select field', { field: t('post.categories.status') })"
                    />
                    <FormItem
                        :label="t('post.categories.meta_data')"
                        type="select"
                        v-model="baTable.form.items!.meta_data"
                        prop="meta_data"
                        :input-attr="{ content: {} }"
                        :placeholder="t('Please select field', { field: t('post.categories.meta_data') })"
                    />
                    <FormItem
                        :label="t('post.categories.deleted_time')"
                        type="number"
                        v-model="baTable.form.items!.deleted_time"
                        prop="deleted_time"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.categories.deleted_time') })"
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
    title: [buildValidatorData({ name: 'required', title: t('post.categories.title') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('post.categories.content') })],
    post_count: [buildValidatorData({ name: 'number', title: t('post.categories.post_count') })],
    status: [buildValidatorData({ name: 'required', title: t('post.categories.status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('post.categories.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('post.categories.create_time') })],
    deleted_time: [buildValidatorData({ name: 'number', title: t('post.categories.deleted_time') })],
})
</script>

<style scoped lang="scss"></style>