<br />
<div align="center">
    <img src="https://doc.buildadmin.com/images/logo.png" alt="" />
    <h1 style="font-size: 36px;color: #2c3e50;font-weight: 600;margin: 0 0 6px 0;">KP企业信息程序</h1>
    <p style="font-size: 17px;color: #6a8bad;margin-bottom: 10px;">使用流行技术栈快速创建商业级后台管理系统</p>
    <a href="https://uni.buildadmin.com" target="_blank">官网</a> |
    <a href="https://demo.buildadmin.com" target="_blank">演示</a> |
    <a href="https://ask.buildadmin.com" target="_blank">社区</a> |
    <a href="https://doc.buildadmin.com/" target="_blank">文档</a> |
    <a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=paVQA1dlpsVNHTla-ZAts6e4pPK4va9R&authKey=Eto0dq9DOuYldJPl6URFAXXHlG2AFQtPUBxNHEByEiuSg9OraxMniXIaWFt46OKi&noverify=0&group_code=294135049" target="_blank">加群</a> |
    <a href="https://doc.buildadmin.com/guide/" target="_blank">视频介绍</a> |
    <a href="https://github.com/yixianliu" target="_blank">GitHub仓库</a>
</div>
<br />
<p align="center">
    <a href="https://www.thinkphp.cn/" target="_blank">
        <img src="https://img.shields.io/badge/ThinkPHP-%3E 8.1-brightgreen?color=91aac3&labelColor=439EFD" alt="vue">
    </a>
    <a href="https://v3.vuejs.org/" target="_blank">
        <img src="https://img.shields.io/badge/Vue-%3E 3.5-brightgreen?color=91aac3&labelColor=439EFD" alt="vue">
    </a>
    <a href="https://cn.vitejs.dev/" target="_blank">
        <img src="https://img.shields.io/badge/Vite-%3E 8.0-blue?color=91aac3&labelColor=439EFD" alt="vite">
    </a>
    <a href="https://element-plus.org/zh-CN/guide/changelog.html" target="_blank">
        <img src="https://img.shields.io/badge/Element--Plus-%3E 2.13-brightgreen?color=91aac3&labelColor=439EFD" alt="element plus">
    </a>
    <a href="https://www.tslang.cn/" target="_blank">
        <img src="https://img.shields.io/badge/TypeScript-%3E 6.0-blue?color=91aac3&labelColor=439EFD" alt="typescript">
    </a>
    <a href="https://pinia.vuejs.org/" target="_blank">
        <img src="https://img.shields.io/badge/Pinia-%3E 3.0-blue?color=91aac3&labelColor=439EFD" alt="vite">
    </a>
    <a href="https://gitee.com/wonderful-code/buildadmin/blob/master/LICENSE" target="_blank">
        <img src="https://img.shields.io/badge/Apache2.0-license-blue?color=91aac3&labelColor=439EFD" alt="license">
    </a>
</p>

<br>
<div align="center">
  <img src="https://doc.buildadmin.com/images/readme/dashboard-radius.png" />
</div>
<br>

### 介绍

🌈 **KP企业信息程序** 是基于 BuildAdmin 框架深度定制的企业级全栈解决方案，融合了 Vue3 + ThinkPHP8 + TypeScript + Vite + Pinia + Element Plus 等前沿技术栈，提供 AI 智能能力、完整电商体系与企业服务模块的集成开发环境。系统支持常驻内存运行、可视化 CRUD 代码生成、自带 WEB 终端、自适应多端，同时提供 Web、WebNuxt、Server 端，内置全局数据回收站和字段级数据修改保护、自动注册路由、无限子级权限管理等，无需授权即可免费商用。

**项目背景与定位**：
- **设计理念**：在 BuildAdmin 框架基础上，融合企业级电商运营需求与 AI 技术趋势
- **应用场景**：适用于电商平台、企业官网、AI应用管理中心
- **数据支撑**：三大核心数据库文件（`ai.sql` - AI功能、`base.sql` - 业务功能、`ba.sql` - 框架核心）
- **商业友好**：Apache 2.0 开源协议，支持商业应用

**项目特色**：
- **技术底座**：完整继承 BuildAdmin 框架的所有核心功能与安全特性
- **业务深度**：基于 `base.sql`（36个业务表）构建的全功能电商与企业服务体系
- **AI 赋能**：通过 `ai.sql`（3张AI表）扩展的多模态 AI 能力集成方案
- **架构规范**：所有数据库设计严格遵循 BuildAdmin 规范（`kp_`前缀、UUID标识、时间戳存储）

本项目可作为**企业级电商平台、AI应用管理中心或综合企业服务系统**的参考实现与开发起点。

