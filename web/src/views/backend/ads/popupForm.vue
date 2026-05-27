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
                        :label="t('ads.ad_uuid')"
                        type="string"
                        v-model="baTable.form.items!.ad_uuid"
                        prop="ad_uuid"
                        :placeholder="t('Please input field', { field: t('ads.ad_uuid') })"
                    />
                    <FormItem
                        :label="t('ads.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('ads.title') })"
                    />
                    <FormItem
                        :label="t('ads.description')"
                        type="textarea"
                        v-model="baTable.form.items!.description"
                        prop="description"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('ads.description') })"
                    />
                    <FormItem
                        :label="t('ads.content')"
                        type="string"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        :placeholder="t('Please input field', { field: t('ads.content') })"
                    />
                    <FormItem :label="t('ads.image')" type="image" v-model="baTable.form.items!.image" prop="image" />
                    <FormItem
                        :label="t('ads.link_url')"
                        type="string"
                        v-model="baTable.form.items!.link_url"
                        prop="link_url"
                        :placeholder="t('Please input field', { field: t('ads.link_url') })"
                    />
                    <FormItem
                        :label="t('ads.link_target')"
                        type="string"
                        v-model="baTable.form.items!.link_target"
                        prop="link_target"
                        :placeholder="t('Please input field', { field: t('ads.link_target') })"
                    />
                    <FormItem
                        :label="t('ads.position')"
                        type="radio"
                        v-model="baTable.form.items!.position"
                        prop="position"
                        :input-attr="{
                            content: {
                                header: 'position header',
                                sidebar: 'position sidebar',
                                footer: 'position footer',
                                content: 'position content',
                                popup: 'position popup',
                                banner: 'position banner',
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('ads.position') })"
                    />
                    <FormItem
                        :label="t('ads.weight')"
                        type="number"
                        v-model="baTable.form.items!.weight"
                        prop="weight"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ads.weight') })"
                    />
                    <FormItem
                        :label="t('ads.start_time')"
                        type="number"
                        v-model="baTable.form.items!.start_time"
                        prop="start_time"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ads.start_time') })"
                    />
                    <FormItem
                        :label="t('ads.end_time')"
                        type="number"
                        v-model="baTable.form.items!.end_time"
                        prop="end_time"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ads.end_time') })"
                    />
                    <FormItem
                        :label="t('ads.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('ads.active_status 0'), '1': t('ads.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('ads.active_status') })"
                    />
                    <FormItem
                        :label="t('ads.view_count')"
                        type="number"
                        v-model="baTable.form.items!.view_count"
                        prop="view_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ads.view_count') })"
                    />
                    <FormItem
                        :label="t('ads.click_count')"
                        type="number"
                        v-model="baTable.form.items!.click_count"
                        prop="click_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('ads.click_count') })"
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
    title: [buildValidatorData({ name: 'required', title: t('ads.title') })],
    weight: [buildValidatorData({ name: 'number', title: t('ads.weight') })],
    start_time: [buildValidatorData({ name: 'number', title: t('ads.start_time') })],
    end_time: [buildValidatorData({ name: 'number', title: t('ads.end_time') })],
    active_status: [buildValidatorData({ name: 'required', title: t('ads.active_status') })],
    view_count: [buildValidatorData({ name: 'number', title: t('ads.view_count') })],
    click_count: [buildValidatorData({ name: 'number', title: t('ads.click_count') })],
    update_time: [buildValidatorData({ name: 'date', title: t('ads.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('ads.create_time') })],
})
</script>

<style scoped lang="scss"></style>
