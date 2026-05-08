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
                        :label="t('menu.menu_uuid')"
                        type="string"
                        v-model="baTable.form.items!.menu_uuid"
                        prop="menu_uuid"
                        :placeholder="t('Please input field', { field: t('menu.menu_uuid') })"
                    />
                    <FormItem
                        :label="t('menu.parent_id')"
                        type="number"
                        v-model="baTable.form.items!.parent_id"
                        prop="parent_id"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('menu.parent_id') })"
                    />
                    <FormItem
                        :label="t('menu.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('menu.lang_key') })"
                    />
                    <FormItem
                        :label="t('menu.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('menu.title') })"
                    />
                    <FormItem
                        :label="t('menu.urls')"
                        type="string"
                        v-model="baTable.form.items!.urls"
                        prop="urls"
                        :placeholder="t('Please input field', { field: t('menu.urls') })"
                    />
                    <FormItem
                        :label="t('menu.icon')"
                        type="icon"
                        v-model="baTable.form.items!.icon"
                        prop="icon"
                        :input-attr="{ placement: 'top' }"
                        :placeholder="t('Please select field', { field: t('menu.icon') })"
                    />
                    <FormItem
                        :label="t('menu.description')"
                        type="textarea"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('menu.description') })"
                    />
                    <FormItem
                        :label="t('menu.weigh')"
                        type="number"
                        v-model="baTable.form.items!.weigh"
                        prop="weigh"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('menu.weigh') })"
                    />
                    <FormItem
                        :label="t('menu.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{ content: { '0': t('menu.status 0'), '1': t('menu.status 1') } }"
                        :placeholder="t('Please select field', { field: t('menu.status') })"
                    />
                    <FormItem
                        :label="t('menu.is_visible')"
                        type="radio"
                        v-model="baTable.form.items!.is_visible"
                        prop="is_visible"
                        :input-attr="{ content: { '0': t('menu.is_visible 0'), '1': t('menu.is_visible 1') } }"
                        :placeholder="t('Please select field', { field: t('menu.is_visible') })"
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
    title: [buildValidatorData({ name: 'required', title: t('menu.title') })],
    status: [buildValidatorData({ name: 'required', title: t('menu.status') })],
    is_visible: [buildValidatorData({ name: 'required', title: t('menu.is_visible') })],
    update_time: [buildValidatorData({ name: 'date', title: t('menu.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('menu.create_time') })],
})
</script>

<style scoped lang="scss"></style>
