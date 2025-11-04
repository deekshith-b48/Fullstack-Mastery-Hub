# Domain Management

## 📚 Overview

Domain management involves configuring custom domains for deployments on Vercel and Netlify. This includes DNS configuration, SSL certificates, and domain routing.

## 🎯 Domain Fundamentals

### Custom Domains

- **Primary Domain**: Main domain for your site
- **Subdomains**: Additional subdomains
- **Wildcard Domains**: Match all subdomains
- **Domain Aliases**: Multiple domains pointing to same site

### DNS Configuration

- **A Records**: Point to IP addresses
- **CNAME Records**: Point to other domains
- **TXT Records**: Verification and configuration
- **MX Records**: Email routing

## 🚀 Vercel Domain Management

### Add Domain

```bash
# Add custom domain
vercel domains add example.com

# Add subdomain
vercel domains add www.example.com

# List domains
vercel domains ls

# Remove domain
vercel domains rm example.com
```

### DNS Configuration

```bash
# Vercel provides DNS records
# Add to your DNS provider:

# A Record: @ -> 76.76.21.21
# CNAME: www -> cname.vercel-dns.com
```

### SSL Certificates

```bash
# Automatic SSL provisioning
# Wildcard certificates supported
# Let's Encrypt certificates
```

## 🔧 Netlify Domain Management

### Add Domain

```bash
# Add custom domain
netlify domains:add example.com

# Add subdomain
netlify domains:add www.example.com

# List domains
netlify domains:list

# Remove domain
netlify domains:remove example.com
```

### DNS Configuration

```bash
# Netlify provides DNS records
# Add to your DNS provider:

# A Record: @ -> 75.2.60.5
# CNAME: www -> example.netlify.app
```

### SSL Certificates

```bash
# Automatic SSL provisioning
# Let's Encrypt certificates
# Certificate renewal automatic
```

## 🔄 Domain Routing

### Redirects

```json
// vercel.json
{
  "redirects": [
    {
      "source": "/old-path",
      "destination": "/new-path",
      "permanent": true
    }
  ]
}
```

```toml
# netlify.toml
[[redirects]]
  from = "/old-path"
  to = "/new-path"
  status = 301
```

### Rewrites

```json
// vercel.json
{
  "rewrites": [
    {
      "source": "/api/:path*",
      "destination": "/api/:path*"
    }
  ]
}
```

## 🔐 Security

### HTTPS

```bash
# Automatic HTTPS
# SSL certificates included
# HTTP to HTTPS redirect
```

### Security Headers

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains"
        }
      ]
    }
  ]
}
```

## 📊 Domain Verification

### Verification Process

```bash
# Add DNS records
# Wait for verification
# Domain verified automatically

# Check verification status
vercel domains ls
netlify domains:list
```

## 🎯 Best Practices

1. **Primary Domain**: Set primary domain
2. **Subdomains**: Configure subdomains
3. **SSL**: Enable HTTPS
4. **Redirects**: Configure redirects properly
5. **DNS**: Use appropriate DNS records
6. **Monitoring**: Monitor domain status
7. **Documentation**: Document DNS configuration

## 🎓 Learning Resources

- Vercel Domains: https://vercel.com/docs/custom-domains
- Netlify Domains: https://docs.netlify.com/domains-https/custom-domains/
- DNS: https://www.cloudflare.com/learning/dns/

---

**Next**: Learn about [Edge Functions](./EDGE-FUNCTIONS.md)

