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
                        :label="t('post.tags.tag_uuid')"
                        type="string"
                        v-model="baTable.form.items!.tag_uuid"
                        prop="tag_uuid"
                        :placeholder="t('Please input field', { field: t('post.tags.tag_uuid') })"
                    />
                    <FormItem
                        :label="t('post.tags.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('post.tags.name') })"
                    />
                    <FormItem
                        :label="t('post.tags.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('post.tags.slug') })"
                    />
                    <FormItem
                        :label="t('post.tags.description')"
                        type="textarea"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('post.tags.description') })"
                    />
                    <FormItem
                        :label="t('post.tags.weigh')"
                        type="number"
                        v-model="baTable.form.items!.weigh"
                        prop="weigh"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.tags.weigh') })"
                    />
                    <FormItem
                        :label="t('post.tags.usage_count')"
                        type="number"
                        v-model="baTable.form.items!.usage_count"
                        prop="usage_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.tags.usage_count') })"
                    />
                    <FormItem
                        :label="t('post.tags.color')"
                        type="color"
                        v-model="baTable.form.items!.color"
                        prop="color"
                        :placeholder="t('Please input field', { field: t('post.tags.color') })"
                    />
                    <FormItem
                        :label="t('post.tags.icon')"
                        type="icon"
                        v-model="baTable.form.items!.icon"
                        prop="icon"
                        :input-attr="{ placement: 'top' }"
                        :placeholder="t('Please select field', { field: t('post.tags.icon') })"
                    />
                    <FormItem
                        :label="t('post.tags.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('post.tags.lang_key') })"
                    />
                    <FormItem
                        :label="t('post.tags.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{ content: { '0': t('post.tags.status 0'), '1': t('post.tags.status 1') } }"
                        :placeholder="t('Please select field', { field: t('post.tags.status') })"
                    />
                    <FormItem
                        :label="t('post.tags.meta_data')"
                        type="select"
                        v-model="baTable.form.items!.meta_data"
                        prop="meta_data"
                        :input-attr="{ content: {} }"
                        :placeholder="t('Please select field', { field: t('post.tags.meta_data') })"
                    />
                    <FormItem
                        :label="t('post.tags.deleted_time')"
                        type="number"
                        v-model="baTable.form.items!.deleted_time"
                        prop="deleted_time"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.tags.deleted_time') })"
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
    name: [buildValidatorData({ name: 'required', title: t('post.tags.name') })],
    usage_count: [buildValidatorData({ name: 'number', title: t('post.tags.usage_count') })],
    status: [buildValidatorData({ name: 'required', title: t('post.tags.status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('post.tags.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('post.tags.create_time') })],
    deleted_time: [buildValidatorData({ name: 'number', title: t('post.tags.deleted_time') })],
})
</script>

<style scoped lang="scss"></style>
