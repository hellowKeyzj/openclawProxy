# Model Capability Map

This page summarizes common model capability dimensions for practical selection.

## Core Dimensions

| Dimension | Description | Typical Use |
|---|---|---|
| Text Understanding | Summarize, classify, extract | Reports, knowledge ops |
| Coding | Generate/debug/explain code | Dev assistants |
| Multimodal | Understand image/document input | OCR, visual QA |
| Tool Use | Call external APIs/tools | Workflow automation |
| Long Context | Handle long docs and threads | Legal/research review |

## Task Matching

1. General writing and Q&A: balanced general models
2. Structured extraction: models with reliable JSON/function output
3. Coding-heavy tasks: strong coding-capable models
4. Enterprise QA: model + retrieval pipeline (RAG)

## Prompt Templates

```text
Extract company, date, and amount from the text.
Return JSON only.
```

```text
Summarize the following content into 3 executive-level bullets under 120 words.
```