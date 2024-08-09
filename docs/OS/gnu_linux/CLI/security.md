# Linux Security

## Encryption/Decryption

### RSA

Create new RSA KEY

```bash
 ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
 ```

### GPG

#### encrypt a file with gpg

```bash
gpg --output file-name.gpg --symmetric file-name
```

#### decrypt encrypted gpg file

```bash
gpg --output file-name --decrypt file-name.gpg
```
