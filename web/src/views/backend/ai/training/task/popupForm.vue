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
                        :label="t('ai.training.task.task_uuid')"
                        type="string"
                        v-model="baTable.form.items!.task_uuid"
                        prop="task_uuid"
                        :placeholder="t('Please input field', { field: t('ai.training.task.task_uuid') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.model_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.model_id"
                        prop="model_id"
                        :input-attr="{ pk: 'manager.id', field: 'name', remoteUrl: '/admin/ai.Manager/index' }"
                        :placeholder="t('Please select field', { field: t('ai.training.task.model_id') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.name')"
                        type="string"
                        v-model="baTable.form.items!.name"
                        prop="name"
                        :placeholder="t('Please input field', { field: t('ai.training.task.name') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.description')"
                        type="textarea"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ai.training.task.description') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.training_data')"
                        type="select"
                        v-model="baTable.form.items!.training_data"
                        prop="training_data"
                        :input-attr="{ content: {} }"
                        :placeholder="t('Please select field', { field: t('ai.training.task.training_data') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.hyperparameters')"
                        type="string"
                        v-model="baTable.form.items!.hyperparameters"
                        prop="hyperparameters"
                        :placeholder="t('Please input field', { field: t('ai.training.task.hyperparameters') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{
                            content: {
                                pending: t('ai.training.task.status pending'),
                                running: t('ai.training.task.status running'),
                                finished: t('ai.training.task.status finished'),
                                failed: t('ai.training.task.status failed'),
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('ai.training.task.status') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.progress')"
                        type="number"
                        v-model="baTable.form.items!.progress"
                        prop="progress"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.training.task.progress') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.epoch')"
                        type="number"
                        v-model="baTable.form.items!.epoch"
                        prop="epoch"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.training.task.epoch') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.loss')"
                        type="number"
                        v-model="baTable.form.items!.loss"
                        prop="loss"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.training.task.loss') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.accuracy')"
                        type="number"
                        v-model="baTable.form.items!.accuracy"
                        prop="accuracy"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.training.task.accuracy') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.start_time')"
                        type="number"
                        v-model="baTable.form.items!.start_time"
                        prop="start_time"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.training.task.start_time') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.end_time')"
                        type="number"
                        v-model="baTable.form.items!.end_time"
                        prop="end_time"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ai.training.task.end_time') })"
                    />
                    <FormItem
                        :label="t('ai.training.task.error_message')"
                        type="textarea"
                        v-model="baTable.form.items!.error_message"
                        prop="error_message"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ai.training.task.error_message') })"
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
    name: [buildValidatorData({ name: 'required', title: t('ai.training.task.name') })],
    status: [buildValidatorData({ name: 'required', title: t('ai.training.task.status') })],
    progress: [buildValidatorData({ name: 'number', title: t('ai.training.task.progress') })],
    epoch: [buildValidatorData({ name: 'number', title: t('ai.training.task.epoch') })],
    loss: [buildValidatorData({ name: 'number', title: t('ai.training.task.loss') })],
    accuracy: [buildValidatorData({ name: 'number', title: t('ai.training.task.accuracy') })],
    start_time: [buildValidatorData({ name: 'number', title: t('ai.training.task.start_time') })],
    end_time: [buildValidatorData({ name: 'number', title: t('ai.training.task.end_time') })],
    update_time: [buildValidatorData({ name: 'date', title: t('ai.training.task.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('ai.training.task.create_time') })],
})
</script>

<style scoped lang="scss"></style>
