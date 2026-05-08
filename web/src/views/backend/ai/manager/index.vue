<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('ai.manager.quick Search Fields') })"
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
    name: 'ai/manager',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/ai.Manager/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            {
                label: t('ai.manager.name'),
                prop: 'name',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
                width: 200,
            },
            {
                label: t('ai.manager.type'),
                prop: 'type',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: {
                    text_generation: t('ai.manager.type text_generation'),
                    image_generation: t('ai.manager.type image_generation'),
                    speech_recognition: t('ai.manager.type speech_recognition'),
                    speech_synthesis: t('ai.manager.type speech_synthesis'),
                    translation: t('ai.manager.type translation'),
                    code_generation: t('ai.manager.type code_generation'),
                    embedding: t('ai.manager.type embedding'),
                    chat_completion: t('ai.manager.type chat_completion'),
                },
            },
            {
                label: t('ai.manager.provider'),
                prop: 'provider',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('ai.manager.version'),
                prop: 'version',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('ai.manager.api_key'),
                prop: 'api_key',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('ai.manager.base_url'),
                prop: 'base_url',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('ai.manager.parameters'),
                prop: 'parameters',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                sortable: false,
                operator: 'LIKE',
            },
            {
                label: t('ai.manager.status'),
                prop: 'status',
                align: 'center',
                operator: 'eq',
                sortable: false,
                render: 'tag',
                replaceValue: { '0': t('ai.manager.status 0'), '1': t('ai.manager.status 1') },
            },
            { label: t('ai.manager.max_tokens'), prop: 'max_tokens', align: 'center', sortable: false, operator: 'RANGE' },
            { label: t('ai.manager.price_per_token'), prop: 'price_per_token', align: 'center', sortable: false, operator: 'RANGE' },
            {
                label: t('ai.manager.update_time'),
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
                label: t('ai.manager.create_time'),
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
        defaultItems: { version: '1.0', status: '1', max_tokens: 2048 },
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