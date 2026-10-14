.class public final Lcom/torre/v6rootcheck/ProbeSocket;
.super Ljava/lang/Object;
.source "ProbeSocket.java"

# interfaces
.implements Ljava/lang/AutoCloseable;


# instance fields
.field private volatile closed:Z

.field private final expire:Ljava/lang/Runnable;

.field private final name:Ljava/lang/String;

.field private final server:Landroid/net/LocalServerSocket;

.field private final store:Landroid/content/SharedPreferences;

.field private final timeoutHandler:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->timeoutHandler:Landroid/os/Handler;

    .line 23
    new-instance v0, Lcom/torre/v6rootcheck/ProbeSocket$0;

    invoke-direct {v0, p0}, Lcom/torre/v6rootcheck/ProbeSocket$0;-><init>(Lcom/torre/v6rootcheck/ProbeSocket;)V

    iput-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->expire:Ljava/lang/Runnable;

    .line 26
    const-string v0, "probe"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/torre/v6rootcheck/ProbeSocket;->store:Landroid/content/SharedPreferences;

    .line 27
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "v6check_"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "-"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/torre/v6rootcheck/ProbeSocket;->name:Ljava/lang/String;

    .line 28
    new-instance p1, Landroid/net/LocalServerSocket;

    iget-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->name:Ljava/lang/String;

    invoke-direct {p1, v0}, Landroid/net/LocalServerSocket;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/torre/v6rootcheck/ProbeSocket;->server:Landroid/net/LocalServerSocket;

    .line 29
    return-void
.end method


# virtual methods
.method public close()V
    .locals 2

    .line 56
    iget-boolean v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->closed:Z

    if-eqz v0, :cond_0

    return-void

    .line 57
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->closed:Z

    .line 58
    iget-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->timeoutHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/torre/v6rootcheck/ProbeSocket;->expire:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 59
    :try_start_0
    iget-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->server:Landroid/net/LocalServerSocket;

    invoke-virtual {v0}, Landroid/net/LocalServerSocket;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v0

    sget v1, Landroid/system/OsConstants;->SHUT_RDWR:I

    invoke-static {v0, v1}, Landroid/system/Os;->shutdown(Ljava/io/FileDescriptor;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 60
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->server:Landroid/net/LocalServerSocket;

    invoke-virtual {v0}, Landroid/net/LocalServerSocket;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    .line 61
    :goto_1
    return-void
.end method

.method synthetic lambda$start$0$com-torre-v6rootcheck-ProbeSocket()V
    .locals 14

    .line 34
    const-string v0, "token"

    const-string v1, "pending"

    :goto_0
    iget-boolean v2, p0, Lcom/torre/v6rootcheck/ProbeSocket;->closed:Z

    if-nez v2, :cond_a

    .line 35
    :try_start_0
    iget-object v2, p0, Lcom/torre/v6rootcheck/ProbeSocket;->server:Landroid/net/LocalServerSocket;

    invoke-virtual {v2}, Landroid/net/LocalServerSocket;->accept()Landroid/net/LocalSocket;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 36
    const/16 v3, 0xfa0

    :try_start_1
    invoke-virtual {v2, v3}, Landroid/net/LocalSocket;->setSoTimeout(I)V

    .line 37
    invoke-virtual {v2}, Landroid/net/LocalSocket;->getPeerCredentials()Landroid/net/Credentials;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/Credentials;->getUid()I

    move-result v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 38
    const/16 v4, 0x3e8

    if-eq v3, v4, :cond_1

    if-eqz v3, :cond_1

    .line 49
    if-eqz v2, :cond_0

    :try_start_2
    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 38
    :cond_0
    goto :goto_0

    .line 39
    :cond_1
    :try_start_3
    new-instance v4, Ljava/io/DataInputStream;

    invoke-virtual {v2}, Landroid/net/LocalSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 40
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readUTF()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4}, Ljava/io/DataInputStream;->readInt()I

    move-result v6

    .line 41
    const/4 v7, 0x1

    if-lt v6, v7, :cond_6

    const/16 v7, 0x5dc0

    if-le v6, v7, :cond_2

    goto/16 :goto_2

    .line 42
    :cond_2
    new-array v6, v6, [B

    invoke-virtual {v4, v6}, Ljava/io/DataInputStream;->readFully([B)V

    .line 43
    new-instance v4, Ljava/lang/String;

    sget-object v7, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v6, v7}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 44
    iget-object v6, p0, Lcom/torre/v6rootcheck/ProbeSocket;->store:Landroid/content/SharedPreferences;

    const/4 v7, 0x0

    invoke-interface {v6, v1, v7}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v6

    if-eqz v6, :cond_4

    iget-object v6, p0, Lcom/torre/v6rootcheck/ProbeSocket;->store:Landroid/content/SharedPreferences;

    const-string v8, ""

    invoke-interface {v6, v0, v8}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 45
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v8

    iget-object v10, p0, Lcom/torre/v6rootcheck/ProbeSocket;->store:Landroid/content/SharedPreferences;

    const-string v11, "started"

    const-wide/16 v12, 0x0

    invoke-interface {v10, v11, v12, v13}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v10

    sub-long/2addr v8, v10

    .line 44
    invoke-static {v6, v5, v8, v9, v4}, Lcom/torre/v6rootcheck/ProbeLogic;->validReply(Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    goto :goto_1

    .line 46
    :cond_3
    iget-object v5, p0, Lcom/torre/v6rootcheck/ProbeSocket;->store:Landroid/content/SharedPreferences;

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    const-string v6, "system"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, "\nVerified sender UID: "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v5, v6, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "serviceState"

    const-string v5, "reply"

    .line 47
    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v1, v7}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 48
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/ProbeSocket;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 49
    if-eqz v2, :cond_9

    :try_start_4
    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V

    goto :goto_4

    :cond_4
    :goto_1
    if-eqz v2, :cond_5

    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V

    .line 45
    :cond_5
    goto/16 :goto_0

    .line 49
    :cond_6
    :goto_2
    if-eqz v2, :cond_7

    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 41
    :cond_7
    goto/16 :goto_0

    .line 35
    :catchall_0
    move-exception v3

    if-eqz v2, :cond_8

    :try_start_5
    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v2

    :try_start_6
    invoke-virtual {v3, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_8
    :goto_3
    throw v3
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0

    .line 49
    :catch_0
    move-exception v2

    .line 50
    iget-boolean v3, p0, Lcom/torre/v6rootcheck/ProbeSocket;->closed:Z

    if-nez v3, :cond_9

    iget-object v3, p0, Lcom/torre/v6rootcheck/ProbeSocket;->store:Landroid/content/SharedPreferences;

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ": "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v4, "transportNote"

    invoke-interface {v3, v4, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 51
    :cond_9
    :goto_4
    goto/16 :goto_0

    .line 53
    :cond_a
    return-void
.end method

.method public name()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->name:Ljava/lang/String;

    return-object v0
.end method

.method public start()V
    .locals 4

    .line 32
    iget-object v0, p0, Lcom/torre/v6rootcheck/ProbeSocket;->timeoutHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/torre/v6rootcheck/ProbeSocket;->expire:Ljava/lang/Runnable;

    const-wide/32 v2, 0x13880

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 33
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/torre/v6rootcheck/ProbeSocket$1;

    invoke-direct {v1, p0}, Lcom/torre/v6rootcheck/ProbeSocket$1;-><init>(Lcom/torre/v6rootcheck/ProbeSocket;)V

    const-string v2, "v6-result-channel"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 53
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 54
    return-void
.end method
