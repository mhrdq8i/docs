# Chapter 11

## Test

The Rust community thinks about tests in terms of two main categories: _unit tests_ and _integration_ tests.

### Unit Tests

are small and more focused, testing one module in isolation at a time, and can test private interfaces.

### Integration Tests

are entirely external to your library and use your code in the same way any other external code would, using only the public interface and potentially exercising multiple modules per test.
