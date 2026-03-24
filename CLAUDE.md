# CLAUDE.md

## Commands

```bash
bundle exec rspec              # run all tests
bundle exec ruby bin/smoke_test  # test against live APIs (run before releases)
```

## Gotchas

- **Error handling raises, not fallback.** Provider `get_votd` methods raise `Votd::FetchError` on any failure. The original exception is preserved as `#cause`. Errors are reported via `Votd.logger` and `Votd.on_error` before raising. Ignore the README's claim about a default John 3:16 fallback — that behavior was removed.
- **ESVBible is dead.** `Votd::ESVBible` raises `VotdError` on instantiation. The upstream endpoint no longer exists. Direct users to `Votd::BibleGateway.new(:esv)`.
- **Hand-crafted fixtures, not VCR.** Tests use WebMock with fixtures in `spec/fixtures/<provider>/`. Do not introduce VCR.
