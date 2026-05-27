<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('activity.quick Search Fields') })"
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
    name: 'activity',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['weigh-sort', 'edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Activity/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            {
                label: t('activity.ref_user_id'),
                prop: 'ref_user_id',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('activity.refuser__username'),
                prop: 'refUser.username',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('activity.enterprise_id'),
                prop: 'enterprise_id',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('activity.enterprise__title'),
                prop: 'enterprise.title',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('activity.lang_key'),
                prop: 'lang_key',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('activity.title'), prop: 'title', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            { label: t('activity.slug'), prop: 'slug', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            {
                label: t('activity.location'),
                prop: 'location',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('activity.start_date'),
                prop: 'start_date',
                align: 'center',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
            },
            {
                label: t('activity.end_date'),
                prop: 'end_date',
                align: 'center',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
            },
            {
                label: t('activity.registration_deadline'),
                prop: 'registration_deadline',
                align: 'center',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
            },
            { label: t('activity.max_participants'), prop: 'max_participants', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('activity.participant_count'), prop: 'participant_count', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('activity.price'), prop: 'price', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('activity.thumbnail'),
                prop: 'thumbnail',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('activity.images'), prop: 'images', align: 'center', render: 'images', operator: false },
            {
                label: t('activity.ref_product'),
                prop: 'ref_product',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('activity.meta_data'), prop: 'meta_data', align: 'center', operator: 'eq', sortable: false, render: 'tag' },
            {
                label: t('activity.meta_title'),
                prop: 'meta_title',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('activity.meta_description'),
                prop: 'meta_description',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('activity.meta_keywords'),
                prop: 'meta_keywords',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('activity.view_count'), prop: 'view_count', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('activity.like_count'), prop: 'like_count', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('activity.active_status'),
                prop: 'active_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('activity.active_status 0'), '1': t('activity.active_status 1') },
            },
            {
                label: t('activity.featured_status'),
                prop: 'featured_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('activity.featured_status 0'), '1': t('activity.featured_status 1') },
            },
            {
                label: t('activity.public_status'),
                prop: 'public_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('activity.public_status 0'), '1': t('activity.public_status 1') },
            },
            {
                label: t('activity.status'),
                prop: 'status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: {
                    draft: t('activity.status draft'),
                    published: t('activity.status published'),
                    ongoing: t('activity.status ongoing'),
                    completed: t('activity.status completed'),
                    cancelled: t('activity.status cancelled'),
                },
            },
            { label: t('activity.weigh'), prop: 'weigh', align: 'center', operator: 'RANGE', sortable: 'custom' },
            { label: t('activity.published_at'), prop: 'published_at', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('activity.update_time'),
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
                label: t('activity.create_time'),
                prop: 'create_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            { label: t('Operate'), align: 'center', width: 140, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined],
        defaultOrder: { prop: 'weigh', order: 'desc' },
    },
    {
        defaultItems: { lang_key: 'zh_CN', content: '', active_status: '1', featured_status: '0', public_status: '1', status: 'draft' },
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