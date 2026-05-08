<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('announce.quick Search Fields') })"
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
    name: 'announce',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Announce/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('announce.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            {
                label: t('announce.announce_uuid'),
                prop: 'announce_uuid',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('announce.admin_id'),
                prop: 'admin_id',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('announce.admin__username'),
                prop: 'admin.username',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            {
                label: t('announce.lang_key'),
                prop: 'lang_key',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('announce.title'), prop: 'title', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            { label: t('announce.slug'), prop: 'slug', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            {
                label: t('announce.type'),
                prop: 'type',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: {
                    system: 'type system',
                    maintenance: 'type maintenance',
                    feature: 'type feature',
                    security: 'type security',
                    general: 'type general',
                },
            },
            {
                label: t('announce.priority'),
                prop: 'priority',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { low: 'priority low', normal: 'priority normal', high: 'priority high', urgent: 'priority urgent' },
            },
            {
                label: t('announce.active_status'),
                prop: 'active_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('announce.active_status 0'), '1': t('announce.active_status 1') },
            },
            {
                label: t('announce.pinned_status'),
                prop: 'pinned_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('announce.pinned_status 0'), '1': t('announce.pinned_status 1') },
            },
            {
                label: t('announce.popup_status'),
                prop: 'popup_status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('announce.popup_status 0'), '1': t('announce.popup_status 1') },
            },
            { label: t('announce.weight'), prop: 'weight', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('announce.published_at'), prop: 'published_at', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('announce.expires_at'), prop: 'expires_at', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('announce.view_count'), prop: 'view_count', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('announce.update_time'),
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
                label: t('announce.create_time'),
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
        defaultItems: {
            lang_key: 'zh_CN',
            content: '',
            type: 'general',
            priority: 'normal',
            active_status: '1',
            pinned_status: '0',
            popup_status: '0',
        },
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
