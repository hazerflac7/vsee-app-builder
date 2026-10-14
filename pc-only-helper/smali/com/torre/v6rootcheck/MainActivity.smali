.class public Lcom/torre/v6rootcheck/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# static fields
.field private static final EXPECTED_CERT:Ljava/lang/String; = "c8a2e9bccf597c2fb6dc66bee293fc13f2fc47ec77bc6b2b0d52c11f51192ab8"

.field private static final VENDOR_CLASS:Ljava/lang/String; = "com.define.shellservice.ShellService"

.field private static final VENDOR_PACKAGE:Ljava/lang/String; = "com.define.shellservice"


# instance fields
.field private adbStatusButton:Landroid/widget/Button;

.field private busy:Z

.field private cleanupButton:Landroid/widget/Button;

.field private volatile destroyed:Z

.field private detail:Landroid/widget/TextView;

.field private displayed:Ljava/lang/String;

.field private final handler:Landroid/os/Handler;

.field private lastChecking:Z

.field private final refreshTask:Ljava/lang/Runnable;

.field private volatile replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

.field private resultButton:Landroid/widget/Button;

.field private rootStatus:Landroid/widget/TextView;

.field private runButton:Landroid/widget/Button;

.field private saveButton:Landroid/widget/Button;

.field private serviceStatus:Landroid/widget/TextView;

.field private startAdbButton:Landroid/widget/Button;

.field private stopAdbButton:Landroid/widget/Button;

.field private store:Landroid/content/SharedPreferences;

.field private trialButton:Landroid/widget/Button;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 43
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 47
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->handler:Landroid/os/Handler;

    .line 55
    const-string v0, ""

    iput-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->displayed:Ljava/lang/String;

    .line 56
    new-instance v0, Lcom/torre/v6rootcheck/MainActivity$1;

    invoke-direct {v0, p0}, Lcom/torre/v6rootcheck/MainActivity$1;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    iput-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->refreshTask:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/torre/v6rootcheck/MainActivity;)V
    .locals 0

    .line 43
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->refresh()V

    return-void
.end method

