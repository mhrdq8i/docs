# Modules

- High-Level Module
- Low-Level Module
- Abstraction
- Details/Concretion

## تعریف

اصل **وارونگی وابستگی (Dependency Inversion Principle - DIP)** یکی از مهم‌ترین و شاید کمی پیچیده‌تر از اصول SOLID است. بیایید آن را با جزئیات بیشتری بررسی کنیم.

هدف اصلی این اصل، **کاهش وابستگی مستقیم بین ماژول‌های نرم‌افزاری** است تا سیستمی انعطاف‌پذیر و با قابلیت نگهداری بالا بسازیم.

این اصل دو قانون کلیدی دارد:

1.  **ماژول‌های سطح بالا نباید به ماژول‌های سطح پایین وابسته باشند. هر دو باید به انتزاع (Abstraction) وابسته باشند.**
2.  **انتزاع‌ها نباید به جزئیات پیاده‌سازی وابسته باشند. این جزئیات هستند که باید به انتزاع‌ها وابسته باشند.**

برای درک این قوانین، ابتدا باید چند مفهوم را تعریف کنیم.

---

### مفاهیم کلیدی

- **ماژول سطح بالا (High-Level Module):** این‌ها بخش‌هایی از کد هستند که عملیات اصلی و منطق کسب‌وکار (Business Logic) را در بر می‌گیرند. این ماژول‌ها به "**_چه کاری_**" باید انجام شود می‌پردازند. برای مثال، یک کلاس `OrderProcessor` (پردازشگر سفارش) یک ماژول سطح بالاست.

- **ماژول سطح پایین (Low-Level Module):** این‌ها بخش‌هایی هستند که جزئیات فنی و نحوه انجام کارها را پیاده‌سازی می‌کنند، مانند کار با دیتابیس، ارسال ایمیل یا نوشتن یک فایل. این ماژول‌ها به "**_چگونه_**" یک کار انجام شود می‌پردازند. برای مثال، کلاس `EmailSender` (ارسال‌کننده ایمیل) یک ماژول سطح پایین است.

- **انتزاع (Abstraction):** معمولاً یک **اینترفیس (Interface)** یا یک **کلاس انتزاعی (Abstract Class)** است که مجموعه‌ای از قوانین و متدها را تعریف می‌کند، اما نحوه پیاده‌سازی آن‌ها را مشخص نمی‌کند.

- **جزئیات (Details/Concretion):** این همان کلاس‌های واقعی هستند که یک اینترفیس را **پیاده‌سازی** می‌کنند و منطق مشخصی را اجرا می‌کنند.

---

### مشکل کجاست؟ (نقض اصل DIP)

به طور طبیعی، ماژول‌های سطح بالا از ماژول‌های سطح پایین برای انجام کارهایشان استفاده می‌کنند. مشکل زمانی به وجود می‌آید که این وابستگی **مستقیم** باشد.

**مثال نقض اصل:**
فرض کنید یک کلاس `Notification` (ماژول سطح بالا) داریم که پس از یک عملیات موفق، به کاربر ایمیل می‌زند. برای این کار مستقیماً از کلاس `EmailService` (ماژول سطح پایین) استفاده می‌کند.

```java
// ماژول سطح پایین (جزئیات)
public class EmailService {
    public void sendEmail(String message) {
        System.out.println("Sending email: " + message);
    }
}

// ماژول سطح بالا
public class Notification {
    private EmailService emailService;

    public Notification() {
        // وابستگی مستقیم و محکم در داخل کلاس ایجاد می‌شود ❌
        this.emailService = new EmailService();
    }

    public void send() {
        emailService.sendEmail("Your process is complete.");
    }
}
```

**مشکلات این طراحی:**

1.  **عدم انعطاف‌پذیری:** اگر فردا بخواهیم به جای ایمیل، **پیامک (SMS)** هم ارسال کنیم چه؟ باید کلاس `Notification` را باز کرده و کد آن را تغییر دهیم. این کار اصل باز-بسته را نیز نقض می‌کند.
2.  **تست‌پذیری دشوار:** برای تست کردن کلاس `Notification`، شما همیشه به یک نمونه واقعی از `EmailService` نیاز دارید. نمی‌توانید به راحتی آن را با یک سرویس ساختگی (Mock) جایگزین کنید تا تست واحد (Unit Test) بنویسید.

