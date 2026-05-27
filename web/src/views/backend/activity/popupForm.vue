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
                        :label="t('activity.activity_uuid')"
                        type="string"
                        v-model="baTable.form.items!.activity_uuid"
                        prop="activity_uuid"
                        :placeholder="t('Please input field', { field: t('activity.activity_uuid') })"
                    />
                    <FormItem
                        :label="t('activity.ref_user_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.ref_user_id"
                        prop="ref_user_id"
                        :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }"
                        :placeholder="t('Please select field', { field: t('activity.ref_user_id') })"
                    />
                    <FormItem
                        :label="t('activity.enterprise_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.enterprise_id"
                        prop="enterprise_id"
                        :input-attr="{ pk: 'enterprise.id', field: 'title', remoteUrl: '/admin/Enterprise/index' }"
                        :placeholder="t('Please select field', { field: t('activity.enterprise_id') })"
                    />
                    <FormItem
                        :label="t('activity.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('activity.lang_key') })"
                    />
                    <FormItem
                        :label="t('activity.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('activity.title') })"
                    />
                    <FormItem
                        :label="t('activity.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('activity.slug') })"
                    />
                    <FormItem
                        :label="t('activity.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('activity.content') })"
                    />
                    <FormItem
                        :label="t('activity.introduction')"
                        type="textarea"
                        v-model="baTable.form.items!.introduction"
                        prop="introduction"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('activity.introduction') })"
                    />
                    <FormItem
                        :label="t('activity.location')"
                        type="string"
                        v-model="baTable.form.items!.location"
                        prop="location"
                        :placeholder="t('Please input field', { field: t('activity.location') })"
                    />
                    <FormItem
                        :label="t('activity.organizer')"
                        type="textarea"
                        v-model="baTable.form.items!.organizer"
                        prop="organizer"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('activity.organizer') })"
                    />
                    <FormItem
                        :label="t('activity.sponsor')"
                        type="textarea"
                        v-model="baTable.form.items!.sponsor"
                        prop="sponsor"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('activity.sponsor') })"
                    />
                    <FormItem
                        :label="t('activity.start_date')"
                        type="datetime"
                        v-model="baTable.form.items!.start_date"
                        prop="start_date"
                        :placeholder="t('Please select field', { field: t('activity.start_date') })"
                    />
                    <FormItem
                        :label="t('activity.end_date')"
                        type="datetime"
                        v-model="baTable.form.items!.end_date"
                        prop="end_date"
                        :placeholder="t('Please select field', { field: t('activity.end_date') })"
                    />
                    <FormItem
                        :label="t('activity.registration_deadline')"
                        type="datetime"
                        v-model="baTable.form.items!.registration_deadline"
                        prop="registration_deadline"
                        :placeholder="t('Please select field', { field: t('activity.registration_deadline') })"
                    />
                    <FormItem
                        :label="t('activity.max_participants')"
                        type="number"
                        v-model="baTable.form.items!.max_participants"
                        prop="max_participants"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.max_participants') })"
                    />
                    <FormItem
                        :label="t('activity.participant_count')"
                        type="number"
                        v-model="baTable.form.items!.participant_count"
                        prop="participant_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.participant_count') })"
                    />
                    <FormItem
                        :label="t('activity.price')"
                        type="number"
                        v-model="baTable.form.items!.price"
                        prop="price"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.price') })"
                    />
                    <FormItem
                        :label="t('activity.thumbnail')"
                        type="string"
                        v-model="baTable.form.items!.thumbnail"
                        prop="thumbnail"
                        :placeholder="t('Please input field', { field: t('activity.thumbnail') })"
                    />
                    <FormItem :label="t('activity.images')" type="images" v-model="baTable.form.items!.images" prop="images" />
                    <FormItem
                        :label="t('activity.ref_product')"
                        type="string"
                        v-model="baTable.form.items!.ref_product"
                        prop="ref_product"
                        :placeholder="t('Please input field', { field: t('activity.ref_product') })"
                    />
                    <FormItem
                        :label="t('activity.meta_data')"
                        type="select"
                        v-model="baTable.form.items!.meta_data"
                        prop="meta_data"
                        :input-attr="{ content: {} }"
                        :placeholder="t('Please select field', { field: t('activity.meta_data') })"
                    />
                    <FormItem
                        :label="t('activity.meta_title')"
                        type="string"
                        v-model="baTable.form.items!.meta_title"
                        prop="meta_title"
                        :placeholder="t('Please input field', { field: t('activity.meta_title') })"
                    />
                    <FormItem
                        :label="t('activity.meta_description')"
                        type="string"
                        v-model="baTable.form.items!.meta_description"
                        prop="meta_description"
                        :placeholder="t('Please input field', { field: t('activity.meta_description') })"
                    />
                    <FormItem
                        :label="t('activity.meta_keywords')"
                        type="string"
                        v-model="baTable.form.items!.meta_keywords"
                        prop="meta_keywords"
                        :placeholder="t('Please input field', { field: t('activity.meta_keywords') })"
                    />
                    <FormItem
                        :label="t('activity.view_count')"
                        type="number"
                        v-model="baTable.form.items!.view_count"
                        prop="view_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.view_count') })"
                    />
                    <FormItem
                        :label="t('activity.like_count')"
                        type="number"
                        v-model="baTable.form.items!.like_count"
                        prop="like_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.like_count') })"
                    />
                    <FormItem
                        :label="t('activity.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('activity.active_status 0'), '1': t('activity.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('activity.active_status') })"
                    />
                    <FormItem
                        :label="t('activity.featured_status')"
                        type="radio"
                        v-model="baTable.form.items!.featured_status"
                        prop="featured_status"
                        :input-attr="{ content: { '0': t('activity.featured_status 0'), '1': t('activity.featured_status 1') } }"
                        :placeholder="t('Please select field', { field: t('activity.featured_status') })"
                    />
                    <FormItem
                        :label="t('activity.public_status')"
                        type="radio"
                        v-model="baTable.form.items!.public_status"
                        prop="public_status"
                        :input-attr="{ content: { '0': t('activity.public_status 0'), '1': t('activity.public_status 1') } }"
                        :placeholder="t('Please select field', { field: t('activity.public_status') })"
                    />
                    <FormItem
                        :label="t('activity.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{
                            content: {
                                draft: t('activity.status draft'),
                                published: t('activity.status published'),
                                ongoing: t('activity.status ongoing'),
                                completed: t('activity.status completed'),
                                cancelled: t('activity.status cancelled'),
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('activity.status') })"
                    />
                    <FormItem
                        :label="t('activity.weigh')"
                        type="number"
                        v-model="baTable.form.items!.weigh"
                        prop="weigh"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.weigh') })"
                    />
                    <FormItem
                        :label="t('activity.published_at')"
                        type="number"
                        v-model="baTable.form.items!.published_at"
                        prop="published_at"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('activity.published_at') })"
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
    title: [buildValidatorData({ name: 'required', title: t('activity.title') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('activity.content') })],
    start_date: [buildValidatorData({ name: 'date', title: t('activity.start_date') })],
    end_date: [buildValidatorData({ name: 'date', title: t('activity.end_date') })],
    registration_deadline: [buildValidatorData({ name: 'date', title: t('activity.registration_deadline') })],
    max_participants: [buildValidatorData({ name: 'number', title: t('activity.max_participants') })],
    participant_count: [buildValidatorData({ name: 'number', title: t('activity.participant_count') })],
    price: [buildValidatorData({ name: 'number', title: t('activity.price') })],
    view_count: [buildValidatorData({ name: 'number', title: t('activity.view_count') })],
    like_count: [buildValidatorData({ name: 'number', title: t('activity.like_count') })],
    active_status: [buildValidatorData({ name: 'required', title: t('activity.active_status') })],
    featured_status: [buildValidatorData({ name: 'required', title: t('activity.featured_status') })],
    public_status: [buildValidatorData({ name: 'required', title: t('activity.public_status') })],
    status: [buildValidatorData({ name: 'required', title: t('activity.status') })],
    published_at: [buildValidatorData({ name: 'number', title: t('activity.published_at') })],
    update_time: [buildValidatorData({ name: 'date', title: t('activity.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('activity.create_time') })],
})
</script>

<style scoped lang="scss"></style>