.method static synthetic access$100(Lcom/torre/v6rootcheck/MainActivity;)Landroid/os/Handler;
    .locals 0

    .line 43
    iget-object p0, p0, Lcom/torre/v6rootcheck/MainActivity;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method private buildReport()Ljava/lang/String;
    .locals 5

    .line 285
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v1, "local"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 286
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-boolean v0, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-eqz v0, :cond_0

    const-string v2, "Checking access..."

    :cond_0
    return-object v2

    .line 287
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RESULT\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->shortResult()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\nVENDOR SERVICE RESULT\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v3, "system"

    const-string v4, "Waiting for check..."

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\nDEVICE DETAILS\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\nINTERPRETATION\nSystem UID 1000 is not root. Start root ADB leaves the verified root session active and accepts ADB clients only from the owner PC shown in LAN_ALLOWED, while also enforcing the original private-subnet check. Stop ADB closes clients, stops the daemon and restores prior properties. It is not enabled at boot. Test root remains a temporary check. Partition flags are permission checks, not writes. The app itself does not modify firmware; connected root clients can issue powerful commands.\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private button(Ljava/lang/String;)Landroid/widget/Button;
    .locals 1

    .line 163
    new-instance v0, Landroid/widget/Button;

    invoke-direct {v0, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setAllCaps(Z)V

    const/high16 p1, 0x41700000    # 15.0f

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setTextSize(F)V

    .line 164
    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setFocusable(Z)V

    const p1, -0x1c1209

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setTextColor(I)V

    return-object v0
.end method

.method private static varargs capture([Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .line 238
    :try_start_0
    new-instance v0, Ljava/lang/ProcessBuilder;

    invoke-direct {v0, p0}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Ljava/lang/ProcessBuilder;->redirectErrorStream(Z)Ljava/lang/ProcessBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object p0

    .line 239
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 240
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/torre/v6rootcheck/MainActivity$0;

    invoke-direct {v2, p0, v0}, Lcom/torre/v6rootcheck/MainActivity$0;-><init>(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 248
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 249
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v3, 0xa

    invoke-virtual {p0, v3, v4, v2}, Ljava/lang/Process;->waitFor(JLjava/util/concurrent/TimeUnit;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {p0}, Ljava/lang/Process;->destroyForcibly()Ljava/lang/Process;

    .line 250
    :cond_0
    const-wide/16 v2, 0x3e8

    invoke-virtual {v1, v2, v3}, Ljava/lang/Thread;->join(J)V

    .line 251
    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    const-string p0, "UTF-8"

    invoke-virtual {v0, p0}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 252
    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Local check failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private checkVendorService(Ljava/lang/String;)V
    .locals 12

    .line 185
    const-string v0, "token"

    const-string v1, "pending"

    const-string v2, "com.define.shellservice"

    const-string v3, "system"

    const-string v4, "serviceState"

    iget-boolean v5, p0, Lcom/torre/v6rootcheck/MainActivity;->destroyed:Z

    if-eqz v5, :cond_0

    return-void

    .line 187
    :cond_0
    const/4 v5, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v6

    .line 188
    const/high16 v7, 0x8000000

    invoke-virtual {v6, v2, v7}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v7

    .line 189
    iget-object v8, v7, Landroid/content/pm/PackageInfo;->signingInfo:Landroid/content/pm/SigningInfo;

    if-nez v8, :cond_1

    const/4 v7, 0x0

    goto :goto_0

    :cond_1
    iget-object v7, v7, Landroid/content/pm/PackageInfo;->signingInfo:Landroid/content/pm/SigningInfo;

    invoke-virtual {v7}, Landroid/content/pm/SigningInfo;->getApkContentsSigners()[Landroid/content/pm/Signature;

    move-result-object v7

    .line 190
    :goto_0
    if-eqz v7, :cond_8

    array-length v8, v7

    const/4 v9, 0x1

    if-ne v8, v9, :cond_8

    const-string v8, "c8a2e9bccf597c2fb6dc66bee293fc13f2fc47ec77bc6b2b0d52c11f51192ab8"

    const-string v10, "SHA-256"

    invoke-static {v10}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v10

    aget-object v7, v7, v5

    invoke-virtual {v7}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v7

    invoke-virtual {v10, v7}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v7

    invoke-static {v7}, Lcom/torre/v6rootcheck/MainActivity;->hex([B)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    goto/16 :goto_3

    .line 194
    :cond_2
    new-instance v7, Landroid/content/ComponentName;

    const-string v8, "com.define.shellservice.ShellService"

    invoke-direct {v7, v2, v8}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 195
    invoke-virtual {v6, v7, v5}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;

    move-result-object v2

    .line 196
    iget-boolean v6, v2, Landroid/content/pm/ServiceInfo;->enabled:Z

    if-eqz v6, :cond_7

    iget-boolean v6, v2, Landroid/content/pm/ServiceInfo;->exported:Z

    if-eqz v6, :cond_7

    iget-object v2, v2, Landroid/content/pm/ServiceInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v2, v2, Landroid/content/pm/ApplicationInfo;->uid:I

    const/16 v6, 0x3e8

    if-eq v2, v6, :cond_3

    goto/16 :goto_2

    .line 200
    :cond_3
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    .line 201
    new-instance v6, Lcom/torre/v6rootcheck/ProbeSocket;

    invoke-direct {v6, p0}, Lcom/torre/v6rootcheck/ProbeSocket;-><init>(Landroid/content/Context;)V

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

    .line 202
    iget-boolean v6, p0, Lcom/torre/v6rootcheck/MainActivity;->destroyed:Z

    if-eqz v6, :cond_4

    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->closeReplySocket()V

    return-void

    .line 203
    :cond_4
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-interface {v6, v0, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v8, "started"

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v10

    invoke-interface {v6, v8, v10, v11}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    .line 204
    invoke-interface {v6, v1, v9}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v8, "waiting"

    invoke-interface {v6, v4, v8}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 205
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

    invoke-virtual {v6}, Lcom/torre/v6rootcheck/ProbeSocket;->start()V

    .line 206
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v6

    iget-object v6, v6, Landroid/content/pm/ApplicationInfo;->sourceDir:Ljava/lang/String;

    invoke-static {v6}, Lcom/torre/v6rootcheck/ProbeLogic;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 207
    const-string v8, "check"

    invoke-virtual {v8, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v10, " "

    if-eqz v8, :cond_5

    :try_start_1
    invoke-static {v9}, Lcom/torre/v6rootcheck/MainActivity;->probeBody(Z)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    .line 210
    :cond_5
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "printf \'V6_SYSTEM_PROBE_V1\\nSYSTEM_UID=\'; id -u\nCLASSPATH="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " timeout 60 /system/bin/app_process /system/bin com.torre.v6rootcheck.RootTrial "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-static {p1}, Lcom/torre/v6rootcheck/ProbeLogic;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v8, "\n"

    invoke-virtual {p1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 211
    :goto_1
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "{\n"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v8, "\n} 2>&1 | CLASSPATH="

    invoke-virtual {p1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v6, " /system/bin/app_process /system/bin com.torre.v6rootcheck.ResultBridge "

    invoke-virtual {p1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

    .line 213
    invoke-virtual {v6}, Lcom/torre/v6rootcheck/ProbeSocket;->name()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/torre/v6rootcheck/ProbeLogic;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v2}, Lcom/torre/v6rootcheck/ProbeLogic;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 214
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    invoke-virtual {v2, v7}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object v2

    const-string v6, "command"

    invoke-virtual {v2, v6, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    .line 215
    invoke-virtual {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    move-result-object p1

    if-eqz p1, :cond_6

    .line 222
    goto/16 :goto_4

    .line 215
    :cond_6
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v2, "Android did not resolve the vendor service."

    invoke-direct {p1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 197
    :cond_7
    :goto_2
    iget-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v2, "different"

    invoke-interface {p1, v4, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v2, "The service is disabled, private, or does not run as system UID. No commands were sent."

    invoke-interface {p1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 198
    return-void

    .line 191
    :cond_8
    :goto_3
    iget-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v2, "unrecognized"

    invoke-interface {p1, v4, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v2, "The installed vendor service has an unexpected signing certificate. No commands were sent."

    invoke-interface {p1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 192
    return-void

    .line 218
    :catch_0
    move-exception p1

    .line 219
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->closeReplySocket()V

    .line 220
    iget-object v2, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2, v1, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "error"

    invoke-interface {v0, v4, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 221
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, v3, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_5

    .line 216
    :catch_1
    move-exception p1

    .line 217
    iget-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "missing"

    invoke-interface {p1, v4, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "The V6 vendor shell service is not installed on this device."

    invoke-interface {p1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 222
    :goto_4
    nop

    .line 223
    :goto_5
    return-void
.end method

.method private closeReplySocket()V
    .locals 1

    .line 150
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

    invoke-virtual {v0}, Lcom/torre/v6rootcheck/ProbeSocket;->close()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->replySocket:Lcom/torre/v6rootcheck/ProbeSocket;

    :cond_0
    return-void
.end method

.method private dp(I)I
    .locals 1

    .line 152
    int-to-float p1, p1

    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private static hex([B)Ljava/lang/String;
    .locals 5

    .line 356
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-byte v3, p0, v2

    and-int/lit16 v3, v3, 0xff

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "%02x"

    invoke-static {v4, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic lambda$capture$11(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V
    .locals 4

    .line 241
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 242
    const/16 v0, 0x800

    :try_start_1
    new-array v0, v0, [B

    .line 243
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    .line 244
    monitor-enter p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    const/16 v3, 0x5dc0

    if-ge v2, v3, :cond_0

    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    sub-int/2addr v3, v2

    invoke-static {v1, v3}, Ljava/lang/Math;->min(II)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    :cond_0
    monitor-exit p1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 246
    :cond_1
    if-eqz p0, :cond_3

    :try_start_4
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_2

    .line 241
    :catchall_1
    move-exception p1

    if-eqz p0, :cond_2

    :try_start_5
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    goto :goto_1

    :catchall_2
    move-exception p0

    :try_start_6
    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_2
    :goto_1
    throw p1
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0

    .line 246
    :catch_0
    move-exception p0

    .line 247
    :cond_3
    :goto_2
    return-void
.end method

.method private static probeBody(Z)Ljava/lang/String;
    .locals 1

    .line 226
    new-instance v0, Ljava/lang/StringBuilder;

    if-eqz p0, :cond_0

    const-string p0, "printf \'V6_SYSTEM_PROBE_V1\\nSYSTEM_UID=\'; id -u\n"

    goto :goto_0

    :cond_0
    const-string p0, "printf \'LOCAL_UID=\'; id -u\n"

    :goto_0
    invoke-direct {v0, p0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 227
    const-string p0, "printf \'IDENTITY=\'; id\nprintf \'CONTEXT=\'; id -Z\nprintf \'SELINUX=\'; getenforce\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 228
    const-string p0, "for p in ro.debuggable ro.secure ro.adb.secure ro.boot.flash.locked ro.boot.vbmeta.device_state ro.boot.verifiedbootstate ro.boot.slot_suffix ro.oem_unlock_supported sys.oem_unlock_allowed persist.vendor.tiaoshi.disabled init.svc.adbd; do printf \'%s=\' \"$p\"; getprop \"$p\"; done\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 229
    const-string p0, "printf \'ROOT_UID=\'; if command -v su >/dev/null 2>&1; then root_result=$(timeout 5 su -c \'id -u\' 2>/dev/null); case \"$root_result\" in 0) printf \'0\\n\';; *) printf \'not_confirmed\\n\';; esac; else printf \'not_present\\n\'; fi\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 230
    const-string p0, "printf \'\\nPartition access flags (no writes or raw reads):\\n\'; for p in /dev/block/by-name/boot /dev/block/by-name/boot_a /dev/block/by-name/boot_b /dev/block/by-name/init_boot_a /dev/block/by-name/init_boot_b /dev/block/by-name/vbmeta_a /dev/block/by-name/vbmeta_b; do if [ -e \"$p\" ]; then r=no; w=no; [ -r \"$p\" ] && r=yes; [ -w \"$p\" ] && w=yes; printf \'%s read=%s write=%s\\n\' \"$p\" \"$r\" \"$w\"; fi; done\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 231
    const-string p0, "printf \'\\nRoot-owned service entry points (metadata only):\\n\'; ls -ld /mnt/vendor/tee /mnt/vendor/tee/factoryreset.sh /data/local/afrd.ini 2>&1\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 232
    const-string p0, "printf \'\\nSystem mounts:\\n\'; cat /proc/mounts | grep -E \' / | /system | /vendor | /product | /system_ext \' | head -n 8\n"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 233
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private refresh()V
    .locals 13

    .line 256
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v1, "pending"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    const-string v3, "serviceState"

    const-string v4, "system"

    const-string v5, ""

    if-eqz v0, :cond_1

    .line 257
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v8, "started"

    const-wide/16 v9, 0x0

    invoke-interface {v0, v8, v9, v10}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v11

    sub-long/2addr v6, v11

    .line 258
    cmp-long v0, v6, v9

    if-ltz v0, :cond_0

    const-wide/32 v8, 0x11170

    cmp-long v0, v6, v8

    if-lez v0, :cond_1

    .line 259
    :cond_0
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->closeReplySocket()V

    .line 260
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v6, "token"

    invoke-interface {v0, v6}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v6, "timeout"

    invoke-interface {v0, v3, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "No reply within 70 seconds. ADB may still be on. Select ADB status or Stop ADB; restart the box if cleanup fails. "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    .line 261
    const-string v8, "transportNote"

    invoke-interface {v7, v8, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v0, v4, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 264
    :cond_1
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 265
    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v6, "local"

    invoke-interface {v1, v6, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v6, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 266
    invoke-static {v1}, Lcom/torre/v6rootcheck/ProbeLogic;->rootConfirmed(Ljava/lang/String;)Z

    move-result v5

    const/4 v6, 0x1

    if-nez v5, :cond_3

    invoke-static {v4}, Lcom/torre/v6rootcheck/ProbeLogic;->rootConfirmed(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    goto :goto_0

    :cond_2
    move v5, v2

    goto :goto_1

    :cond_3
    :goto_0
    move v5, v6

    .line 267
    :goto_1
    iget-object v7, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v8, "idle"

    invoke-interface {v7, v3, v8}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 268
    const-string v7, "LAN_STATE"

    invoke-static {v4, v7}, Lcom/torre/v6rootcheck/ProbeLogic;->lastValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 269
    iget-object v8, p0, Lcom/torre/v6rootcheck/MainActivity;->rootStatus:Landroid/widget/TextView;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "LAST ROOT / ADB RESULT\n"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-boolean v10, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    const-string v11, "Checking..."

    if-nez v10, :cond_9

    if-eqz v0, :cond_4

    goto :goto_2

    :cond_4
    const-string v10, "on"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_5

    const-string v7, "Root ADB ON"

    goto :goto_3

    :cond_5
    const-string v10, "off"

    invoke-virtual {v10, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_6

    const-string v7, "Root ADB OFF"

    goto :goto_3

    :cond_6
    if-eqz v5, :cond_7

    const-string v7, "Root process confirmed"

    goto :goto_3

    :cond_7
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-eqz v7, :cond_8

    const-string v7, "Not checked"

    goto :goto_3

    :cond_8
    const-string v7, "Not confirmed"

    goto :goto_3

    :cond_9
    :goto_2
    move-object v7, v11

    :goto_3
    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v8, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 270
    iget-boolean v7, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v7, :cond_b

    if-eqz v0, :cond_a

    goto :goto_4

    :cond_a
    invoke-static {v3, v4}, Lcom/torre/v6rootcheck/ProbeLogic;->serviceSummary(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 271
    :cond_b
    :goto_4
    iget-object v4, p0, Lcom/torre/v6rootcheck/MainActivity;->serviceStatus:Landroid/widget/TextView;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "SYSTEM SERVICE\n"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 272
    iget-object v4, p0, Lcom/torre/v6rootcheck/MainActivity;->rootStatus:Landroid/widget/TextView;

    const v7, -0xac2746

    const v8, -0x193f85

    if-eqz v5, :cond_c

    move v5, v7

    goto :goto_5

    :cond_c
    move v5, v8

    :goto_5
    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 273
    iget-object v4, p0, Lcom/torre/v6rootcheck/MainActivity;->serviceStatus:Landroid/widget/TextView;

    const-string v5, "reply"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_d

    goto :goto_6

    :cond_d
    move v7, v8

    :goto_6
    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setTextColor(I)V

    .line 274
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->runButton:Landroid/widget/Button;

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_e

    if-nez v0, :cond_e

    move v4, v6

    goto :goto_7

    :cond_e
    move v4, v2

    :goto_7
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->saveButton:Landroid/widget/Button;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_f

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_f

    if-nez v0, :cond_f

    move v4, v6

    goto :goto_8

    :cond_f
    move v4, v2

    :goto_8
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    .line 275
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->trialButton:Landroid/widget/Button;

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_10

    if-nez v0, :cond_10

    move v4, v6

    goto :goto_9

    :cond_10
    move v4, v2

    :goto_9
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->cleanupButton:Landroid/widget/Button;

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_11

    if-nez v0, :cond_11

    move v4, v6

    goto :goto_a

    :cond_11
    move v4, v2

    :goto_a
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    .line 276
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->startAdbButton:Landroid/widget/Button;

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_12

    if-nez v0, :cond_12

    move v4, v6

    goto :goto_b

    :cond_12
    move v4, v2

    :goto_b
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->stopAdbButton:Landroid/widget/Button;

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_13

    if-nez v0, :cond_13

    move v4, v6

    goto :goto_c

    :cond_13
    move v4, v2

    :goto_c
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->adbStatusButton:Landroid/widget/Button;

    iget-boolean v4, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v4, :cond_14

    if-nez v0, :cond_14

    move v4, v6

    goto :goto_d

    :cond_14
    move v4, v2

    :goto_d
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setEnabled(Z)V

    .line 277
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->resultButton:Landroid/widget/Button;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_15

    iget-boolean v1, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v1, :cond_15

    if-nez v0, :cond_15

    move v1, v6

    goto :goto_e

    :cond_15
    move v1, v2

    :goto_e
    invoke-virtual {v3, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 278
    iget-boolean v1, p0, Lcom/torre/v6rootcheck/MainActivity;->lastChecking:Z

    if-eqz v1, :cond_16

    iget-boolean v1, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v1, :cond_16

    if-nez v0, :cond_16

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->resultButton:Landroid/widget/Button;

    invoke-virtual {v1}, Landroid/widget/Button;->requestFocus()Z

    .line 279
    :cond_16
    iget-boolean v1, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v1, :cond_17

    if-eqz v0, :cond_18

    :cond_17
    move v2, v6

    :cond_18
    iput-boolean v2, p0, Lcom/torre/v6rootcheck/MainActivity;->lastChecking:Z

    .line 280
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->buildReport()Ljava/lang/String;

    move-result-object v0

    .line 281
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_19

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->displayed:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_19

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iput-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->displayed:Ljava/lang/String;

    .line 282
    :cond_19
    return-void
.end method

.method private runChecks(Ljava/lang/String;)V
    .locals 3

    .line 168
    iget-boolean v0, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v1, "pending"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 169
    :cond_0
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->closeReplySocket()V

    .line 170
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    .line 171
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "serviceState"

    const-string v2, "checking"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mode"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 172
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->refresh()V

    .line 173
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/torre/v6rootcheck/MainActivity$2;

    invoke-direct {v1, p0, p1}, Lcom/torre/v6rootcheck/MainActivity$2;-><init>(Lcom/torre/v6rootcheck/MainActivity;Ljava/lang/String;)V

    const-string p1, "v6-local-check"

    invoke-direct {v0, v1, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 181
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 182
    return-void

    .line 168
    :cond_1
    :goto_0
    return-void
.end method

.method private saveReport()V
    .locals 7

    .line 307
    const-string v0, "is_pending"

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_5

    .line 308
    nop

    .line 310
    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "v6-root-pc-only-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    new-instance v3, Ljava/text/SimpleDateFormat;

    const-string v4, "yyyyMMdd-HHmmss"

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {v3, v4, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v4, Ljava/util/Date;

    invoke-direct {v4}, Ljava/util/Date;-><init>()V

    invoke-virtual {v3, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".txt"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 311
    new-instance v3, Landroid/content/ContentValues;

    invoke-direct {v3}, Landroid/content/ContentValues;-><init>()V

    .line 312
    const-string v4, "_display_name"

    invoke-virtual {v3, v4, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 313
    const-string v4, "mime_type"

    const-string v5, "text/plain"

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 314
    const-string v4, "relative_path"

    sget-object v5, Landroid/os/Environment;->DIRECTORY_DOWNLOADS:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 315
    const/4 v4, 0x1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v0, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 316
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    sget-object v5, Landroid/provider/MediaStore$Downloads;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v4, v5, v3}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 317
    if-eqz v3, :cond_3

    .line 318
    :try_start_1
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "w"

    invoke-virtual {v4, v3, v5}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 319
    if-eqz v4, :cond_1

    .line 320
    :try_start_2
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->buildReport()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/OutputStream;->write([B)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 321
    if-eqz v4, :cond_0

    :try_start_3
    invoke-virtual {v4}, Ljava/io/OutputStream;->close()V

    .line 322
    :cond_0
    new-instance v4, Landroid/content/ContentValues;

    invoke-direct {v4}, Landroid/content/ContentValues;-><init>()V

    const/4 v5, 0x0

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v0, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 323
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, v3, v4, v1, v1}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    .line 324
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v4, "Report saved"

    invoke-virtual {v0, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Open the box\'s file manager and go to Downloads.\n\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\n\nYou can copy this file to your USB drive."

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 325
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "OK"

    .line 326
    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 327
    return-void

    .line 318
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 319
    :cond_1
    :try_start_4
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "Cannot open report file"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 318
    :goto_0
    if-eqz v4, :cond_2

    :try_start_5
    invoke-virtual {v4}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v2

    :try_start_6
    invoke-virtual {v0, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_2
    :goto_1
    throw v0

    .line 328
    :catch_0
    move-exception v0

    goto :goto_2

    .line 317
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "Downloads folder unavailable"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0

    .line 328
    :catch_1
    move-exception v0

    move-object v3, v1

    .line 329
    :goto_2
    if-eqz v3, :cond_4

    :try_start_7
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v2, v3, v1, v1}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    goto :goto_3

    :catch_2
    move-exception v2

    .line 330
    :cond_4
    :goto_3
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v3, "Could not save to Downloads"

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 331
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ": "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\n\nYou can read the short result instead, or choose another folder."

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Lcom/torre/v6rootcheck/MainActivity$12;

    invoke-direct {v2, p0}, Lcom/torre/v6rootcheck/MainActivity$12;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    .line 332
    const-string v3, "Show result"

    invoke-virtual {v0, v3, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Lcom/torre/v6rootcheck/MainActivity$13;

    invoke-direct {v2, p0}, Lcom/torre/v6rootcheck/MainActivity$13;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    .line 333
    const-string v3, "Choose folder"

    invoke-virtual {v0, v3, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "Cancel"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 334
    return-void

    .line 337
    :cond_5
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->saveWithPicker()V

    .line 338
    return-void
.end method

.method private saveWithPicker()V
    .locals 4

    .line 341
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "text/plain"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "android.intent.extra.TITLE"

    const-string v2, "v6-root-pc-only.txt"

    .line 342
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 343
    const/16 v1, 0xa

    invoke-virtual {p0, v0, v1}, Lcom/torre/v6rootcheck/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 344
    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->buildReport()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\nFile picker unavailable: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 345
    :goto_0
    return-void
.end method

.method private shortResult()Ljava/lang/String;
    .locals 6

    .line 293
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v1, "local"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v3, "system"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 294
    iget-object v2, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v3, "serviceState"

    const-string v4, "idle"

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 295
    const-string v3, "reply"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v4, "LAN_STATE"

    invoke-static {v1, v4}, Lcom/torre/v6rootcheck/ProbeLogic;->lastValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    invoke-static {v1}, Lcom/torre/v6rootcheck/ProbeLogic;->trialSummary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 296
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Root: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v0}, Lcom/torre/v6rootcheck/ProbeLogic;->rootConfirmed(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {v1}, Lcom/torre/v6rootcheck/ProbeLogic;->rootConfirmed(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const-string v0, "not confirmed"

    goto :goto_1

    :cond_2
    :goto_0
    const-string v0, "confirmed"

    :goto_1
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "\nSystem service: "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 297
    invoke-static {v2, v1}, Lcom/torre/v6rootcheck/ProbeLogic;->serviceSummary(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 298
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-static {v1}, Lcom/torre/v6rootcheck/ProbeLogic;->trialSummary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v1, "\nSystem access is not full root."

    goto :goto_3

    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Lcom/torre/v6rootcheck/ProbeLogic;->trialSummary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    .line 299
    :cond_4
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\nReason: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_5

    const-string v1, "No result yet."

    goto :goto_2

    :cond_5
    const-string v3, "\\r?\\n"

    const/4 v4, 0x2

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x0

    aget-object v1, v1, v3

    :goto_2
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_3
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 296
    return-object v0
.end method

.method private showResult()V
    .locals 3

    .line 302
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "Read this result back"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 303
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->shortResult()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "OK"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 304
    return-void
.end method

.method private statusCard(Ljava/lang/String;)Landroid/widget/TextView;
    .locals 5

    .line 157
    const/16 v0, 0x10

    const v1, -0xac2746

    invoke-direct {p0, p1, v0, v1}, Lcom/torre/v6rootcheck/MainActivity;->text(Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object p1

    .line 158
    const/16 v0, 0xc

    invoke-direct {p0, v0}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v1

    const/16 v2, 0x8

    invoke-direct {p0, v2}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v3

    invoke-direct {p0, v0}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v0

    invoke-direct {p0, v2}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v4

    invoke-virtual {p1, v1, v3, v0, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 159
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const v1, -0xe8d0ba

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-direct {p0, v2}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 160
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    return-object p1
.end method

.method private text(Ljava/lang/String;II)Landroid/widget/TextView;
    .locals 1

    .line 154
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    int-to-float p1, p2

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setTextColor(I)V

    return-object v0
.end method


# virtual methods
.method synthetic lambda$onCreate$0$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 84
    const-string p1, "lan_on"

    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->runChecks(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$1$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 87
    const-string p1, "lan_off"

    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->runChecks(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$2$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 90
    const-string p1, "lan_status"

    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->runChecks(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$3$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 95
    const-string p1, "check"

    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->runChecks(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$4$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 98
    const-string p1, "run"

    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->runChecks(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$5$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 101
    const-string p1, "recover"

    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->runChecks(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$onCreate$6$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 105
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->showResult()V

    return-void
.end method

.method synthetic lambda$onCreate$7$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 109
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->saveReport()V

    return-void
.end method

.method synthetic lambda$onCreate$8$com-torre-v6rootcheck-MainActivity(Landroid/widget/ScrollView;Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 2

    .line 126
    invoke-virtual {p4}, Landroid/view/KeyEvent;->getAction()I

    move-result p2

    const/4 p4, 0x0

    if-eqz p2, :cond_0

    return p4

    .line 127
    :cond_0
    const/16 p2, 0x14

    const/4 v0, 0x1

    const/16 v1, 0x50

    if-ne p3, p2, :cond_1

    invoke-direct {p0, v1}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result p2

    invoke-virtual {p1, p4, p2}, Landroid/widget/ScrollView;->smoothScrollBy(II)V

    return v0

    .line 128
    :cond_1
    const/16 p2, 0x13

    if-ne p3, p2, :cond_3

    .line 129
    invoke-virtual {p1}, Landroid/widget/ScrollView;->getScrollY()I

    move-result p2

    if-nez p2, :cond_2

    iget-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->startAdbButton:Landroid/widget/Button;

    invoke-virtual {p1}, Landroid/widget/Button;->requestFocus()Z

    goto :goto_0

    :cond_2
    invoke-direct {p0, v1}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result p2

    neg-int p2, p2

    invoke-virtual {p1, p4, p2}, Landroid/widget/ScrollView;->smoothScrollBy(II)V

    .line 130
    :goto_0
    return v0

    .line 132
    :cond_3
    return p4
.end method

.method synthetic lambda$runChecks$10$com-torre-v6rootcheck-MainActivity(Ljava/lang/String;)V
    .locals 4

    .line 174
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "V6 Root ADB 0.4\nManufacturer: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nModel: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nAndroid: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\nApp UID: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 176
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "lan_"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Action: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    invoke-static {v1}, Lcom/torre/v6rootcheck/MainActivity;->probeBody(Z)Ljava/lang/String;

    move-result-object v1

    const-string v2, "sh"

    const-string v3, "-c"

    filled-new-array {v2, v3, v1}, [Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/torre/v6rootcheck/MainActivity;->capture([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 177
    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "local"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 178
    iget-boolean v0, p0, Lcom/torre/v6rootcheck/MainActivity;->destroyed:Z

    if-eqz v0, :cond_1

    return-void

    .line 179
    :cond_1
    invoke-direct {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->checkVendorService(Ljava/lang/String;)V

    .line 180
    iget-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->handler:Landroid/os/Handler;

    new-instance v0, Lcom/torre/v6rootcheck/MainActivity$14;

    invoke-direct {v0, p0}, Lcom/torre/v6rootcheck/MainActivity$14;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 181
    return-void
.end method

.method synthetic lambda$runChecks$9$com-torre-v6rootcheck-MainActivity()V
    .locals 1

    .line 180
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/torre/v6rootcheck/MainActivity;->busy:Z

    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->refresh()V

    return-void
.end method

.method synthetic lambda$saveReport$12$com-torre-v6rootcheck-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 332
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->showResult()V

    return-void
.end method

.method synthetic lambda$saveReport$13$com-torre-v6rootcheck-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 333
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->saveWithPicker()V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 347
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 348
    const/16 v0, 0xa

    if-ne p1, v0, :cond_2

    const/4 p1, -0x1

    if-ne p2, p1, :cond_2

    if-eqz p3, :cond_2

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 349
    :try_start_0
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    const-string p3, "wt"

    invoke-virtual {p1, p2, p3}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 350
    if-eqz p1, :cond_0

    .line 351
    :try_start_1
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->buildReport()Ljava/lang/String;

    move-result-object p2

    sget-object p3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p2, p3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/io/OutputStream;->write([B)V

    .line 352
    const-string p2, "Report saved"

    const/4 p3, 0x1

    invoke-static {p0, p2, p3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/Toast;->show()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 353
    if-eqz p1, :cond_2

    :try_start_2
    invoke-virtual {p1}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    .line 349
    :catchall_0
    move-exception p2

    goto :goto_0

    .line 350
    :cond_0
    :try_start_3
    new-instance p2, Ljava/lang/IllegalStateException;

    const-string p3, "No output stream"

    invoke-direct {p2, p3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 349
    :goto_0
    if-eqz p1, :cond_1

    :try_start_4
    invoke-virtual {p1}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p1

    :try_start_5
    invoke-virtual {p2, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_1
    :goto_1
    throw p2
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0

    .line 353
    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->buildReport()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v0, "\nSave failed: "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 355
    :cond_2
    :goto_2
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 13

    .line 61
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 62
    const-string p1, "probe"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/torre/v6rootcheck/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    .line 63
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/16 v1, 0x400

    invoke-virtual {p1, v1, v1}, Landroid/view/Window;->setFlags(II)V

    .line 64
    new-instance p1, Landroid/widget/LinearLayout;

    invoke-direct {p1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 65
    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 66
    const/16 v2, 0x20

    invoke-direct {p0, v2}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v3

    const/16 v4, 0x14

    invoke-direct {p0, v4}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v4

    invoke-direct {p0, v2}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v2

    const/16 v5, 0x10

    invoke-direct {p0, v5}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v5

    invoke-virtual {p1, v3, v4, v2, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 67
    const/16 v2, 0x16

    const/16 v3, 0x24

    const/16 v4, 0xa

    invoke-static {v4, v2, v3}, Landroid/graphics/Color;->rgb(III)I

    move-result v2

    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 68
    invoke-virtual {p0, p1}, Lcom/torre/v6rootcheck/MainActivity;->setContentView(Landroid/view/View;)V

    .line 69
    const-string v2, "V6 ROOT ADB PC ONLY"

    const/16 v3, 0x1a

    const/4 v5, -0x1

    invoke-direct {p0, v2, v3, v5}, Lcom/torre/v6rootcheck/MainActivity;->text(Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v2

    .line 70
    sget-object v3, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-virtual {v2, v3, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 71
    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 72
    const/16 v2, 0xf

    const v3, -0x564432

    const-string v6, "Start root ADB for the paired PC only. Other LAN clients are rejected."

    invoke-direct {p0, v6, v2, v3}, Lcom/torre/v6rootcheck/MainActivity;->text(Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 73
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 74
    const/16 v3, 0xc

    invoke-direct {p0, v3}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v6

    const/16 v7, 0x8

    invoke-direct {p0, v7}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v8

    invoke-virtual {v2, v0, v6, v0, v8}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 75
    const-string v6, "ROOT ACCESS\nNot checked"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->statusCard(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->rootStatus:Landroid/widget/TextView;

    .line 76
    const-string v6, "SYSTEM SERVICE\nNot checked"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->statusCard(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->serviceStatus:Landroid/widget/TextView;

    .line 77
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v8, 0x43

    invoke-direct {p0, v8}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v9

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v6, v0, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 78
    invoke-direct {p0, v7}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v9

    invoke-virtual {v6, v0, v0, v9, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 79
    iget-object v9, p0, Lcom/torre/v6rootcheck/MainActivity;->rootStatus:Landroid/widget/TextView;

    invoke-virtual {v2, v9, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 80
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->serviceStatus:Landroid/widget/TextView;

    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v8}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v8

    invoke-direct {v9, v0, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 81
    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 82
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 83
    const-string v6, "Start root ADB"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->startAdbButton:Landroid/widget/Button;

    .line 84
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->startAdbButton:Landroid/widget/Button;

    new-instance v8, Lcom/torre/v6rootcheck/MainActivity$3;

    invoke-direct {v8, p0}, Lcom/torre/v6rootcheck/MainActivity$3;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v6, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 85
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->startAdbButton:Landroid/widget/Button;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v9, 0x2c

    invoke-direct {p0, v9}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v11

    invoke-direct {v8, v0, v11, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 86
    const-string v6, "Stop ADB"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->stopAdbButton:Landroid/widget/Button;

    .line 87
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->stopAdbButton:Landroid/widget/Button;

    new-instance v8, Lcom/torre/v6rootcheck/MainActivity$4;

    invoke-direct {v8, p0}, Lcom/torre/v6rootcheck/MainActivity$4;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v6, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 88
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->stopAdbButton:Landroid/widget/Button;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v9}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v11

    invoke-direct {v8, v0, v11, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 89
    const-string v6, "ADB status"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->adbStatusButton:Landroid/widget/Button;

    .line 90
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->adbStatusButton:Landroid/widget/Button;

    new-instance v8, Lcom/torre/v6rootcheck/MainActivity$5;

    invoke-direct {v8, p0}, Lcom/torre/v6rootcheck/MainActivity$5;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v6, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 91
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->adbStatusButton:Landroid/widget/Button;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v9}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v11

    invoke-direct {v8, v0, v11, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 92
    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 93
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 94
    const-string v6, "Run checks"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->runButton:Landroid/widget/Button;

    .line 95
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->runButton:Landroid/widget/Button;

    new-instance v8, Lcom/torre/v6rootcheck/MainActivity$6;

    invoke-direct {v8, p0}, Lcom/torre/v6rootcheck/MainActivity$6;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v6, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 96
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->runButton:Landroid/widget/Button;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v11, 0x28

    invoke-direct {p0, v11}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v12

    invoke-direct {v8, v0, v12, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 97
    const-string v6, "Test root"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->trialButton:Landroid/widget/Button;

    .line 98
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->trialButton:Landroid/widget/Button;

    new-instance v8, Lcom/torre/v6rootcheck/MainActivity$7;

    invoke-direct {v8, p0}, Lcom/torre/v6rootcheck/MainActivity$7;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v6, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 99
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->trialButton:Landroid/widget/Button;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v11}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v12

    invoke-direct {v8, v0, v12, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 100
    const-string v6, "Clean up test"

    invoke-direct {p0, v6}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->cleanupButton:Landroid/widget/Button;

    .line 101
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->cleanupButton:Landroid/widget/Button;

    new-instance v8, Lcom/torre/v6rootcheck/MainActivity$8;

    invoke-direct {v8, p0}, Lcom/torre/v6rootcheck/MainActivity$8;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v6, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 102
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->cleanupButton:Landroid/widget/Button;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v11}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v11

    invoke-direct {v8, v0, v11, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 103
    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 104
    const-string v8, "Show result"

    invoke-direct {p0, v8}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v8

    iput-object v8, p0, Lcom/torre/v6rootcheck/MainActivity;->resultButton:Landroid/widget/Button;

    .line 105
    iget-object v8, p0, Lcom/torre/v6rootcheck/MainActivity;->resultButton:Landroid/widget/Button;

    new-instance v11, Lcom/torre/v6rootcheck/MainActivity$9;

    invoke-direct {v11, p0}, Lcom/torre/v6rootcheck/MainActivity$9;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v8, v11}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 106
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v9}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v11

    invoke-direct {v8, v0, v11, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 107
    iget-object v11, p0, Lcom/torre/v6rootcheck/MainActivity;->resultButton:Landroid/widget/Button;

    invoke-virtual {v6, v11, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 108
    const-string v8, "Save to Downloads"

    invoke-direct {p0, v8}, Lcom/torre/v6rootcheck/MainActivity;->button(Ljava/lang/String;)Landroid/widget/Button;

    move-result-object v8

    iput-object v8, p0, Lcom/torre/v6rootcheck/MainActivity;->saveButton:Landroid/widget/Button;

    .line 109
    iget-object v8, p0, Lcom/torre/v6rootcheck/MainActivity;->saveButton:Landroid/widget/Button;

    new-instance v11, Lcom/torre/v6rootcheck/MainActivity$10;

    invoke-direct {v11, p0}, Lcom/torre/v6rootcheck/MainActivity$10;-><init>(Lcom/torre/v6rootcheck/MainActivity;)V

    invoke-virtual {v8, v11}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 110
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v9}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v9

    invoke-direct {v8, v0, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 111
    iget-object v9, p0, Lcom/torre/v6rootcheck/MainActivity;->saveButton:Landroid/widget/Button;

    invoke-virtual {v6, v9, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 112
    invoke-virtual {p1, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 113
    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    const-string v2, "While ON, only the shown owner PC on this private subnet may connect as root. Use Stop ADB when finished. Restarting the box turns it off."

    const v6, -0x193f85

    invoke-direct {p0, v2, v3, v6}, Lcom/torre/v6rootcheck/MainActivity;->text(Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {p1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 115
    new-instance v2, Landroid/widget/ScrollView;

    invoke-direct {v2, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 116
    invoke-virtual {v2, v1}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    .line 117
    const-string v6, "Select Start root ADB. The result will show the address to connect to.\n\nUse ADB status to refresh the last result. Stop ADB closes connections and restores the previous settings.\n\nThe app does not change firmware or start ADB automatically at boot."

    const v8, -0x291c12

    invoke-direct {p0, v6, v3, v8}, Lcom/torre/v6rootcheck/MainActivity;->text(Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v6

    iput-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    .line 118
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    sget-object v8, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v6, v8}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 119
    iget-object v6, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    invoke-direct {p0, v3}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v8

    invoke-direct {p0, v4}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v9

    invoke-direct {p0, v3}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v3

    invoke-direct {p0, v4}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v4

    invoke-virtual {v6, v8, v9, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 120
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setTextIsSelectable(Z)V

    .line 121
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setFocusable(Z)V

    .line 122
    iget-object v3, p0, Lcom/torre/v6rootcheck/MainActivity;->detail:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 123
    invoke-virtual {v2, v1}, Landroid/widget/ScrollView;->setFocusable(Z)V

    .line 124
    const/high16 v1, 0x60000

    invoke-virtual {v2, v1}, Landroid/widget/ScrollView;->setDescendantFocusability(I)V

    .line 125
    new-instance v1, Lcom/torre/v6rootcheck/MainActivity$11;

    invoke-direct {v1, p0, v2}, Lcom/torre/v6rootcheck/MainActivity$11;-><init>(Lcom/torre/v6rootcheck/MainActivity;Landroid/widget/ScrollView;)V

    invoke-virtual {v2, v1}, Landroid/widget/ScrollView;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    .line 134
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v5, v0, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 135
    invoke-direct {p0, v7}, Lcom/torre/v6rootcheck/MainActivity;->dp(I)I

    move-result v0

    iput v0, v1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 136
    invoke-virtual {p1, v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 137
    iget-object p1, p0, Lcom/torre/v6rootcheck/MainActivity;->startAdbButton:Landroid/widget/Button;

    invoke-virtual {p1}, Landroid/widget/Button;->requestFocus()Z

    .line 138
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->refresh()V

    .line 139
    return-void
.end method

.method protected onDestroy()V
    .locals 3

    .line 144
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/torre/v6rootcheck/MainActivity;->destroyed:Z

    .line 145
    invoke-direct {p0}, Lcom/torre/v6rootcheck/MainActivity;->closeReplySocket()V

    .line 146
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    const-string v1, "pending"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->store:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "token"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 147
    const-string v1, "serviceState"

    const-string v2, "error"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "system"

    const-string v2, "The app closed before the result arrived. ADB may still be on. Wait one minute, then choose ADB status or Stop ADB."

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 148
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 149
    return-void
.end method

.method protected onPause()V
    .locals 2

    .line 142
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->refreshTask:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method protected onResume()V
    .locals 2

    .line 141
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity;->refreshTask:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
