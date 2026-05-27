<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('post.posts.quick Search Fields') })"
        ></TableHeader>

        <!-- 表格 -->
        <!-- 表格列有多种自定义渲染方式，比如自定义组件、具名插槽等，参见文档 -->
        <!-- 要使用 el-table 组件原有的属性，直接加在 Table 标签上即可 -->
        <Table ref="tableRef"></Table>

        <!-- 表单 -->
        <PopupForm />
    </div>
</template>

<script setup lang="ts">
import { onMounted, provide, useTemplateRef } from 'vue'
import { useI18n } from 'vue-i18n'
import PopupForm from './popupForm.vue'
import { baTableApi } from '/@/api/common'
import { defaultOptButtons } from '/@/components/table'
import TableHeader from '/@/components/table/header/index.vue'
import Table from '/@/components/table/index.vue'
import baTableClass from '/@/utils/baTable'

defineOptions({
    name: 'post/posts',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/post.Posts/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('post.posts.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            {
                label: t('post.posts.post_uuid'),
                prop: 'post_uuid',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('post.posts.ref_user_id'),
                prop: 'ref_user_id',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('post.posts.refuser__username'),
                prop: 'refUser.username',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('post.posts.category_id'),
                prop: 'category_id',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('post.posts.category__name'),
                prop: 'category.name',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('post.posts.lang_key'),
                prop: 'lang_key',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('post.posts.title'),
                prop: 'title',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('post.posts.slug'), prop: 'slug', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            {
                label: t('post.posts.thumbnail'),
                prop: 'thumbnail',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('post.posts.tags'), prop: 'tags', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            { label: t('post.posts.view_count'), prop: 'view_count', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('post.posts.comment_count'), prop: 'comment_count', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('post.posts.like_count'), prop: 'like_count', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('post.posts.active_status'),
                prop: 'active_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('post.posts.active_status 0'), '1': t('post.posts.active_status 1') },
            },
            {
                label: t('post.posts.featured_status'),
                prop: 'featured_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('post.posts.featured_status 0'), '1': t('post.posts.featured_status 1') },
            },
            {
                label: t('post.posts.top_status'),
                prop: 'top_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('post.posts.top_status 0'), '1': t('post.posts.top_status 1') },
            },
            {
                label: t('post.posts.allow_comment'),
                prop: 'allow_comment',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('post.posts.allow_comment 0'), '1': t('post.posts.allow_comment 1') },
            },
            {
                label: t('post.posts.password'),
                prop: 'password',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('post.posts.meta_title'),
                prop: 'meta_title',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('post.posts.meta_description'),
                prop: 'meta_description',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('post.posts.meta_keywords'),
                prop: 'meta_keywords',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('post.posts.published_at'), prop: 'published_at', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('post.posts.update_time'),
                prop: 'update_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            {
                label: t('post.posts.create_time'),
                prop: 'create_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            { label: t('Operate'), align: 'center', width: 100, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined],
    },
    {
        defaultItems: { lang_key: 'zh_CN', content: '', active_status: '1', featured_status: '0', top_status: '0', allow_comment: '1' },
    }
)

provide('baTable', baTable)

onMounted(() => {
    baTable.table.ref = tableRef.value
    baTable.mount()
    baTable.getData()?.then(() => {
        baTable.initSort()
        baTable.dragSort()
    })
})
</script>

<style scoped lang="scss"></style>
