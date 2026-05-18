<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog class="ba-operate-dialog" :close-on-click-modal="false" :model-value="['Add', 'Edit'].includes(baTable.form.operate!)" @close="baTable.toggleForm" width="70%">
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate ? t(baTable.form.operate) : '' }}
            </div>
        </template>
        <el-scrollbar v-loading="baTable.form.loading" class="ba-table-form-scrollbar">
            <div class="ba-operate-form" :class="'ba-' + baTable.form.operate + '-form'" :style="config.layout.shrink ? '' : 'width: calc(100% - ' + baTable.form.labelWidth! / 2 + 'px)'">
                <el-form v-if="!baTable.form.loading" ref="formRef" @submit.prevent="" @keyup.enter="baTable.onSubmit(formRef)" :model="baTable.form.items" :label-position="config.layout.shrink ? 'top' : 'right'" :label-width="baTable.form.labelWidth + 'px'" :rules="rules">
                    <FormItem :label="t('enterprise.lang_key')" type="string" v-model="baTable.form.items!.lang_key" prop="lang_key" :placeholder="t('Please input field', { field: t('enterprise.lang_key') })" />
                    <FormItem :label="t('enterprise.title')" type="string" v-model="baTable.form.items!.title" prop="title" :placeholder="t('Please input field', { field: t('enterprise.title') })" />
                    <FormItem :label="t('enterprise.slug')" type="string" v-model="baTable.form.items!.slug" prop="slug" :placeholder="t('Please input field', { field: t('enterprise.slug') })" />
                    <FormItem :label="t('enterprise.content')" type="editor" v-model="baTable.form.items!.content" prop="content" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('enterprise.content') })" />
                    <FormItem :label="t('enterprise.purpose')" type="textarea" v-model="baTable.form.items!.purpose" prop="purpose" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('enterprise.purpose') })" />
                    <FormItem :label="t('enterprise.develop')" type="textarea" v-model="baTable.form.items!.develop" prop="develop" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('enterprise.develop') })" />
                    <FormItem :label="t('enterprise.description')" type="textarea" v-model="baTable.form.items!.description" prop="description" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('enterprise.description') })" />
                    <FormItem :label="t('enterprise.logo')" type="string" v-model="baTable.form.items!.logo" prop="logo" :placeholder="t('Please input field', { field: t('enterprise.logo') })" />
                    <FormItem :label="t('enterprise.images')" type="images" v-model="baTable.form.items!.images" prop="images" />
                    <FormItem :label="t('enterprise.phone')" type="string" v-model="baTable.form.items!.phone" prop="phone" :placeholder="t('Please input field', { field: t('enterprise.phone') })" />
                    <FormItem :label="t('enterprise.email')" type="string" v-model="baTable.form.items!.email" prop="email" :placeholder="t('Please input field', { field: t('enterprise.email') })" />
                    <FormItem :label="t('enterprise.website')" type="string" v-model="baTable.form.items!.website" prop="website" :placeholder="t('Please input field', { field: t('enterprise.website') })" />
                    <FormItem :label="t('enterprise.address')" type="textarea" v-model="baTable.form.items!.address" prop="address" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('enterprise.address') })" />
                    <FormItem :label="t('enterprise.metadata')" type="select" v-model="baTable.form.items!.metadata" prop="metadata" :input-attr="{ content: {} }" :placeholder="t('Please select field', { field: t('enterprise.metadata') })" />
                    <FormItem :label="t('enterprise.active_status')" type="radio" v-model="baTable.form.items!.active_status" prop="active_status" :input-attr="{ content: { '0': t('enterprise.active_status 0'), '1': t('enterprise.active_status 1') } }" :placeholder="t('Please select field', { field: t('enterprise.active_status') })" />
                    <FormItem :label="t('enterprise.featured_status')" type="radio" v-model="baTable.form.items!.featured_status" prop="featured_status" :input-attr="{ content: { '0': t('enterprise.featured_status 0'), '1': t('enterprise.featured_status 1') } }" :placeholder="t('Please select field', { field: t('enterprise.featured_status') })" />
                    <FormItem :label="t('enterprise.weigh')" type="number" v-model="baTable.form.items!.weigh" prop="weigh" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('enterprise.weigh') })" />
                    <FormItem :label="t('enterprise.view_count')" type="number" v-model="baTable.form.items!.view_count" prop="view_count" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('enterprise.view_count') })" />
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
    title: [buildValidatorData({ name: 'required', title: t('enterprise.title') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('enterprise.content') })],
    active_status: [buildValidatorData({ name: 'required', title: t('enterprise.active_status') })],
    featured_status: [buildValidatorData({ name: 'required', title: t('enterprise.featured_status') })],
    view_count: [buildValidatorData({ name: 'number', title: t('enterprise.view_count') })],
    update_time: [buildValidatorData({ name: 'date', title: t('enterprise.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('enterprise.create_time') })],
})
</script>

<style scoped lang="scss"></style>
