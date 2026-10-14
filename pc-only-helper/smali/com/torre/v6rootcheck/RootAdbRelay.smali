.class public final Lcom/torre/v6rootcheck/RootAdbRelay;
.super Ljava/lang/Object;
.source "RootAdbRelay.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/torre/v6rootcheck/RootAdbRelay$Connection;
    }
.end annotation


# static fields
.field public static final PORT:I = 0x15b3


# instance fields
.field private final clients:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/torre/v6rootcheck/RootAdbRelay$Connection;",
            ">;"
        }
    .end annotation
.end field

.field private volatile closed:Z

.field private server:Ljava/net/ServerSocket;


# direct methods
.method public static synthetic $r8$lambda$hfA7fy631-ooHlBP5BlHtKjKz78(Lcom/torre/v6rootcheck/RootAdbRelay;)V
    .locals 0

    invoke-direct {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->close()V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->clients:Ljava/util/Set;

    return-void
.end method

.method static synthetic access$000(Lcom/torre/v6rootcheck/RootAdbRelay;)Ljava/util/Set;
    .locals 0

    .line 14
    iget-object p0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->clients:Ljava/util/Set;

    return-object p0
.end method

.method static synthetic access$100(Lcom/torre/v6rootcheck/RootAdbRelay;)Z
    .locals 0

    .line 14
    iget-boolean p0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->closed:Z

    return p0
.end method

.method static synthetic access$200(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 14
    invoke-static {p0, p1}, Lcom/torre/v6rootcheck/RootAdbRelay;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    return-void
.end method

.method static alive(Ljava/io/File;)Z
    .locals 5

    .line 111
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/File;

    const-string v2, "relay.pid"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v1}, Lcom/torre/v6rootcheck/RootAdbRelay;->small(Ljava/io/File;)Ljava/lang/String;

    move-result-object p0

    const-string v1, ":"

    invoke-virtual {p0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    .line 112
    aget-object v1, p0, v0

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 113
    const/4 v2, 0x1

    if-le v1, v2, :cond_0

    array-length v3, p0

    const/4 v4, 0x2

    if-ne v3, v4, :cond_0

    aget-object p0, p0, v2

    invoke-static {v1}, Lcom/torre/v6rootcheck/RootAdbRelay;->startTime(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "/proc/"

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 114
    invoke-static {p0}, Landroid/system/Os;->stat(Ljava/lang/String;)Landroid/system/StructStat;

    move-result-object p0

    iget p0, p0, Landroid/system/StructStat;->st_uid:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v1, 0x3e8

    if-ne p0, v1, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    nop

    .line 113
    :goto_0
    return v0

    .line 115
    :catch_0
    move-exception p0

    return v0
.end method

.method private close()V
    .locals 3

    .line 61
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->closed:Z

    .line 62
    :try_start_0
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 63
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->clients:Ljava/util/Set;

    monitor-enter v0

    :try_start_1
    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->clients:Ljava/util/Set;

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;

    invoke-virtual {v2}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->close()V

    goto :goto_1

    :cond_1
    monitor-exit v0

    .line 64
    return-void

    .line 63
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static copy(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 92
    const v0, 0x8000

    new-array v0, v0, [B

    .line 93
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    goto :goto_0

    .line 94
    :cond_0
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 4

    .line 21
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    const/16 v1, 0x3e8

    if-ne v0, v1, :cond_3

    array-length v0, p0

    const/4 v2, 0x3

    if-eq v0, v2, :cond_0

    goto/16 :goto_2

    .line 22
    :cond_0
    new-instance v0, Ljava/io/File;

    const/4 v2, 0x0

    aget-object v2, p0, v2

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 24
    :try_start_0
    new-instance v2, Ljava/io/File;

    const-string v3, "a"

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/torre/v6rootcheck/RootTrial;->validateSocket(Ljava/lang/String;)V

    .line 25
    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/system/Os;->lstat(Ljava/lang/String;)Landroid/system/StructStat;

    move-result-object v2

    .line 26
    iget v3, v2, Landroid/system/StructStat;->st_mode:I

    invoke-static {v3}, Landroid/system/OsConstants;->S_ISDIR(I)Z

    move-result v3

    if-eqz v3, :cond_2

    iget v3, v2, Landroid/system/StructStat;->st_uid:I

    if-ne v3, v1, :cond_2

    iget v1, v2, Landroid/system/StructStat;->st_mode:I

    and-int/lit16 v1, v1, 0x1ff

    const/16 v2, 0x1c0

    if-eq v1, v2, :cond_1

    goto :goto_0

    .line 27
    :cond_1
    new-instance v1, Lcom/torre/v6rootcheck/RootAdbRelay;

    invoke-direct {v1}, Lcom/torre/v6rootcheck/RootAdbRelay;-><init>()V

    const/4 v2, 0x1

    aget-object v2, p0, v2

    const/4 v3, 0x2

    aget-object p0, p0, v3

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0

    invoke-direct {v1, v0, v2, p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->serve(Ljava/io/File;Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 30
    goto :goto_1

    .line 26
    :cond_2
    :goto_0
    return-void

    .line 28
    :catch_0
    move-exception p0

    .line 29
    :try_start_1
    new-instance v1, Ljava/io/File;

    const-string v2, "relay.error"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ": "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception p0

    .line 31
    :goto_1
    return-void

    .line 21
    :cond_3
    :goto_2
    return-void
.end method

.method private serve(Ljava/io/File;Ljava/lang/String;I)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 33
    const-string v0, "stopped"

    const-string v1, "relay.stopped"

    invoke-static {p2}, Lcom/torre/v6rootcheck/LanPolicy;->privateAddress(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 34
    invoke-static {p2, p3}, Lcom/torre/v6rootcheck/LanPolicy;->subnet(Ljava/lang/String;I)Ljava/lang/String;

    .line 35
    new-instance v2, Ljava/io/File;

    const-string v3, "relay.stop"

    invoke-direct {v2, p1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v3, Ljava/io/File;

    const-string v4, "relay.ready"

    invoke-direct {v3, p1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 36
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v4

    .line 37
    new-instance v5, Ljava/io/File;

    const-string v6, "relay.pid"

    invoke-direct {v5, p1, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ":"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v4}, Lcom/torre/v6rootcheck/RootAdbRelay;->startTime(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V

    .line 38
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_0

    return-void

    .line 39
    :cond_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    new-instance v5, Ljava/lang/Thread;

    new-instance v6, Lcom/torre/v6rootcheck/RootAdbRelay$0;

    invoke-direct {v6, p0}, Lcom/torre/v6rootcheck/RootAdbRelay$0;-><init>(Lcom/torre/v6rootcheck/RootAdbRelay;)V

    invoke-direct {v5, v6}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v4, v5}, Ljava/lang/Runtime;->addShutdownHook(Ljava/lang/Thread;)V

    .line 41
    :try_start_0
    new-instance v4, Ljava/net/ServerSocket;

    invoke-direct {v4}, Ljava/net/ServerSocket;-><init>()V

    iput-object v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    iget-object v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljava/net/ServerSocket;->setReuseAddress(Z)V

    .line 42
    iget-object v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    new-instance v6, Ljava/net/InetSocketAddress;

    # The builder uses the protected filesystem socket. Keep this legacy
    # relay listener on loopback so it cannot expose root ADB on the LAN.
    const-string v8, "127.0.0.1"

    invoke-static {v8}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v8

    const/16 v9, 0x15b3

    invoke-direct {v6, v8, v9}, Ljava/net/InetSocketAddress;-><init>(Ljava/net/InetAddress;I)V

    const/16 v8, 0x8

    invoke-virtual {v4, v6, v8}, Ljava/net/ServerSocket;->bind(Ljava/net/SocketAddress;I)V

    .line 43
    iget-object v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    const/16 v6, 0x1f4

    invoke-virtual {v4, v6}, Ljava/net/ServerSocket;->setSoTimeout(I)V

    .line 44
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_5

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_1

    goto/16 :goto_3

    .line 45
    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V

    .line 46
    :goto_0
    iget-boolean v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->closed:Z

    if-nez v4, :cond_4

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v4, :cond_4

    .line 48
    :try_start_1
    iget-object v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->server:Ljava/net/ServerSocket;

    invoke-virtual {v4}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;

    move-result-object v4

    .line 49
    invoke-virtual {v4}, Ljava/net/Socket;->getInetAddress()Ljava/net/InetAddress;

    move-result-object v6

    invoke-virtual {v6}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v6

    .line 50
    invoke-virtual {v4}, Ljava/net/Socket;->getInetAddress()Ljava/net/InetAddress;

    move-result-object v7

    instance-of v7, v7, Ljava/net/Inet4Address;

    if-eqz v7, :cond_3

    invoke-static {p2, p3, v6}, Lcom/torre/v6rootcheck/LanPolicy;->allows(Ljava/lang/String;ILjava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    iget-object v6, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->clients:Ljava/util/Set;

    invoke-interface {v6}, Ljava/util/Set;->size()I

    move-result v6

    if-lt v6, v8, :cond_2

    goto :goto_1

    .line 51
    :cond_2
    invoke-virtual {v4, v5}, Ljava/net/Socket;->setTcpNoDelay(Z)V

    .line 52
    new-instance v6, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;

    new-instance v7, Ljava/io/File;

    const-string v9, "a"

    invoke-direct {v7, p1, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v7}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, p0, v4, v7}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;-><init>(Lcom/torre/v6rootcheck/RootAdbRelay;Ljava/net/Socket;Ljava/lang/String;)V

    .line 53
    iget-object v4, p0, Lcom/torre/v6rootcheck/RootAdbRelay;->clients:Ljava/util/Set;

    invoke-interface {v4, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-virtual {v6}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->start()V

    goto :goto_2

    .line 50
    :cond_3
    :goto_1
    invoke-virtual {v4}, Ljava/net/Socket;->close()V
    :try_end_1
    .catch Ljava/net/SocketTimeoutException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 54
    :catch_0
    move-exception v4

    :goto_2
    goto :goto_0

    .line 57
    :cond_4
    invoke-direct {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->close()V

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    new-instance p2, Ljava/io/File;

    invoke-direct {p2, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p2, v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V

    .line 58
    nop

    .line 59
    return-void

    .line 57
    :cond_5
    :goto_3
    invoke-direct {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->close()V

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    new-instance p2, Ljava/io/File;

    invoke-direct {p2, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p2, v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V

    .line 44
    return-void

    .line 57
    :catchall_0
    move-exception p2

    invoke-direct {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->close()V

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    new-instance p3, Ljava/io/File;

    invoke-direct {p3, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p3, v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V

    .line 58
    throw p2

    .line 33
    :cond_6
    new-instance p1, Ljava/io/IOException;

    const-string p2, "A private IPv4 LAN address is required"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private static small(Ljava/io/File;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 104
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 105
    const/16 p0, 0x1000

    :try_start_0
    new-array p0, p0, [B

    invoke-virtual {v0, p0}, Ljava/io/FileInputStream;->read([B)I

    move-result v1

    .line 106
    if-gez v1, :cond_0

    const-string p0, ""

    goto :goto_0

    :cond_0
    new-instance v2, Ljava/lang/String;

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    const/4 v4, 0x0

    invoke-direct {v2, p0, v4, v1, v3}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 107
    :goto_0
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    .line 106
    return-object p0

    .line 104
    :catchall_0
    move-exception p0

    :try_start_1
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v0

    invoke-virtual {p0, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p0
.end method

.method static startTime(I)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 100
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/proc/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, "/stat"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->small(Ljava/io/File;)Ljava/lang/String;

    move-result-object p0

    .line 101
    const/16 v0, 0x29

    invoke-virtual {p0, v0}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x2

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    const-string v0, "\\s+"

    invoke-virtual {p0, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    const/16 v0, 0x13

    aget-object p0, p0, v0

    return-object p0
.end method

.method static stop(Ljava/io/File;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 118
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 119
    :cond_0
    new-instance v0, Ljava/io/File;

    const-string v1, "relay.stop"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v1, "stop"

    invoke-static {v0, v1}, Lcom/torre/v6rootcheck/RootAdbRelay;->write(Ljava/io/File;Ljava/lang/String;)V

    .line 120
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    const-wide/16 v2, 0x9c4

    add-long/2addr v0, v2

    .line 121
    :goto_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    cmp-long v2, v2, v0

    const-wide/16 v3, 0x64

    const-string v5, "relay.pid"

    if-gez v2, :cond_2

    .line 122
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result v2

    if-nez v2, :cond_1

    return-void

    .line 123
    :cond_1
    invoke-static {v3, v4}, Landroid/os/SystemClock;->sleep(J)V

    goto :goto_0

    .line 125
    :cond_2
    invoke-static {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 126
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->small(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 127
    sget v1, Landroid/system/OsConstants;->SIGTERM:I

    invoke-static {v0, v1}, Landroid/system/Os;->kill(II)V

    .line 128
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    const-wide/16 v5, 0x5dc

    add-long/2addr v1, v5

    .line 129
    :goto_1
    invoke-static {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    cmp-long v5, v5, v1

    if-gez v5, :cond_3

    invoke-static {v3, v4}, Landroid/os/SystemClock;->sleep(J)V

    goto :goto_1

    .line 130
    :cond_3
    invoke-static {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result v1

    if-eqz v1, :cond_4

    sget v1, Landroid/system/OsConstants;->SIGKILL:I

    invoke-static {v0, v1}, Landroid/system/Os;->kill(II)V

    const-wide/16 v0, 0x96

    invoke-static {v0, v1}, Landroid/os/SystemClock;->sleep(J)V

    .line 131
    :cond_4
    invoke-static {p0}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result p0

    if-nez p0, :cond_5

    goto :goto_2

    :cond_5
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Could not stop the ADB listener"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 133
    :cond_6
    :goto_2
    return-void
.end method

.method private static write(Ljava/io/File;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 96
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    :try_start_0
    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/FileDescriptor;->sync()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    .line 97
    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p0

    const/16 p1, 0x180

    invoke-static {p0, p1}, Landroid/system/Os;->chmod(Ljava/lang/String;I)V

    .line 98
    return-void

    .line 96
    :catchall_0
    move-exception p0

    :try_start_1
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p0
.end method