### 主要特性

**🚀 CRUD 代码生成：**
图形化拖拽生成后台增删改查代码，自动创建数据表；大气且实用的表格，多达 24 种表单组件支持，行拖拽排序，受权限控制的编辑和删除等等，并支持关联表，可为您节省大量开发时间。

**💥 内置 WEB 终端：**
在后台管理系统领域，我们率先将终端深度集成于系统的 `本地开发环境` 中，它能实现很多理想中的功能，比如：虽然是基于 Vue3 的系统，但在安装时并不需要手动的执行 `npm install` 命令；CRUD 代码生成完毕后，自动调用 `prettier` 格式化代码等。本终端设计上能够调用环境变量中的任意命令，天花板极高，后续将为您提供更多方便、快捷的服务。

**👍 流行且稳定的技术栈：**
除了基于 `ThinkPHP8` 前后端分离架构外，我们的 `Vue3` 使用了 `setup、useTemplateRef` 等，状态管理使用 `Pinia`，并使用了 `TypeScript、Vite` 等可以为你的知识面添砖加瓦的技术栈。使用流行技术栈自然代表本框架兼容相关（Vue3+TP8+PHP8.x）生态，生态系统内数不清的库、包、组件，能够使您的开发事半功倍。

**🎨 模块市场：**
一键安装数据[导入](https://modules.buildadmin.com/dataimport)[导出](https://modules.buildadmin.com/dataexport)、[短信发送](https://modules.buildadmin.com/sms)、[支付](https://modules.buildadmin.com/pay)、[云存储](https://modules.buildadmin.com/?keywords=%E4%BA%91%E5%AD%98%E5%82%A8)、[富文本编辑器](https://modules.buildadmin.com/?keywords=%E5%AF%8C%E6%96%87%E6%9C%AC)，甚至 [CMS](https://modules.buildadmin.com/cms)、[多商户商城](https://modules.buildadmin.com/shop)、[社区](https://modules.buildadmin.com/ask)、纯前端技术栈的学习案例项目等，随时随地为系统添砖加瓦，系统能够自动维护 `package.json` 和 `composer.json` 并通过内置终端自动完成模块所需依赖的安装。

**🔀 前后端分离：**
项目的 `web` 文件夹内包含： `干净`（不含后端代码）、`完整`（所有前端代码文件均在此内）的前端代码文件，代码和部署均可前后分离，对前端开发者友好，作为纯前端开发者，您可以将 BAdmin 当做学习与资源的社群，本系统可为您准备好案例和模板等所需要的环境，而您只需专注于学习或工作，不需要会任何后端代码！（邀您：[和我们一起](http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=paVQA1dlpsVNHTla-ZAts6e4pPK4va9R&authKey=Eto0dq9DOuYldJPl6URFAXXHlG2AFQtPUBxNHEByEiuSg9OraxMniXIaWFt46OKi&noverify=0&group_code=1039646575) ）

**⚡️ 常驻内存：**
系统内置的功能均可常驻内存运行，享受比传统框架快上数十倍的性能提升！目前 [Workerman 模块](https://modules.buildadmin.com/workerman) 可提供框架的常驻内存 `HTTP` 服务，同时该模块还提供了开箱即用的 `WebSocket` 服务。

**🚚 按需加载：**
前端的页面组件和语言包均是在使用到它们时，才从网络异步加载，服务端则是基于 `TP8` 和 `PSR` 规范，天生拥有真正的按需加载能力，所以，您无需考虑 `我并不需要多语言、我并不需要某个后台功能` 这类的问题，不需要不使用或隐藏即可。

**🌴 数据回收与反悔：**
内置全局数据回收站，并且提供字段级数据修改记录和修改对比，随时回滚和还原，安全且无感。

**✨ 高颜值：**
提供三种布局模式，其中默认布局使用无边框设计风格，它并没有强行填满屏幕的每一个缝然后使用边框线进行分隔，所有的功能版块，都像是悬浮在屏幕上的，同时又将屏幕空间及其合理的利用了。

**🔐 权限验证：**
可视化的管理权限，然后根据权限动态的注册路由、菜单、页面、按钮（权限节点）、支持无限父子级权限分组、前后端搭配鉴权，自由分派页面和按钮权限。

**📝 未来可期：**
我们正在持续维护系统，并着手开发更多基础设施模块，按需一键安装，甚至提供开箱即用的各行业完整应用。

**🧱 一举多得：**
后台自适应 PC、平板、手机 等多种场景的支持，轻松应对各种需求。

**💖 其他杂项：**
角色组/管理员/管理员日志、 会员/会员组/会员余额、积分日志、系统配置/控制台/附件管理/个人资料管理等等、更多特性等你探索...

### 功能模块

本项目基于 BuildAdmin 框架扩展了以下功能模块，数据库设计参考了 `ai.sql`（AI功能）、`base.sql`（业务功能）和 `ba.sql`（框架核心）：

---

#### 🤖 AI智能模块（参考 `ai.sql`）

**AI模型管理** (`kp_ai_manager`)：
- **多类型AI服务**：支持8种核心AI能力，包括文本生成、图像生成、语音识别、语音合成、翻译、代码生成、嵌入、聊天完成
- **提供商适配**：兼容 OpenAI、Google、Meta 等主流AI服务提供商
- **参数配置**：支持API密钥、基础URL、默认参数JSON配置
- **计费管理**：支持最大token数、每token价格配置，便于成本控制
- **状态管理**：模型启用/禁用、版本管理、描述信息维护

**AI调用记录** (`kp_ai_invoke_log`)：
- **详细日志**：记录每次调用的输入提示词、响应结果
- **统计分析**：token消耗量、费用计算、响应耗时统计
- **状态追踪**：记录调用状态（成功/失败/超时）、错误信息
- **审计追踪**：IP地址、UserAgent、元数据JSON存储

**AI训练任务** (`kp_ai_training_task`)：
- **全流程管理**：任务状态跟踪（待训练→训练中→已完成/失败）
- **进度监控**：实时进度百分比、当前训练轮次
- **性能指标**：损失值、准确率监控
- **配置管理**：训练数据配置、超参数JSON配置

---

#### 🛒 电商核心模块（参考 `base.sql`）

**商品管理体系**：
- **产品主表** (`kp_products`)：产品UUID、多语言支持、原价/现价/折扣、SEO元数据（标题、描述、关键词）、浏览/点赞/销量统计
- **分类系统** (`kp_product_categories`)：无限级分类、权重排序、多语言支持
- **标签管理** (`kp_product_tags`)：产品标签、颜色标识、使用次数统计
- **SKU属性** (`kp_sku_attribute` + `kp_sku_items`)：完整的SKU属性系统，支持多种商品规格
- **评论系统** (`kp_product_comments`)：商品评论、回复评论、点赞/踩、审批状态

**订单管理流程** (`kp_orders`)：
- **完整生命周期**：pending（待支付）→ paid（已支付）→ processing（处理中）→ shipped（已发货）→ delivered（已送达）→ completed（已完成），同时支持 cancelled（已取消）和 refunded（已退款）
- **订单详情**：JSON格式存储订单项、小计/运费/税费/优惠/总额
- **配送管理**：收货人信息、省市区细分、邮编、物流公司、运单号
- **时间节点**：支付时间、处理时间、发货时间、送达时间、完成时间

**支付集成**：
- **支付方式** (`kp_payment_methods`)：统一的支付方式管理
- **支付配置**：支付宝配置 (`kp_pay_ali_config`)、微信支付配置 (`kp_pay_wx_config`)、银行支付配置 (`kp_pay_bank_config`)

---

#### 👥 会员模块（参考 `base.sql` + `ba.sql`）

**会员基础**（继承 BuildAdmin）：
- **会员管理** (`kp_user`)：会员分组、余额、积分、最后登录、登录IP
- **权限系统** (`kp_user_group` + `kp_user_rule`)：会员权限控制、菜单配置
- **变动日志** (`kp_user_money_log` + `kp_user_score_log`)：余额变动记录、积分变动记录

**会员扩展功能**（参考 `base.sql`）：
- **OAuth登录** (`kp_member_oauth`)：第三方登录支持
- **地址管理** (`kp_users_ref_address`)：收货地址管理
- **余额系统** (`kp_users_ref_balance`)：用户余额账户
- **收藏功能** (`kp_users_ref_collection`)：商品收藏
- **浏览历史** (`kp_history`)：历史记录跟踪

---

#### 🏢 企业服务模块（参考 `base.sql`）

**企业信息** (`kp_enterprise`)：
- 企业介绍、宗旨、发展历程、联系方式
- Logo、图片展示、SEO配置、激活/推荐状态
- 多语言支持、权重排序

**招聘管理** (`kp_hire`)：
- 职位发布、分类、薪资范围、雇佣类型
- 职位要求、福利待遇JSON存储
- 浏览量、申请数统计、截止日期管理

**线上预约** (`kp_appt`)：
- 预约人信息、联系电话、邮箱
- 预约内容、阅读状态管理

**活动管理** (`kp_activity`)：
- 活动标题、内容、简介、SEO配置
- 时间管理（开始/结束/报名截止）、地点、主办方/赞助商
- 费用、最大人数、当前参与人数
- 缩略图、图片JSON、关联产品JSON
- 状态管理（草稿→已发布→进行中→已完成→已取消）

---

#### 📱 微信生态（参考 `base.sql`）

- **公众号配置** (`kp_app_wx`)：微信Key、授权类型、AppID、AppSecret
- **小程序配置** (`kp_applet_wx`)：微信小程序配置管理

---

#### 📝 内容管理（参考 `base.sql`）

**文章系统**：
- **文章管理** (`kp_posts`)：文章UUID、分类、标签、评论、多语言、SEO
- **分类系统** (`kp_post_categories`)：文章分类管理
- **标签管理** (`kp_post_tags`)：文章标签系统
- **评论功能** (`kp_post_comments`)：文章评论管理

**案例展示** (`kp_cases`)：
- 案例UUID、分类、标签、客户名称、项目日期、项目链接
- 多语言支持、SEO优化、浏览/点赞统计
- 缩略图、图片JSON、激活/推荐/置顶状态

**广告系统** (`kp_ads`)：
- 广告UUID、标题、描述、内容JSON、图片、跳转链接
- 位置管理（顶部/侧边栏/底部/内容区/弹窗/Banner）
- 权重排序、时间范围控制、激活状态、浏览/点击统计

**网站公告** (`kp_announce`)：
- 公告UUID、管理员关联、多语言支持
- 类型系统（系统/维护/功能/安全/通用）、优先级（低/普通/高/紧急）
- 置顶/弹窗状态、发布/过期时间、查看统计

**其他内容模块**：
- **菜单管理** (`kp_menu`)：前台菜单、多语言、权重排序
- **站点评论** (`kp_site_comment`)：全站评论管理
- **店铺管理** (`kp_store`)：店铺信息管理
- **备份管理** (`kp_back_up`)：数据备份记录
- **任务队列** (`kp_jobs`)：异步任务处理

---

#### 🔐 系统安全（继承 BuildAdmin `ba.sql`）

**数据安全机制**：
- **数据回收站** (`kp_security_data_recycle` + `kp_security_data_recycle_log`)：误删数据恢复、回收规则配置（可配置控制器、数据表、主键）
- **敏感数据保护** (`kp_security_sensitive_data` + `kp_security_sensitive_data_log`)：字段级修改记录、修改前后对比、一键回滚功能

**权限管理体系**：
- **管理员** (`kp_admin`)：用户名/密码/邮箱/手机、登录失败次数、最后登录、状态管理
- **管理分组** (`kp_admin_group` + `kp_admin_group_access`)：分组权限、用户-分组关联
- **权限规则** (`kp_admin_rule`)：菜单/按钮权限、路由配置、权重排序
- **操作日志** (`kp_admin_log`)：管理员操作日志、IP/UserAgent记录

---

### 框架兼容性与技术规范

本项目数据库设计严格遵循 BuildAdmin 框架核心规范（`ba.sql`），确保与框架的无缝集成：

| 规范项 | 说明 | 实现位置 |
|-------|------|---------|
| **表命名规范** | 所有表使用 `kp_` 前缀 | 全表统一 |
| **UUID标识** | 关键业务表包含 `xxx_uuid` 字段作为唯一标识 | `activity_uuid`、`product_uuid` 等 |
| **时间戳存储** | 时间字段使用 `bigint(16)` 存储Unix时间戳 | `create_time`、`update_time` 等 |
| **多语言支持** | 内容表包含 `lang_key` 字段 | 活动、文章、产品、案例等 |
| **状态字段** | 统一的 `status` 字段设计 | 遵循框架状态枚举规范 |
| **JSON扩展** | 灵活使用JSON类型存储扩展数据 | `meta_data`、`images`、`items` 等 |
| **索引设计** | 合理的索引配置（唯一索引、联合索引、全文索引） | 符合框架性能优化标准 |
| **软删除支持** | 数据回收站机制 | 继承框架安全特性 |

### 技术架构

**前端技术栈**：
- Vue 3（Composition API + setup 语法）
- TypeScript（类型安全）
- Vite（构建工具）
- Pinia（状态管理）
- Element Plus（UI组件库）

**后端技术栈**：
- ThinkPHP 8（PHP框架）
- 常驻内存运行支持
- PSR规范兼容
- Workerman集成支持

**数据库设计**：
- MySQL 8.0+
- InnoDB引擎
- utf8mb4字符集
- 动态行格式

### 安装使用

💫 我们提供了完善的文档，对于熟悉 `ThinkPHP` 和 `Vue` 的用户，请使用大佬版：[快速上手](https://doc.buildadmin.com/guide/install/start.html) ，对于新人朋友，我们额外准备了各个操作系统的从零开始套餐：[Windows从零到一](https://doc.buildadmin.com/guide/install/windows.html) | [Linux从零到一](https://doc.buildadmin.com/guide/install/linux-bt.html) | [MacBook安装引导](https://doc.buildadmin.com/guide/install/macBook.html)

### 联系我们

- [演示站](https://demo.buildadmin.com) 账户：`admin`，密码：`123456`（演示站数据无法修改，请下载源码安装体验全部功能）
- [问答社区：ask.buildadmin.com](https://ask.buildadmin.com)
- [官方网站：uni.buildadmin.com](https://uni.buildadmin.com)
- [文档：doc.buildadmin.com](https://doc.buildadmin.com/)
- 加群：[294135049](http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=paVQA1dlpsVNHTla-ZAts6e4pPK4va9R&authKey=Eto0dq9DOuYldJPl6URFAXXHlG2AFQtPUBxNHEByEiuSg9OraxMniXIaWFt46OKi&noverify=0&group_code=294135049)
- [Gitee仓库](https://gitee.com/zccgit06)、[GitHub仓库](https://github.com/yixianliu)
- [备用文档：docs.buildadmin.net](https://docs.buildadmin.net/)
- [官方邮箱 hi@buildadmin.com](mailto:hi@buildadmin.com)

### 项目预览

|                                                                      |                                                                          |
|----------------------------------------------------------------------|--------------------------------------------------------------------------|
| ![登录](https://doc.buildadmin.com/images/readme/login.gif)            | ![控制台](https://doc.buildadmin.com/images/readme/dashboard.png)           |
| ![布局配置](https://doc.buildadmin.com/images/readme/layout.png)         | ![表格](https://doc.buildadmin.com/images/readme/admin.png)                |
| ![表单](https://doc.buildadmin.com/images/readme/user.png)             | ![系统配置](https://doc.buildadmin.com/images/readme/config.png)             |
| ![数据回收规则](https://doc.buildadmin.com/images/readme/data-recycle.png) | ![数据回收日志](https://doc.buildadmin.com/images/readme/data-recycle-log.png) |
| ![敏感数据](https://doc.buildadmin.com/images/readme/sensitive-data.png) | ![菜单](https://doc.buildadmin.com/images/readme/menu.png)                 |
| ![单栏布局](https://doc.buildadmin.com/images/readme/layout-3.png)       | ![经典布局](https://doc.buildadmin.com/images/readme/layout-2.png)           |

### 特别鸣谢

💕 感谢巨人提供肩膀，排名不分先后

- [Thinkphp](http://www.thinkphp.cn/)
- [FastAdmin](https://gitee.com/karson/fastadmin)
- [Vue](https://github.com/vuejs/core)
- [vue-next-admin](https://gitee.com/lyt-top/vue-next-admin)
- [Element Plus](https://github.com/element-plus/element-plus)
- [TypeScript](https://github.com/microsoft/TypeScript)
- [vue-router](https://github.com/vuejs/vue-router-next)
- [vite](https://github.com/vitejs/vite)
- [Pinia](https://github.com/vuejs/pinia)
- [Axios](https://github.com/axios/axios)
- [nprogress](https://github.com/rstacruz/nprogress)
- [screenfull](https://github.com/sindresorhus/screenfull.js)
- [mitt](https://github.com/developit/mitt)
- [sass](https://github.com/sass/sass)
- [echarts](https://github.com/apache/echarts)
- [vueuse](https://github.com/vueuse/vueuse)
- [lodash](https://github.com/lodash/lodash)
- [eslint](https://github.com/eslint/eslint)
- [prettier](https://github.com/prettier/prettier)
- [Sortable](https://github.com/SortableJS/Sortable)
- [v-code-diff](https://github.com/Shimada666/v-code-diff)
- [clicaptcha](https://github.com/hooray/clicaptcha)
- [phinx](https://github.com/cakephp/phinx)
- [jetbrains](https://www.jetbrains.com/)

### 版权信息

🔐 BuildAdmin 遵循 `Apache2.0` 开源协议发布，提供无需授权的免费使用。\
本项目包含的第三方源码和二进制文件之版权信息另行标注。

### 支持项目

💕 无需捐赠，如果觉得项目不错，或者已经在使用了，希望你可以去 [Github](https://github.com/yixianliu) 帮我们点个 ⭐ Star，这将是对我们极大的鼓励与支持。