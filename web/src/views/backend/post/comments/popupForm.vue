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
                        :label="t('post.comments.post_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.post_id"
                        prop="post_id"
                        :input-attr="{ pk: 'posts.id', field: 'title', remoteUrl: '/admin/post.Posts/index' }"
                        :placeholder="t('Please select field', { field: t('post.comments.post_id') })"
                    />
                    <FormItem
                        :label="t('post.comments.user_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.user_id"
                        prop="user_id"
                        :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }"
                        :placeholder="t('Please select field', { field: t('post.comments.user_id') })"
                    />
                    <FormItem
                        :label="t('post.comments.parent_id')"
                        type="string"
                        v-model="baTable.form.items!.parent_id"
                        prop="parent_id"
                        :placeholder="t('Please input field', { field: t('post.comments.parent_id') })"
                    />
                    <FormItem
                        :label="t('post.comments.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('post.comments.content') })"
                    />
                    <FormItem
                        :label="t('post.comments.status')"
                        type="radio"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{
                            content: {
                                pending: t('post.comments.status pending'),
                                approved: t('post.comments.status approved'),
                                rejected: t('post.comments.status rejected'),
                            },
                        }"
                        :placeholder="t('Please select field', { field: t('post.comments.status') })"
                    />
                    <FormItem
                        :label="t('post.comments.like_count')"
                        type="number"
                        v-model="baTable.form.items!.like_count"
                        prop="like_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('post.comments.like_count') })"
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
    content: [buildValidatorData({ name: 'editorRequired', title: t('post.comments.content') })],
    status: [buildValidatorData({ name: 'required', title: t('post.comments.status') })],
    like_count: [buildValidatorData({ name: 'number', title: t('post.comments.like_count') })],
    update_time: [buildValidatorData({ name: 'date', title: t('post.comments.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('post.comments.create_time') })],
})
</script>

<style scoped lang="scss"></style>
