# Linux Security

## RSA

Create new RSA KEY

```bash
 ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## GPG

Creating a GPG (GNU Privacy Guard) key is a straightforward process that allows you to encrypt, sign, and verify data securely. Below is a step-by-step guide to creating a GPG key on various platforms:

### 1. Install GPG

Before creating a GPG key, ensure that GPG is installed on your system.

#### On Linux

Most Linux distributions come with GPG pre-installed.

- To check if it's installed, run:

```bash
gpg --version
```

If not installed, install it using your package manager:

- For Debian/Ubuntu:

```bash
sudo apt update && sudo apt install gnupg
```

- For Fedora:

```bash
sudo dnf install gnupg
```

#### On macOS

- Use Homebrew to install GPG:

```bash
brew install gnupg
```

#### On Windows

- Download and install [Gpg4win](https://gpg4win.org/) from the official website.

### 2. Generate a New GPG Key

Once GPG is installed, follow these steps to generate a new key:

#### Step 1: Start the Key Generation Process

Run the following command in your terminal or command prompt:

```bash
gpg --full-generate-key
```

This command allows you to create a new key with detailed options.

#### Step 2: Choose the Key Type

You will be prompted to select the type of key you want to create. The default option is usually sufficient for most users:

```bash
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
```

Press `Enter` to choose the default (`RSA and RSA`).

**NOTE:** I personally use `RSA and RSA` key type.

#### Step 3: Specify the Key Size

Next, specify the key size. A larger key size provides better security but may take longer to generate:

```bash
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072)
```

The default size is 3072 bits, which is recommended. You can press `Enter` to accept the default or enter `4096` for stronger encryption.

#### Step 4: Set the Key Expiration

Decide how long the key should remain valid. You can set an expiration date or make it never expire:

```bash
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
```

For personal use, you can set it to never expire (`0`). For organizational use, consider setting an expiration date (e.g., `2y` for 2 years).

#### Step 5: Confirm Your Choices

Review the settings and confirm:

```bash
Is this correct? (y/N)
```

Type `y` and press `Enter`.

#### Step 6: Provide User Information

You will be asked to provide your name, email address, and an optional comment:

```bash
Real name: Mehrdad Qasemkhani
Email address: mq8@example.com
Comment: Optional comment
```

These details will be used to identify your key.

#### Step 7: Create a Passphrase

Set a strong passphrase to protect your private key. This passphrase will be required whenever you use the private key for signing or decrypting data.

#### Step 8: Wait for Key Generation

GPG will generate entropy by performing random calculations. You may need to perform some activities on your computer (e.g., moving the mouse or typing) to speed up the process.

### 3. Verify Your Key

Once the key is generated, you can list all your keys to verify:

```bash
gpg --list-keys
```

This will display your public key along with its fingerprint.

### 4. Export Your Public Key

To share your public key with others, export it using:

```bash
gpg --armor --export mq@example.com > public-key.asc
```

This creates a file named `public-key.asc` containing your public key in ASCII format.

### 5. Backup Your Private Key

It's crucial to back up your private key. Export it securely:

```bash
gpg --armor --export-secret-keys mq@example.com > private-key.asc
```

Store the `private-key.asc` file in a secure location.

### 6. Upload Your Public Key to a Keyserver (Optional)

If you want to make your public key publicly available, upload it to a keyserver:

```bash
gpg --keyserver hkps://keys.openpgp.org --send-keys YOUR_KEY_ID
```

Replace `YOUR_KEY_ID` with the ID or fingerprint of your key.

### encrypt a file with gpg

```bash
gpg --output file-name.gpg --symmetric file-name
```

### decrypt encrypted gpg file

```bash
gpg --output file-name --decrypt file-name.gpg
```
