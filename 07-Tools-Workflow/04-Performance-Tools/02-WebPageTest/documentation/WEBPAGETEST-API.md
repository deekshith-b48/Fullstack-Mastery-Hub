# WebPageTest API

WebPageTest API enables programmatic testing. This guide covers API usage, automation, and integration for continuous performance monitoring.

## API Overview

WebPageTest API provides:
- **Programmatic Testing**: Automated testing
- **CI Integration**: CI/CD integration
- **Bulk Testing**: Bulk testing capabilities
- **Results Retrieval**: Automated results retrieval
- **Custom Scripts**: Custom test scripts

## API Setup

### API Key

1. **Sign Up**: Sign up for API key
2. **Get Key**: Get API key from account
3. **Store Securely**: Store key securely
4. **Configure**: Configure API access

### Authentication

```bash
# Using API key
curl "https://www.webpagetest.org/runtest.php?url=https://example.com&key=YOUR_API_KEY"
```

## Running Tests

### Basic Test

```bash
webpagetest test https://example.com \
  --key YOUR_API_KEY \
  --location Dulles \
  --runs 3
```

### Advanced Configuration

```javascript
const webpagetest = require('webpagetest');
const wpt = new webpagetest('www');

wpt.runTest('https://example.com', {
  location: 'Dulles:Chrome',
  runs: 3,
  firstViewOnly: false,
  video: true,
  private: true,
}, (err, data) => {
  console.log(data);
});
```

## Retrieving Results

### Get Test Results

```javascript
wpt.getTestResults(testId, (err, data) => {
  console.log(data);
});
```

### Status Check

```javascript
wpt.getTestStatus(testId, (err, data) => {
  console.log(data);
});
```

## CI Integration

### GitHub Actions

```yaml
name: WebPageTest
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: |
          npm install -g webpagetest
          webpagetest test ${{ secrets.URL }} \
            --key ${{ secrets.WPT_API_KEY }} \
            --location Dulles \
            --runs 3
```

## Best Practices

1. **API Key Security**: Secure API keys
2. **Rate Limiting**: Respect rate limits
3. **Error Handling**: Handle errors gracefully
4. **Monitoring**: Monitor API usage
5. **Documentation**: Document API usage

## Next Steps

- Learn [Waterfall Analysis](./WATERFALL-ANALYSIS.md)
- Explore [Filmstrip View](./FILMSTRIP-VIEW.md)
- Study [Comparison Tests](./COMPARISON-TESTS.md)

WebPageTest API enables automation. Master API usage for continuous monitoring.
