# GitHub Profile Refinement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 `zjgulai` GitHub 主页升级为面向中国跨境品牌管理层的可核验决策系统介绍，并让整个可编辑主页介绍对 `Momcozy`、`lute`、`路特` 零命中。

**Architecture:** 使用一个移动优先 Hero SVG 承载价值主张和证据数字，使用 Markdown 承载全部关键结论和公开证据，避免依赖不可读的后台截图。将 Profile 元数据、Pins、README、链接、alt、SVG 元数据和资源路径作为同一个发布单元验证。

**Tech Stack:** GitHub Profile README、Markdown、SVG、GitHub CLI/API、Git、浏览器桌面与移动端验证。

## Global Constraints

- 所有工作在 `main` 分支进行，不使用 worktree。
- 不新增依赖，不修改无关仓库内容。
- 禁用字符串为 `Momcozy`、`lute`、`路特`，匹配时忽略英文字母大小写。
- 零命中范围为可编辑 Profile 介绍，不包括历史贡献动态、提交历史或其他仓库内部页面。
- 未经用户明确批准，不执行 commit、push 或公开 Profile/Pins 修改。
- 所有可核验数字必须能定位到公开仓库文件，不把 README 自述包装为第三方审计。

---

### Task 1: 建立零关键词发布门槛

**Files:**
- Create: `scripts/check-profile-exposure.sh`
- Test: `README.md`
- Test: `assets/readme/hero.svg`
- Test: `assets/readme/decision-loop.svg`

**Interfaces:**
- Consumes: Profile 仓库中的 Markdown、SVG 和资源路径。
- Produces: 一个退出码明确的静态检查命令；命中禁用字符串时返回非零。

- [x] **Step 1: 写入检查脚本**

```bash
#!/usr/bin/env bash
set -euo pipefail

if rg -n -i 'momcozy|lute|路特' README.md assets/readme scripts \
  --glob '!scripts/check-profile-exposure.sh'; then
  echo "Forbidden profile keyword detected." >&2
  exit 1
fi

echo "Profile source exposure check passed."
```

- [x] **Step 2: 在当前内容上运行并确认失败**

Run: `bash scripts/check-profile-exposure.sh`

Expected: FAIL，并列出当前 README、SVG 和资源文件名中的命中。

- [x] **Step 3: 保留脚本作为后续任务的发布门槛**

Run: `bash -n scripts/check-profile-exposure.sh`

Expected: PASS。

---

### Task 2: 重做移动优先视觉资产

**Files:**
- Modify: `assets/readme/hero.svg`
- Create: `assets/readme/decision-loop.svg`
- Delete after references are removed: `assets/readme/capability-map.svg`
- Delete after references are removed: `assets/readme/lute-ai-video.webp`
- Delete after references are removed: `assets/readme/mkt53.webp`
- Delete after references are removed: `assets/readme/momcozy-audit.webp`
- Delete after references are removed: `assets/readme/paper-to-skills.webp`

**Interfaces:**
- Consumes: 设计文档中的色板、核心价值主张和证据数字。
- Produces: `hero.svg` 与 `decision-loop.svg`，供 README 通过相对路径引用。

- [x] **Step 1: 重写 Hero**

Hero 必须包含：

- `PRAY CHOW · AI STRATEGY & DECISION SYSTEMS`
- `把市场信号`
- `变成经营动作`
- `11 年 数据科学与算法`
- `164 项 可治理 Skills`
- `81 项 Hook 自动化测试`

Hero 不得包含客户名称、公司名称或外部域名。

- [x] **Step 2: 创建决策闭环图**

决策闭环图只包含四个阶段：

- `SIGNAL / 发现变化`
- `EVIDENCE / 核验证据`
- `DECISION / 明确取舍`
- `ACTION / 进入经营`

辅助说明使用大字号短句，不放后台 UI 截图。

- [x] **Step 3: 验证 SVG 结构与关键词**

Run: `xmllint --noout assets/readme/hero.svg assets/readme/decision-loop.svg`

Expected: PASS。

Run: `rg -n -i 'momcozy|lute|路特' assets/readme`

Expected: 无输出。

---

### Task 3: 重写管理层主页内容

**Files:**
- Modify: `README.md`

**Interfaces:**
- Consumes: `hero.svg`、`decision-loop.svg` 和公开仓库证据。
- Produces: 可在 GitHub Profile 直接渲染的管理层叙事。

- [x] **Step 1: 重写首屏**

首屏使用以下价值主张：

> 为中国跨境品牌构建可核验的决策系统：把消费者信号、研究证据和供应链口径，转化为有负责人、有边界、可持续运营的经营动作。

同时提供两个主要入口：

