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
                        :label="t('product.products.product_uuid')"
                        type="string"
                        v-model="baTable.form.items!.product_uuid"
                        prop="product_uuid"
                        :placeholder="t('Please input field', { field: t('product.products.product_uuid') })"
                    />
                    <FormItem
                        :label="t('product.products.category_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.category_id"
                        prop="category_id"
                        :input-attr="{ pk: 'categories.id', field: 'name', remoteUrl: '/admin/product.Categories/index' }"
                        :placeholder="t('Please select field', { field: t('product.products.category_id') })"
                    />
                    <FormItem
                        :label="t('product.products.lang_key')"
                        type="string"
                        v-model="baTable.form.items!.lang_key"
                        prop="lang_key"
                        :placeholder="t('Please input field', { field: t('product.products.lang_key') })"
                    />
                    <FormItem
                        :label="t('product.products.title')"
                        type="string"
                        v-model="baTable.form.items!.title"
                        prop="title"
                        :placeholder="t('Please input field', { field: t('product.products.title') })"
                    />
                    <FormItem
                        :label="t('product.products.slug')"
                        type="string"
                        v-model="baTable.form.items!.slug"
                        prop="slug"
                        :placeholder="t('Please input field', { field: t('product.products.slug') })"
                    />
                    <FormItem
                        :label="t('product.products.content')"
                        type="editor"
                        v-model="baTable.form.items!.content"
                        prop="content"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('product.products.content') })"
                    />
                    <FormItem
                        :label="t('product.products.summary')"
                        type="textarea"
                        v-model="baTable.form.items!.summary"
                        prop="summary"
                        :input-attr="{ rows: 3 }"
                        @keyup.enter.stop=""
                        @keyup.ctrl.enter="baTable.onSubmit(formRef)"
                        :placeholder="t('Please input field', { field: t('product.products.summary') })"
                    />
                    <FormItem
                        :label="t('product.products.thumbnail')"
                        type="string"
                        v-model="baTable.form.items!.thumbnail"
                        prop="thumbnail"
                        :placeholder="t('Please input field', { field: t('product.products.thumbnail') })"
                    />
                    <FormItem :label="t('product.products.images')" type="images" v-model="baTable.form.items!.images" prop="images" />
                    <FormItem
                        :label="t('product.products.tags')"
                        type="string"
                        v-model="baTable.form.items!.tags"
                        prop="tags"
                        :placeholder="t('Please input field', { field: t('product.products.tags') })"
                    />
                    <FormItem
                        :label="t('product.products.price')"
                        type="number"
                        v-model="baTable.form.items!.price"
                        prop="price"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.price') })"
                    />
                    <FormItem
                        :label="t('product.products.original_price')"
                        type="number"
                        v-model="baTable.form.items!.original_price"
                        prop="original_price"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.original_price') })"
                    />
                    <FormItem
                        :label="t('product.products.stock')"
                        type="number"
                        v-model="baTable.form.items!.stock"
                        prop="stock"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.stock') })"
                    />
                    <FormItem
                        :label="t('product.products.sold_count')"
                        type="number"
                        v-model="baTable.form.items!.sold_count"
                        prop="sold_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.sold_count') })"
                    />
                    <FormItem
                        :label="t('product.products.view_count')"
                        type="number"
                        v-model="baTable.form.items!.view_count"
                        prop="view_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.view_count') })"
                    />
                    <FormItem
                        :label="t('product.products.comment_count')"
                        type="number"
                        v-model="baTable.form.items!.comment_count"
                        prop="comment_count"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.comment_count') })"
                    />
                    <FormItem
                        :label="t('product.products.rating')"
                        type="number"
                        v-model="baTable.form.items!.rating"
                        prop="rating"
                        :input-attr="{ step: 1 }"
                        :placeholder="t('Please input field', { field: t('product.products.rating') })"
                    />
                    <FormItem
                        :label="t('product.products.active_status')"
                        type="radio"
                        v-model="baTable.form.items!.active_status"
                        prop="active_status"
                        :input-attr="{ content: { '0': t('product.products.active_status 0'), '1': t('product.products.active_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.products.active_status') })"
                    />
                    <FormItem
                        :label="t('product.products.featured_status')"
                        type="radio"
                        v-model="baTable.form.items!.featured_status"
                        prop="featured_status"
                        :input-attr="{ content: { '0': t('product.products.featured_status 0'), '1': t('product.products.featured_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.products.featured_status') })"
                    />
                    <FormItem
                        :label="t('product.products.hot_status')"
                        type="radio"
                        v-model="baTable.form.items!.hot_status"
                        prop="hot_status"
                        :input-attr="{ content: { '0': t('product.products.hot_status 0'), '1': t('product.products.hot_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.products.hot_status') })"
                    />
                    <FormItem
                        :label="t('product.products.new_status')"
                        type="radio"
                        v-model="baTable.form.items!.new_status"
                        prop="new_status"
                        :input-attr="{ content: { '0': t('product.products.new_status 0'), '1': t('product.products.new_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.products.new_status') })"
                    />
                    <FormItem
                        :label="t('product.products.virtual_status')"
                        type="radio"
                        v-model="baTable.form.items!.virtual_status"
                        prop="virtual_status"
                        :input-attr="{ content: { '0': t('product.products.virtual_status 0'), '1': t('product.products.virtual_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.products.virtual_status') })"
                    />
                    <FormItem
                        :label="t('product.products.download_status')"
                        type="radio"
                        v-model="baTable.form.items!.download_status"
                        prop="download_status"
                        :input-attr="{ content: { '0': t('product.products.download_status 0'), '1': t('product.products.download_status 1') } }"
                        :placeholder="t('Please select field', { field: t('product.products.download_status') })"
                    />
                    <FormItem
                        :label="t('product.products.meta_title')"
                        type="string"
                        v-model="baTable.form.items!.meta_title"
                        prop="meta_title"
                        :placeholder="t('Please input field', { field: t('product.products.meta_title') })"
                    />
                    <FormItem
                        :label="t('product.products.meta_description')"
                        type="string"
                        v-model="baTable.form.items!.meta_description"
                        prop="meta_description"
                        :placeholder="t('Please input field', { field: t('product.products.meta_description') })"
                    />
                    <FormItem
                        :label="t('product.products.meta_keywords')"
                        type="string"
                        v-model="baTable.form.items!.meta_keywords"
                        prop="meta_keywords"
                        :placeholder="t('Please input field', { field: t('product.products.meta_keywords') })"
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
    title: [buildValidatorData({ name: 'required', title: t('product.products.title') })],
    content: [buildValidatorData({ name: 'editorRequired', title: t('product.products.content') })],
    price: [buildValidatorData({ name: 'number', title: t('product.products.price') })],
    original_price: [buildValidatorData({ name: 'number', title: t('product.products.original_price') })],
    stock: [buildValidatorData({ name: 'number', title: t('product.products.stock') })],
    sold_count: [buildValidatorData({ name: 'number', title: t('product.products.sold_count') })],
    view_count: [buildValidatorData({ name: 'number', title: t('product.products.view_count') })],
    comment_count: [buildValidatorData({ name: 'number', title: t('product.products.comment_count') })],
    rating: [buildValidatorData({ name: 'number', title: t('product.products.rating') })],
    active_status: [buildValidatorData({ name: 'required', title: t('product.products.active_status') })],
    featured_status: [buildValidatorData({ name: 'required', title: t('product.products.featured_status') })],
    hot_status: [buildValidatorData({ name: 'required', title: t('product.products.hot_status') })],
    virtual_status: [buildValidatorData({ name: 'required', title: t('product.products.virtual_status') })],
    update_time: [buildValidatorData({ name: 'date', title: t('product.products.update_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('product.products.create_time') })],
})
</script>

<style scoped lang="scss"></style>
