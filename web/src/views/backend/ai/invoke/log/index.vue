<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('ai.invoke.log.quick Search Fields') })"
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
    name: 'ai/invoke/log',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/ai.invoke.Log/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            {
                label: t('ai.invoke.log.model__name'),
                prop: 'model.name',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
                width: 360,
            },
            {
                label: t('ai.invoke.log.refuser__username'),
                prop: 'refUser.username',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
                comSearchRender: 'string',
            },
            { label: t('ai.invoke.log.tokens_used'), prop: 'tokens_used', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('ai.invoke.log.cost'), prop: 'cost', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('ai.invoke.log.duration'), prop: 'duration', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('ai.invoke.log.status'),
                prop: 'status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: {
                    success: t('ai.invoke.log.status success'),
                    failed: t('ai.invoke.log.status failed'),
                    timeout: t('ai.invoke.log.status timeout'),
                },
            },
            { label: t('ai.invoke.log.ip'), prop: 'ip', align: 'center', operatorPlaceholder: t('Fuzzy query'), sortable: false, operator: 'LIKE' },
            {
                label: t('ai.invoke.log.user_agent'),
                prop: 'user_agent',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            { label: t('ai.invoke.log.metadata'), prop: 'metadata', align: 'center', operator: 'eq', sortable: false, width: 300 },
            {
                label: t('ai.invoke.log.update_time'),
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
                label: t('ai.invoke.log.create_time'),
                prop: 'create_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                comSearchRender: 'datetime',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            { label: t('Operate'), align: 'center', width: 140, render: 'buttons', buttons: optButtons, operator: false, fixed: 'right' },
        ],
        dblClickNotEditColumn: [undefined],
    },
    {
        defaultItems: {},
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