---

### راه‌حل: وارونه کردن وابستگی!

حالا بیایید وابستگی را "**وارونه**" کنیم. به جای اینکه ماژول سطح بالا به ماژول سطح پایین وابسته باشد، هر دو را به یک "**انتزاع**" مشترک وابسته می‌کنیم.

**۱. یک انتزاع (اینترفیس) تعریف کنید:**
ما یک اینترفیس برای هر نوع سرویس پیام‌رسان تعریف می‌کنیم.

```java
// انتزاع
public interface IMessageService {
    void sendMessage(String message);
}
```

**۲. ماژول سطح پایین را وادار به پیروی از انتزاع کنید:**
کلاس `EmailService` حالا باید اینترفیس `IMessageService` را پیاده‌سازی کند.

```java
// اولین پیاده‌سازی جزئیات
public class EmailService implements IMessageService {
    @Override
    public void sendMessage(String message) {
        System.out.println("Sending email: " + message);
    }
}

// پیاده‌سازی دوم که به راحتی اضافه می‌شود
public class SmsService implements IMessageService {
    @Override
    public void sendMessage(String message) {
        System.out.println("Sending SMS: " + message);
    }
}
```

**۳. ماژول سطح بالا را به انتزاع وابسته کنید:**
کلاس `Notification` دیگر کاری با `EmailService` ندارد. او فقط `IMessageService` را می‌شناسد و برایش مهم نیست چه کلاسی آن را پیاده‌سازی کرده است.

```java
// ماژول سطح بالا
public class Notification {
    // وابستگی به اینترفیس، نه کلاس مشخص
    private final IMessageService messageService;

    // وابستگی از بیرون تزریق می‌شود (Dependency Injection) ✅
    public Notification(IMessageService messageService) {
        this.messageService = messageService;
    }

    public void send() {
        messageService.sendMessage("Your process is complete.");
    }
}
```

### **اتفاقی که افتاد چه بود؟**

جهت وابستگی **وارونه** شد. قبلاً `Notification` به `EmailService` وابسته بود (`Notification` → `EmailService`).
حالا، هم `Notification` به `IMessageService` وابسته است و هم `EmailService` به `IMessageService` وابسته است.

`Notification` → `IMessageService` ← `EmailService`

به این فرآیند که وابستگی‌ها از خارج از کلاس تأمین می‌شوند، **تزریق وابستگی (Dependency Injection)** می‌گویند که رایج‌ترین راه برای پیاده‌سازی اصل DIP است.

### مزایای کلیدی پیروی از DIP

✅ **انعطاف‌پذیری (Flexibility):** حالا اگر بخواهید پیامک ارسال کنید، کافیست یک کلاس جدید `SmsService` بسازید که `IMessageService` را پیاده‌سازی کند و آن را به کلاس `Notification` تزریق کنید، **بدون هیچ تغییری در کد `Notification`\!**

```java
public class Main {
    public static void main(String[] args) {
        // استفاده از سرویس ایمیل
        IMessageService emailer = new EmailService();
        Notification emailNotification = new Notification(emailer);
        emailNotification.send(); // خروجی: Sending email: Your process is complete.

        // استفاده از سرویس پیامک
        IMessageService smser = new SmsService();
        Notification smsNotification = new Notification(smser);
        smsNotification.send(); // خروجی: Sending SMS: Your process is complete.
    }
}
```

✅ **تست‌پذیری (Testability):** شما می‌توانید به راحتی یک کلاس تست (Mock) بسازید که `IMessageService` را پیاده‌سازی کند و آن را برای تست واحد به کلاس `Notification` بدهید.

✅ **کاهش وابستگی (Loose Coupling):** ماژول‌ها دیگر به هم جوش نخورده‌اند و می‌توانند به صورت مستقل توسعه داده شده و استفاده شوند.