- `查看代表项目` → `https://github.com/zjgulai?tab=repositories`
- `查看能力证据` → README 内部的公开证据章节

- [x] **Step 2: 写入三类管理层场景**

使用三行表格：

1. 消费者与市场信号：从分散声音到可复核机会。
2. 供应链与经营治理：从指标争议到 owner、口径和上线边界。
3. AI 能力治理：从零散 prompt 到可安装、诊断、验证和复用的能力资产。

- [x] **Step 3: 写入公开证据**

只使用以下已核验证据：

- 164 managed skills，链接 `Agent_skills/docs/data/skills.json`。
- 9 hook manifests 与 81 tests，链接 `Agent_hook`。
- 30 项 P0 owner sign-off 与 18 项 P0 字段映射，链接 `scm`，并标注“只读原型”。
- 4 步研究转化流程和审核阈值 ≥7/10，链接 `paper_to_skills`。

- [x] **Step 4: 写入代表项目与工作原则**

代表项目只引用：

- `data_achieve`
- `scm`
- `paper_to_skills`
- `Agent_skills`
- `Agent_hook`
- `kgraph`

工作原则写为：

- 证据先于结论。
- 决策必须有 owner、边界和验收方式。
- AI 能力必须可安装、可诊断、可回退。

- [x] **Step 5: 运行静态发布门槛**

Run: `bash scripts/check-profile-exposure.sh`

Expected: PASS。

---

### Task 4: 验证本地候选版本

**Files:**
- Test: `README.md`
- Test: `assets/readme/hero.svg`
- Test: `assets/readme/decision-loop.svg`
- Test: `scripts/check-profile-exposure.sh`

**Interfaces:**
- Consumes: Task 1–3 的候选版本。
- Produces: 可提交给用户批准发布的本地审计结果。

- [x] **Step 1: 检查 Markdown 链接与图片引用**

Run: `rg -o 'https://[^)\" ]+|\\./assets/readme/[^)\" ]+' README.md`

Expected: 所有目标均为无禁用字符串的 GitHub 链接或现存资源。

- [x] **Step 2: 检查资源完整性**

Run: `git diff --check`

Expected: PASS。

Run: `xmllint --noout assets/readme/hero.svg assets/readme/decision-loop.svg`

Expected: PASS。

- [x] **Step 3: 渲染并人工检查图片**

Run: `qlmanage -t -s 1200 -o /tmp/profile-preview assets/readme/hero.svg assets/readme/decision-loop.svg`

Expected: 两张 PNG 预览生成成功；人工确认无品牌标识、无截断、层级清楚。

- [x] **Step 4: 生成差异与发布摘要**

Run: `git status --short`

Expected: 只包含计划列出的文件。

Run: `git diff -- README.md assets/readme/hero.svg assets/readme/decision-loop.svg scripts/check-profile-exposure.sh`

Expected: 变更全部能追溯到本设计。

---

### Task 5: 经用户批准后发布

**Files:**
- Publish: `README.md`
- Publish: `assets/readme/hero.svg`
- Publish: `assets/readme/decision-loop.svg`
- Publish: `scripts/check-profile-exposure.sh`
- Publish: `docs/superpowers/specs/2026-07-28-github-profile-refinement-design.md`
- Publish: `docs/superpowers/plans/2026-07-28-github-profile-refinement.md`

**Interfaces:**
- Consumes: 用户批准的本地候选版本。
- Produces: GitHub Profile 元数据、Pins 和 README 同步更新后的公开主页。

- [x] **Step 1: 提交并推送 Profile 仓库**

Run: `git add README.md assets/readme docs/superpowers scripts/check-profile-exposure.sh`

Run: `git commit -m "feat: refine profile for brand leaders"`

Run: `git push origin main`

Expected: `origin/main` 指向新提交。

- [x] **Step 2: 修改 Profile 元数据**

执行 GitHub API 更新：

- Company 清空。
- Website 清空。
- Name、Bio、Location 保持设计文档中的值。

- [x] **Step 3: 更新 Pins**

取消现有 Pins，按以下顺序设置：

1. `data_achieve`
2. `scm`
3. `paper_to_skills`
4. `Agent_skills`
5. `Agent_hook`
6. `kgraph`

- [x] **Step 4: 验证公开 HTML**

抓取 `https://github.com/zjgulai` 并对页面中 Profile 元数据、Pins 与 README 区域执行禁用字符串扫描。

Expected: 可编辑主页介绍零命中。

- [x] **Step 5: 验证桌面与移动端**

检查 1440×1000、390×844 和 320×568：

- 无横向滚动。
- 首屏/前两个移动视口出现价值主张和至少两个证据数字。
- 两张 SVG 无截断、无不可读的小字。
- Pins 顺序正确。
