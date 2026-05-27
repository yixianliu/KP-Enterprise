<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('ads.quick Search Fields') })"
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
    name: 'ads',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Ads/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('ads.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            { label: t('ads.ad_uuid'), prop: 'ad_uuid', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            { label: t('ads.title'), prop: 'title', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            { label: t('ads.content'), prop: 'content', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            { label: t('ads.image'), prop: 'image', align: 'center', render: 'image', operator: false },
            { label: t('ads.link_url'), prop: 'link_url', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            {
                label: t('ads.link_target'),
                prop: 'link_target',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('ads.position'),
                prop: 'position',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: {
                    header: 'position header',
                    sidebar: 'position sidebar',
                    footer: 'position footer',
                    content: 'position content',
                    popup: 'position popup',
                    banner: 'position banner',
                },
            },
            { label: t('ads.weight'), prop: 'weight', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('ads.start_time'), prop: 'start_time', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('ads.end_time'), prop: 'end_time', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('ads.active_status'),
                prop: 'active_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('ads.active_status 0'), '1': t('ads.active_status 1') },
            },
            { label: t('ads.view_count'), prop: 'view_count', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('ads.click_count'), prop: 'click_count', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('ads.update_time'),
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
                label: t('ads.create_time'),
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
        defaultItems: { link_target: '_blank', active_status: '1' },
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
