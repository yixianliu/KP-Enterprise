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
                        :label="t('ai.manager.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('ai.manager.name') })"
                    />
                    <FormItem
                        :label="t('ai.manager.type')"
                        type="radio"
                        v-model="baTable.form.items!.type"
                        prop="type"
                        :input-attr="{
                            content: {
                                text_generation: t('ai.manager.type text_generation'),
                                image_generation: t('ai.manager.type image_generation'),
                                speech_recognition: t('ai.manager.type speech_recognition'),
                                speech_synthesis: t('ai.manager.type speech_synthesis'),
                                translation: t('ai.manager.type translation'),
                                code_generation: t('ai.manager.type code_generation'),
                                embedding: t('ai.manager.type embedding'),
                                chat_completion: t('ai.manager.type chat_completion'),
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('ai.manager.type') })"
                    />
                    <FormItem
                        :label="t('ai.manager.provider')"
                        type="string"
                        v-model="baTable.form.items!.provider"
                        prop="provider"
                        :placeholder="t('Please input field', { field: t('ai.manager.provider') })"
                    />
                    <FormItem
                        :label="t('ai.manager.version')"
                        type="string"
                        v-model="baTable.form.items!.version"
                        prop="version"
                        :placeholder="t('Please input field', { field: t('ai.manager.version') })"
                    />
                    <FormItem
                        :label="t('ai.manager.api_key')"
                        type="string"
                        v-model="baTable.form.items!.api_key"
                        prop="api_key"
                        :placeholder="t('Please input field', { field: t('ai.manager.api_key') })"
                    />
                    <FormItem
                        :label="t('ai.manager.base_url')"
                        type="string"
                        v-model="baTable.form.items!.base_url"
                        prop="base_url"
                        :placeholder="t('Please input field', { field: t('ai.manager.base_url') })"
                    />
                    <FormItem
                        :label="t('ai.manager.parameters')"
                        type="string"
                        v-model="baTable.form.items!.parameters"
                        prop="parameters"
                        :placeholder="t('Please input field', { field: t('ai.manager.parameters') })"
                    />
                    <FormItem
                        :label="t('ai.manager.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{ content: { '0': t('ai.manager.status 0'), '1': t('ai.manager.status 1') } }"
                        :placeholder="t('Please select field', { field: t('ai.manager.status') })"
                    />
                    <FormItem
                        :label="t('ai.manager.description')"
                        type="textarea"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ai.manager.description') })"
                    />
                    <FormItem
                        :label="t('ai.manager.max_tokens')"
                        type="number"
                        v-model="baTable.form.items!.max_tokens"
                        prop="max_tokens"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.manager.max_tokens') })"
                    />
                    <FormItem
                        :label="t('ai.manager.price_per_token')"
                        type="number"
                        v-model="baTable.form.items!.price_per_token"
                        prop="price_per_token"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.manager.price_per_token') })"
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
    name: [buildValidatorData({ name: 'required', title: t('ai.manager.name') })],
    status: [buildValidatorData({ name: 'required', title: t('ai.manager.status') })],
    max_tokens: [buildValidatorData({ name: 'number', title: t('ai.manager.max_tokens') })],
    price_per_token: [buildValidatorData({ name: 'number', title: t('ai.manager.price_per_token') })],
    update_time: [buildValidatorData({ name: 'date', title: t('ai.manager.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('ai.manager.create_time') })],
})
</script>

<style scoped lang="scss"></style>