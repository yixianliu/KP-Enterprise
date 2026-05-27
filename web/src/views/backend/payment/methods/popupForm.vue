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
                        :label="t('payment.methods.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('payment.methods.name') })"
                    />
                    <FormItem
                        :label="t('payment.methods.code')"
                        type="string"
                        v-model="baTable.form.items!.code"
                        prop="code"
                        :placeholder="t('Please input field', { field: t('payment.methods.code') })"
                    />
                    <FormItem
                        :label="t('payment.methods.type')"
                        type="radio"
                        v-model="baTable.form.items!.type"
                        prop="type"
                        :input-attr="{ content: { online: 'type online', offline: 'type offline', bank: 'type bank' } }"
                        :placeholder="t('Please select field', { field: t('payment.methods.type') })"
                    />
                    <FormItem
                        :label="t('payment.methods.icon')"
                        type="icon"
                        v-model="baTable.form.items!.icon"
                        prop="icon"
                        :input-attr="{ placement: 'top' }"
                        :placeholder="t('Please select field', { field: t('payment.methods.icon') })"
                    />
                    <FormItem
                        :label="t('payment.methods.description')"
                        type="string"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :placeholder="t('Please input field', { field: t('payment.methods.description') })"
                    />
                    <FormItem
                        :label="t('payment.methods.config')"
                        type="string"
                        v-model="baTable.form.items!.config"
                        prop="config"
                        :placeholder="t('Please input field', { field: t('payment.methods.config') })"
                    />
                    <FormItem
                        :label="t('payment.methods.sort_order')"
                        type="number"
                        v-model="baTable.form.items!.sort_order"
                        prop="sort_order"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('payment.methods.sort_order') })"
                    />
                    <FormItem
                        :label="t('payment.methods.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('payment.methods.active_status 0'), '1': t('payment.methods.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('payment.methods.active_status') })"
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
    name: [buildValidatorData({ name: 'required', title: t('payment.methods.name') })],
    code: [buildValidatorData({ name: 'required', title: t('payment.methods.code') })],
    sort_order: [buildValidatorData({ name: 'number', title: t('payment.methods.sort_order') })],
    active_status: [buildValidatorData({ name: 'required', title: t('payment.methods.active_status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('payment.methods.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('payment.methods.create_time') })],
})
</script>

<style scoped lang="scss"></style>
