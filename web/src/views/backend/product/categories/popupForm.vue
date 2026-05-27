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
                        :label="t('product.categories.parent_id')"
                        type="string"
                        v-model="baTable.form.items!.parent_id"
                        prop="parent_id"
                        :placeholder="t('Please input field', { field: t('product.categories.parent_id') })"
                    />
                    <FormItem
                        :label="t('product.categories.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('product.categories.name') })"
                    />
                    <FormItem
                        :label="t('product.categories.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('product.categories.slug') })"
                    />
                    <FormItem
                        :label="t('product.categories.description')"
                        type="string"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :placeholder="t('Please input field', { field: t('product.categories.description') })"
                    />
                    <FormItem
                        :label="t('product.categories.icon')"
                        type="icon"
                        v-model="baTable.form.items!.icon"
                        prop="icon"
                        :input-attr="{ placement: 'top' }"
                        :placeholder="t('Please select field', { field: t('product.categories.icon') })"
                    />
                    <FormItem
                        :label="t('product.categories.thumbnail')"
                        type="string"
                        v-model="baTable.form.items!.thumbnail"
                        prop="thumbnail"
                        :placeholder="t('Please input field', { field: t('product.categories.thumbnail') })"
                    />
                    <FormItem
                        :label="t('product.categories.sort_order')"
                        type="number"
                        v-model="baTable.form.items!.sort_order"
                        prop="sort_order"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.categories.sort_order') })"
                    />
                    <FormItem
                        :label="t('product.categories.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('product.categories.active_status 0'), '1': t('product.categories.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.categories.active_status') })"
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
    name: [buildValidatorData({ name: 'required', title: t('product.categories.name') })],
    sort_order: [buildValidatorData({ name: 'number', title: t('product.categories.sort_order') })],
    active_status: [buildValidatorData({ name: 'required', title: t('product.categories.active_status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('product.categories.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('product.categories.create_time') })],
})
</script>

<style scoped lang="scss"></style>