# CLAUDE.md

## Code Comments Policy

### IMPORTANT: Always Follow These Rules
- **NEVER add line-by-line comments in source code**
- **ONLY add comments to public classes and functions**
- Private/internal methods should NOT have comments unless explicitly requested
- Focus on clean, self-documenting code instead of excessive comments
- When adding comments to public APIs, keep them concise and focused on usage

## Utilizing Zen MCP Tools

### When Planning or Making Decisions
- Actively use `mcp__zen__thinkdeep` for deep analysis when facing complex problems or design decisions
- Use `mcp__zen__chat` for interactive thinking and organizing thoughts on architecture decisions and implementation approaches

### When External Knowledge is Required
- Enable `use_websearch: true` option with Zen MCP tools when needing latest information about frameworks or libraries
- Actively utilize for researching best practices and industry standards

### Review After Major Work
- Always request code review with `mcp__zen__codereview` after important feature implementations or large-scale refactoring
- Request analysis from security and performance perspectives
- Verify changes with `mcp__zen__precommit` before committing

## Parallel Execution of Large Tasks

### Breaking Down into Subtasks
- Break down large work into appropriate subtasks, organizing them into independently executable units
- Each subtask should have clear responsibilities and deliverables

### Parallel Execution with Claude MCP
- Execute independent subtasks in parallel using `mcp__claude_code__Task` with multiple agents
- Progress different types of tasks simultaneously: file search, code analysis, implementation work, etc.
- When executing in parallel, provide clear instructions and expected outcomes to each agent

### Example
```
# Example of parallel tasks
1. Agent 1: Analyze existing code and understand patterns
2. Agent 2: Investigate related test cases
3. Agent 3: Research documentation and best practices
```