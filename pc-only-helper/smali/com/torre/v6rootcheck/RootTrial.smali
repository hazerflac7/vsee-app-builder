.class public final Lcom/torre/v6rootcheck/RootTrial;
.super Ljava/lang/Object;
.source "RootTrial.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/torre/v6rootcheck/RootTrial$Result;
    }
.end annotation


# static fields
.field private static final BASE:Ljava/io/File;

.field private static final CHECK:Ljava/lang/String; = "printf \'ADB_SHELL_UID=\'; id -u; printf \'ADB_CONTEXT=\'; id -Z; printf \'SELINUX=\'; getenforce; printf \'SELINUX_ENFORCE=\'; cat /sys/fs/selinux/enforce; echo; for p in /dev/block/by-name/boot_a /dev/block/by-name/boot_b /dev/block/by-name/init_boot_a /dev/block/by-name/init_boot_b /dev/block/by-name/vbmeta_a /dev/block/by-name/vbmeta_b; do if [ -e \"$p\" ]; then r=no; w=no; [ -r \"$p\" ] && r=yes; [ -w \"$p\" ] && w=yes; printf \'%s read=%s write=%s\\n\' \"$p\" \"$r\" \"$w\"; fi; done"

.field private static final JOURNAL:Ljava/io/File;

.field private static final LISTEN:Ljava/lang/String; = "service.adb.listen_addrs"

.field private static final ROOT:Ljava/lang/String; = "service.adb.root"


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 24
    new-instance v0, Ljava/io/File;

    const-string v1, "/data/system/v6-pc-only-adb"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/torre/v6rootcheck/RootTrial;->BASE:Ljava/io/File;

    .line 25
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/torre/v6rootcheck/RootTrial;->BASE:Ljava/io/File;

    const-string v2, "trial.properties"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static chooseNetwork()[Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 133
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 134
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v1

    .line 135
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 136
    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/net/NetworkInterface;

    .line 137
    invoke-virtual {v2}, Ljava/net/NetworkInterface;->isUp()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Ljava/net/NetworkInterface;->isLoopback()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/net/NetworkInterface;->isPointToPoint()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/net/NetworkInterface;->isVirtual()Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_0

    .line 138
    :cond_1
    invoke-virtual {v2}, Ljava/net/NetworkInterface;->getInterfaceAddresses()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/net/InterfaceAddress;

    .line 139
    invoke-virtual {v3}, Ljava/net/InterfaceAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v4

    instance-of v4, v4, Ljava/net/Inet4Address;

    if-nez v4, :cond_2

    goto :goto_1

    .line 140
    :cond_2
    invoke-virtual {v3}, Ljava/net/InterfaceAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v4

    invoke-virtual {v4}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3}, Ljava/net/InterfaceAddress;->getNetworkPrefixLength()S

    move-result v3

    .line 141
    invoke-static {v4}, Lcom/torre/v6rootcheck/LanPolicy;->privateAddress(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    const/16 v5, 0x8

    if-lt v3, v5, :cond_3

    const/16 v5, 0x1e

    if-gt v3, v5, :cond_3

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    filled-new-array {v4, v3}, [Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 142
    :cond_3
    goto :goto_1

    .line 143
    :cond_4
    goto :goto_0

    .line 144
    :cond_5
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :cond_7

    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    const-string v0, "No private IPv4 LAN connection was found"

    goto :goto_2

    :cond_6
    const-string v0, "More than one LAN connection is active; use just Ethernet or Wi-Fi for this session"

    :goto_2
    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 145
    :cond_7
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method

.method private static clean(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 317
    if-nez p0, :cond_0

    const-string p0, "Unknown error"

    goto :goto_0

    :cond_0
    const/16 v0, 0xa

    const/16 v1, 0x20

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p0

    const/16 v0, 0xd

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p0

    :goto_0
    return-object p0
.end method

.method private static control(Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 291
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ctl."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "adbd"

    const-string v2, "/system/bin/setprop"

    filled-new-array {v2, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    const-wide/16 v1, 0x7d0

    const/4 v3, 0x0

    invoke-static {v1, v2, v3, v0}, Lcom/torre/v6rootcheck/RootTrial;->execute(JLjava/lang/String;[Ljava/lang/String;)Lcom/torre/v6rootcheck/RootTrial$Result;

    move-result-object v0

    .line 292
    iget v1, v0, Lcom/torre/v6rootcheck/RootTrial$Result;->exit:I

    if-nez v1, :cond_0

    .line 293
    return-void

    .line 292
    :cond_0
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v2, " ADB: "

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    iget-object v0, v0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v1, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static discardState(Ljava/lang/String;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 240
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object p0

    .line 241
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Could not remove trial socket"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 242
    :cond_1
    :goto_0
    const-string v5, "relay.stopped"

    const-string v6, "relay.log"

    const-string v1, "relay.pid"

    const-string v2, "relay.ready"

    const-string v3, "relay.error"

    const-string v4, "relay.stop"

    filled-new-array/range {v1 .. v6}, [Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :goto_1
    const/4 v2, 0x6

    if-ge v1, v2, :cond_4

    aget-object v2, v0, v1

    .line 243
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 244
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_2

    :cond_2
    new-instance p0, Ljava/io/IOException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Could not remove "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 242
    :cond_3
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 246
    :cond_4
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    move-result p0

    if-eqz p0, :cond_5

    goto :goto_3

    :cond_5
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Could not remove trial directory"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 247
    :cond_6
    :goto_3
    sget-object p0, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    move-result p0

    if-eqz p0, :cond_7

    .line 248
    return-void

    .line 247
    :cond_7
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Could not clear trial journal"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static ensureDirectory(Ljava/io/File;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 253
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    const/16 v1, 0x1c0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1}, Landroid/system/Os;->mkdir(Ljava/lang/String;I)V

    .line 254
    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Landroid/system/Os;->lstat(Ljava/lang/String;)Landroid/system/StructStat;

    move-result-object p0

    .line 255
    iget v0, p0, Landroid/system/StructStat;->st_mode:I

    invoke-static {v0}, Landroid/system/OsConstants;->S_ISDIR(I)Z

    move-result v0

    if-eqz v0, :cond_1

    iget v0, p0, Landroid/system/StructStat;->st_uid:I

    const/16 v2, 0x3e8

    if-ne v0, v2, :cond_1

    iget p0, p0, Landroid/system/StructStat;->st_mode:I

    and-int/lit16 p0, p0, 0x1ff

    if-ne p0, v1, :cond_1

    .line 257
    return-void

    .line 256
    :cond_1
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Trial directory has unexpected ownership or permissions"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static varargs execute(JLjava/lang/String;[Ljava/lang/String;)Lcom/torre/v6rootcheck/RootTrial$Result;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 300
    new-instance v0, Ljava/lang/ProcessBuilder;

    invoke-direct {v0, p3}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/ProcessBuilder;->redirectErrorStream(Z)Ljava/lang/ProcessBuilder;

    move-result-object v0

    .line 301
    if-eqz p2, :cond_0

    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "CLASSPATH"

    invoke-interface {v2, v3, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 302
    :cond_0
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object p2

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 303
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/torre/v6rootcheck/RootTrial$0;

    invoke-direct {v3, p2, v0}, Lcom/torre/v6rootcheck/RootTrial$0;-><init>(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 309
    invoke-virtual {v2, v1}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 310
    sget-object v1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p2, p0, p1, v1}, Ljava/lang/Process;->waitFor(JLjava/util/concurrent/TimeUnit;)Z

    move-result p0

    const-wide/16 v3, 0x1f4

    if-eqz p0, :cond_1

    .line 314
    invoke-virtual {v2, v3, v4}, Ljava/lang/Thread;->join(J)V

    .line 315
    monitor-enter v0

    :try_start_0
    new-instance p0, Lcom/torre/v6rootcheck/RootTrial$Result;

    invoke-virtual {p2}, Ljava/lang/Process;->exitValue()I

    move-result p1

    const-string p2, "UTF-8"

    invoke-virtual {v0, p2}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lcom/torre/v6rootcheck/RootTrial$Result;-><init>(ILjava/lang/String;)V

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    .line 311
    :cond_1
    invoke-virtual {p2}, Ljava/lang/Process;->destroyForcibly()Ljava/lang/Process;

    const-wide/16 p0, 0x3e8

    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p2, p0, p1, v0}, Ljava/lang/Process;->waitFor(JLjava/util/concurrent/TimeUnit;)Z

    invoke-virtual {v2, v3, v4}, Ljava/lang/Thread;->join(J)V

    .line 312
    new-instance p0, Ljava/io/IOException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Timed out: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    new-instance p2, Ljava/io/File;

    const/4 v0, 0x0

    aget-object p3, p3, v0

    invoke-direct {p2, p3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method static synthetic lambda$execute$0(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V
    .locals 4

    .line 304
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object p0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 305
    const/16 v0, 0x800

    :try_start_1
    new-array v0, v0, [B

    .line 306
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    monitor-enter p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    const/16 v3, 0x4650

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

    .line 307
    :cond_1
    if-eqz p0, :cond_3

    :try_start_4
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_2

    .line 304
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
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0

    .line 307
    :catch_0
    move-exception p0

    .line 308
    :cond_3
    :goto_2
    return-void
.end method

.method private static launchRelay(Ljava/lang/String;Ljava/io/File;[Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 148
    new-instance v0, Ljava/lang/ProcessBuilder;

    const-class v1, Lcom/torre/v6rootcheck/RootAdbRelay;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v5

    const/4 v1, 0x0

    aget-object v6, p2, v1

    const/4 v1, 0x1

    aget-object v7, p2, v1

    const-string v2, "/system/bin/app_process"

    const-string v3, "/system/bin"

    filled-new-array/range {v2 .. v7}, [Ljava/lang/String;

    move-result-object p2

    invoke-direct {v0, p2}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 149
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object p2

    const-string v2, "CLASSPATH"

    invoke-interface {p2, v2, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 150
    new-instance p0, Ljava/io/File;

    const-string p2, "/dev/null"

    invoke-direct {p0, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/ProcessBuilder;->redirectInput(Ljava/io/File;)Ljava/lang/ProcessBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/ProcessBuilder;->redirectErrorStream(Z)Ljava/lang/ProcessBuilder;

    move-result-object p0

    new-instance p2, Ljava/io/File;

    const-string v1, "relay.log"

    invoke-direct {p2, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p0, p2}, Ljava/lang/ProcessBuilder;->redirectOutput(Ljava/io/File;)Ljava/lang/ProcessBuilder;

    .line 151
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object p0

    .line 152
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x1388

    add-long/2addr v2, v4

    .line 153
    :goto_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    cmp-long p2, v4, v2

    if-gez p2, :cond_3

    .line 154
    new-instance p2, Ljava/io/File;

    const-string v0, "relay.error"

    invoke-direct {p2, p1, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 155
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_2

    .line 156
    new-instance p2, Ljava/io/File;

    const-string v0, "relay.ready"

    invoke-direct {p2, p1, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-static {p1}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result p2

    if-eqz p2, :cond_0

    return-void

    .line 157
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Process;->isAlive()Z

    move-result p2

    if-eqz p2, :cond_1

    .line 158
    const-wide/16 v4, 0x64

    invoke-static {v4, v5}, Landroid/os/SystemClock;->sleep(J)V

    .line 159
    goto :goto_0

    .line 157
    :cond_1
    new-instance p0, Ljava/io/IOException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "ADB listener exited: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->readSmall(Ljava/io/File;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 155
    :cond_2
    new-instance p0, Ljava/io/IOException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Could not open ADB port: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {p2}, Lcom/torre/v6rootcheck/RootTrial;->readSmall(Ljava/io/File;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 160
    :cond_3
    new-instance p0, Ljava/io/IOException;

    const-string p1, "ADB listener did not become ready"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static loadState()Ljava/util/Properties;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 268
    sget-object v0, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->rejectSymlink(Ljava/io/File;)V

    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    .line 269
    new-instance v1, Ljava/io/ByteArrayInputStream;

    sget-object v2, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    const/16 v3, 0x1000

    invoke-static {v2, v3}, Lcom/torre/v6rootcheck/RootTrial;->readBounded(Ljava/io/File;I)[B

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    :try_start_0
    invoke-virtual {v0, v1}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 270
    const-string v1, "root"

    invoke-virtual {v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v1, "listen"

    invoke-virtual {v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v1, "boot"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 272
    return-object v0

    .line 271
    :cond_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Incomplete trial journal"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 269
    :catchall_0
    move-exception v0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v1

    invoke-virtual {v0, v1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw v0
.end method

.method public static main([Ljava/lang/String;)V
    .locals 29

    .line 35
    move-object/from16 v0, p0

    const-string v1, "TRIAL_RESULT="

    const-string v2, "run"

    const-string v3, "0"

    const-string v4, "LAN sessions last until Stop ADB or a box restart. Local-network clients have root access while enabled. The app did not change firmware."

    const-string v5, "This checks a temporary root process, not permanent root or firmware modification."

    const-string v6, "NOTE="

    const-string v7, "not_confirmed"

    const-string v8, "ROOT_UID="

    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v9

    const/16 v10, 0x3e8

    if-eq v9, v10, :cond_0

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "TRIAL_RESULT=Requires the verified system service"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    return-void

    .line 36
    :cond_0
    array-length v9, v0

    const/4 v10, 0x2

    const/4 v11, 0x0

    const/4 v12, 0x1

    if-ne v9, v10, :cond_1

    const-string v9, "query"

    aget-object v13, v0, v11

    invoke-virtual {v9, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    aget-object v0, v0, v12

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->query(Ljava/lang/String;)V

    return-void

    .line 37
    :cond_1
    array-length v9, v0

    const-string v13, ""

    if-lez v9, :cond_2

    aget-object v9, v0, v11

    goto :goto_0

    :cond_2
    move-object v9, v13

    .line 38
    :goto_0
    const-string v14, "lan_"

    invoke-virtual {v9, v14}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v14

    .line 39
    sget-object v15, Ljava/lang/System;->out:Ljava/io/PrintStream;

    move/from16 v16, v11

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v17, v12

    const-string v12, "RUN_TYPE="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "root"

    const-string v10, "recover"

    if-eqz v14, :cond_3

    const-string v19, "adb"

    :goto_1
    move-object/from16 v28, v19

    move-object/from16 v19, v3

    move-object/from16 v3, v28

    goto :goto_2

    :cond_3
    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_4

    const-string v19, "cleanup"

    goto :goto_1

    :cond_4
    move-object/from16 v19, v3

    move-object v3, v12

    :goto_2
    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v15, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 40
    nop

    .line 42
    :try_start_0
    array-length v3, v0

    const/4 v11, 0x2

    if-ne v3, v11, :cond_34

    invoke-virtual {v2, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_9
    .catchall {:try_start_0 .. :try_end_0} :catchall_1b

    const-string v11, "lan_off"

    const-string v15, "lan_on"

    const-string v0, "lan_status"

    if-nez v3, :cond_6

    :try_start_1
    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v15, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 43
    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    goto :goto_3

    :cond_5
    move-object v3, v1

    move-object/from16 v18, v4

    move-object/from16 v20, v5

    move/from16 v24, v14

    goto/16 :goto_2c

    .line 44
    :cond_6
    :goto_3
    sget-object v3, Lcom/torre/v6rootcheck/RootTrial;->BASE:Ljava/io/File;

    invoke-static {v3}, Lcom/torre/v6rootcheck/RootTrial;->ensureDirectory(Ljava/io/File;)V

    .line 45
    new-instance v3, Ljava/io/File;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_9
    .catchall {:try_start_1 .. :try_end_1} :catchall_1b

    move-object/from16 v18, v4

    :try_start_2
    sget-object v4, Lcom/torre/v6rootcheck/RootTrial;->BASE:Ljava/io/File;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_7
    .catchall {:try_start_2 .. :try_end_2} :catchall_19

    move-object/from16 v20, v5

    :try_start_3
    const-string v5, "trial.lock"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 46
    invoke-static {v3}, Lcom/torre/v6rootcheck/RootTrial;->rejectSymlink(Ljava/io/File;)V

    .line 47
    new-instance v4, Ljava/io/RandomAccessFile;

    const-string v5, "rw"

    invoke-direct {v4, v3, v5}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_18

    :try_start_4
    invoke-virtual {v4}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/channels/FileChannel;->tryLock()Ljava/nio/channels/FileLock;

    move-result-object v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_16

    .line 48
    if-eqz v3, :cond_32

    .line 49
    :try_start_5
    sget-object v5, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_12

    move-object/from16 v21, v3

    const-string v3, "lan"

    move-object/from16 v22, v4

    const-string v4, "service.adb.listen_addrs"

    move/from16 v23, v5

    const-string v5, "target"

    move/from16 v24, v14

    const-string v14, "running"

    move-object/from16 v25, v1

    const-string v1, "socket"

    if-eqz v23, :cond_1e

    .line 50
    move-object/from16 v23, v4

    :try_start_6
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->loadState()Ljava/util/Properties;

    move-result-object v4

    .line 51
    move-object/from16 v26, v12

    const-string v12, "kind"

    invoke-virtual {v4, v12}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    .line 52
    if-eqz v12, :cond_16

    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v27

    if-nez v27, :cond_8

    invoke-virtual {v15, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v27

    if-eqz v27, :cond_7

    goto :goto_4

    :cond_7
    move-object/from16 v27, v3

    goto/16 :goto_a

    .line 53
    :cond_8
    :goto_4
    new-instance v2, Ljava/io/File;

    const-string v12, "/proc/sys/kernel/random/boot_id"

    invoke-direct {v2, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Lcom/torre/v6rootcheck/RootTrial;->readSmall(Ljava/io/File;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v12, "boot"

    invoke-virtual {v4, v12}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_a

    .line 54
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->restore()Z

    move-result v2

    if-eqz v2, :cond_9

    move-object/from16 v27, v3

    goto/16 :goto_14

    :cond_9
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Could not clear the prior-boot session"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 56
    :cond_a
    new-instance v2, Ljava/io/File;

    invoke-virtual {v4, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-direct {v2, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    .line 57
    invoke-static {v2}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result v12

    if-eqz v12, :cond_e

    new-instance v12, Ljava/io/File;

    move-object/from16 v27, v3

    const-string v3, "relay.ready"

    invoke-direct {v12, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v12}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_f

    .line 58
    invoke-virtual {v4, v5}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static/range {v23 .. v23}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_f

    const-string v2, "init.svc.adbd"

    invoke-static {v2}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v14, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 59
    aget-object v2, p0, v17

    invoke-virtual {v4, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/torre/v6rootcheck/RootTrial;->rootQuery(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_4

    .line 60
    if-eqz v2, :cond_10

    :try_start_7
    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->printNetwork(Ljava/util/Properties;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_5

    .line 113
    if-eqz v21, :cond_b

    :try_start_8
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    :cond_b
    :try_start_9
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_0
    .catchall {:try_start_9 .. :try_end_9} :catchall_f

    .line 119
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v2, :cond_c

    move-object/from16 v3, v19

    goto :goto_5

    :cond_c
    move-object v3, v7

    :goto_5
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_d

    move-object/from16 v4, v18

    goto :goto_6

    .line 121
    :cond_d
    move-object/from16 v4, v20

    :goto_6
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 60
    return-void

    .line 57
    :cond_e
    move-object/from16 v27, v3

    .line 62
    :cond_f
    move/from16 v2, v16

    :cond_10
    :try_start_a
    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_14

    .line 63
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "LAN_STATE=needs_cleanup\nTRIAL_RESULT=Session is incomplete; select Stop ADB"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_5

    .line 113
    if-eqz v21, :cond_11

    :try_start_b
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    goto :goto_7

    .line 47
    :catchall_0
    move-exception v0

    move-object v1, v0

    move v11, v2

    goto/16 :goto_f

    .line 113
    :cond_11
    :goto_7
    :try_start_c
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_0
    .catchall {:try_start_c .. :try_end_c} :catchall_f

    .line 119
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v2, :cond_12

    move-object/from16 v3, v19

    goto :goto_8

    :cond_12
    move-object v3, v7

    :goto_8
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_13

    move-object/from16 v4, v18

    goto :goto_9

    .line 121
    :cond_13
    move-object/from16 v4, v20

    :goto_9
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 63
    return-void

    .line 114
    :catch_0
    move-exception v0

    move v11, v2

    goto/16 :goto_12

    .line 65
    :cond_14
    :try_start_d
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->restore()Z

    move-result v3

    if-eqz v3, :cond_15

    .line 66
    goto/16 :goto_15

    .line 65
    :cond_15
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Could not clear the incomplete ADB session"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_5

    .line 52
    :cond_16
    move-object/from16 v27, v3

    .line 67
    :goto_a
    if-eqz v12, :cond_1b

    :try_start_e
    invoke-virtual {v2, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1b

    .line 68
    aget-object v0, p0, v17

    invoke-virtual {v4, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/torre/v6rootcheck/RootTrial;->rootQuery(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v11
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_4

    .line 69
    if-eqz v11, :cond_17

    :try_start_f
    new-instance v0, Ljava/io/File;

    invoke-virtual {v4, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->alive(Ljava/io/File;)Z

    move-result v0

    if-eqz v0, :cond_17

    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->printNetwork(Ljava/util/Properties;)V

    goto :goto_b

    .line 70
    :cond_17
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "LAN_STATE=needs_cleanup\nTRIAL_RESULT=Root ADB session needs cleanup"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_2

    .line 113
    :goto_b
    if-eqz v21, :cond_18

    :try_start_10
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_1

    goto :goto_c

    .line 47
    :catchall_1
    move-exception v0

    move-object v1, v0

    goto :goto_f

    .line 113
    :cond_18
    :goto_c
    :try_start_11
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_1
    .catchall {:try_start_11 .. :try_end_11} :catchall_1c

    .line 119
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v11, :cond_19

    move-object/from16 v3, v19

    goto :goto_d

    :cond_19
    move-object v3, v7

    :goto_d
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_1a

    move-object/from16 v4, v18

    goto :goto_e

    .line 121
    :cond_1a
    move-object/from16 v4, v20

    :goto_e
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 71
    return-void

    .line 114
    :catch_1
    move-exception v0

    goto :goto_12

    .line 47
    :catchall_2
    move-exception v0

    move-object v1, v0

    goto :goto_13

    .line 72
    :cond_1b
    :try_start_12
    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1f

    .line 73
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "LAN_STATE=needs_cleanup\nTRIAL_RESULT=An interrupted trial needs cleanup"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_4

    .line 113
    if-eqz v21, :cond_1c

    :try_start_13
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_3

    goto :goto_10

    .line 47
    :catchall_3
    move-exception v0

    move-object v1, v0

    move/from16 v11, v16

    :goto_f
    move-object/from16 v3, v25

    goto/16 :goto_2a

    .line 113
    :cond_1c
    :goto_10
    :try_start_14
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_2
    .catchall {:try_start_14 .. :try_end_14} :catchall_1a

    .line 119
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_1d

    move-object/from16 v4, v18

    goto :goto_11

    .line 121
    :cond_1d
    move-object/from16 v4, v20

    :goto_11
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 73
    return-void

    .line 114
    :catch_2
    move-exception v0

    move/from16 v11, v16

    :goto_12
    move-object/from16 v3, v25

    goto/16 :goto_33

    .line 47
    :catchall_4
    move-exception v0

    move-object v1, v0

    move/from16 v11, v16

    :goto_13
    move-object/from16 v3, v25

    goto/16 :goto_27

    .line 49
    :cond_1e
    move-object/from16 v27, v3

    move-object/from16 v23, v4

    move-object/from16 v26, v12

    .line 76
    :cond_1f
    :goto_14
    move/from16 v2, v16

    :goto_15
    :try_start_15
    sget-object v3, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_11

    if-eqz v3, :cond_21

    .line 77
    :try_start_16
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "RECOVERY=Previous trial journal found"

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 78
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->restore()Z

    move-result v3

    if-eqz v3, :cond_20

    goto :goto_16

    :cond_20
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Previous trial cleanup needs attention; restart the box before another test"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_5

    .line 47
    :catchall_5
    move-exception v0

    move-object v1, v0

    move v11, v2

    goto :goto_13

    .line 80
    :cond_21
    :goto_16
    :try_start_17
    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2d

    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2d

    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_22

    move-object/from16 v3, v25

    goto/16 :goto_20

    .line 86
    :cond_22
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->preflight()V

    .line 87
    invoke-virtual {v15, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_11

    if-eqz v0, :cond_23

    :try_start_18
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->chooseNetwork()[Ljava/lang/String;

    move-result-object v0
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_5

    goto :goto_17

    :cond_23
    const/4 v0, 0x0

    .line 88
    :goto_17
    :try_start_19
    new-instance v3, Ljava/io/File;

    sget-object v4, Lcom/torre/v6rootcheck/RootTrial;->BASE:Ljava/io/File;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "t"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v10

    invoke-virtual {v10}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "-"

    invoke-virtual {v10, v11, v13}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v3, v4, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 89
    invoke-static {v3}, Lcom/torre/v6rootcheck/RootTrial;->ensureDirectory(Ljava/io/File;)V

    .line 90
    new-instance v4, Ljava/util/Properties;

    invoke-direct {v4}, Ljava/util/Properties;-><init>()V

    .line 91
    const-string v9, "service.adb.root"

    invoke-static {v9}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    move-object/from16 v10, v26

    invoke-virtual {v4, v10, v9}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    const-string v9, "listen"

    invoke-static/range {v23 .. v23}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v4, v9, v10}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 92
    new-instance v9, Ljava/io/File;

    const-string v10, "a"

    invoke-direct {v9, v3, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v9}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v4, v1, v9}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 93
    const-string v9, "boot"

    new-instance v10, Ljava/io/File;

    const-string v11, "/proc/sys/kernel/random/boot_id"

    invoke-direct {v10, v11}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v10}, Lcom/torre/v6rootcheck/RootTrial;->readSmall(Ljava/io/File;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v4, v9, v10}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 94
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "localfilesystem:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v4, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v4, v5, v9}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    .line 95
    const-string v9, "kind"
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_11

    if-nez v0, :cond_24

    :try_start_1a
    const-string v10, "trial"
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_5

    goto :goto_18

    :cond_24
    move-object/from16 v10, v27

    :goto_18
    :try_start_1b
    invoke-virtual {v4, v9, v10}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_11

    .line 96
    if-eqz v0, :cond_25

    :try_start_1c
    const-string v9, "address"

    aget-object v10, v0, v16

    invoke-virtual {v4, v9, v10}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    const-string v9, "prefix"

    aget-object v10, v0, v17

    invoke-virtual {v4, v9, v10}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_5

    .line 97
    :cond_25
    :try_start_1d
    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->saveState(Ljava/util/Properties;)V
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_11

    .line 98
    nop

    .line 100
    :try_start_1e
    invoke-virtual {v4, v5}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v9, v23

    invoke-static {v9, v5}, Lcom/torre/v6rootcheck/RootTrial;->setProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 101
    const-string v5, "service.adb.root"

    const-string v9, "1"

    invoke-static {v5, v9}, Lcom/torre/v6rootcheck/RootTrial;->setProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 102
    const-string v5, "start"

    invoke-static {v5}, Lcom/torre/v6rootcheck/RootTrial;->control(Ljava/lang/String;)V

    .line 103
    const/16 v5, 0x1388

    invoke-static {v14, v5}, Lcom/torre/v6rootcheck/RootTrial;->waitState(Ljava/lang/String;I)V

    .line 104
    aget-object v5, p0, v17

    invoke-virtual {v4, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v5, v1}, Lcom/torre/v6rootcheck/RootTrial;->rootQuery(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_c

    .line 105
    if-eqz v0, :cond_27

    .line 106
    if-eqz v1, :cond_26

    .line 107
    :try_start_1f
    aget-object v2, p0, v17

    invoke-static {v2, v3, v0}, Lcom/torre/v6rootcheck/RootTrial;->launchRelay(Ljava/lang/String;Ljava/io/File;[Ljava/lang/String;)V
    :try_end_1f
    .catchall {:try_start_1f .. :try_end_1f} :catchall_7

    .line 108
    :try_start_20
    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->printNetwork(Ljava/util/Properties;)V
    :try_end_20
    .catchall {:try_start_20 .. :try_end_20} :catchall_6

    move/from16 v11, v17

    move-object/from16 v3, v25

    goto :goto_1b

    .line 111
    :catchall_6
    move-exception v0

    move/from16 v11, v17

    goto :goto_19

    :catchall_7
    move-exception v0

    move/from16 v11, v16

    :goto_19
    move-object/from16 v3, v25

    goto/16 :goto_1f

    .line 106
    :cond_26
    :try_start_21
    new-instance v0, Ljava/io/IOException;

    const-string v2, "Root was not confirmed; LAN access was not enabled"

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_21
    .catchall {:try_start_21 .. :try_end_21} :catchall_7

    .line 109
    :cond_27
    :try_start_22
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_b

    move-object/from16 v3, v25

    :try_start_23
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v1, :cond_28

    const-string v4, "Root confirmed temporarily"

    goto :goto_1a

    :cond_28
    const-string v4, "Root not confirmed; see diagnostic details"

    :goto_1a
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_a

    move/from16 v11, v16

    .line 111
    :goto_1b
    if-nez v11, :cond_29

    :try_start_24
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->restore()Z

    move-result v0

    if-nez v0, :cond_29

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "CLEANUP_DETAIL=Select Stop ADB or Clean up test. If cleanup still fails, restart the box."

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_24
    .catchall {:try_start_24 .. :try_end_24} :catchall_d

    .line 113
    :cond_29
    if-eqz v21, :cond_2a

    :try_start_25
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_25
    .catchall {:try_start_25 .. :try_end_25} :catchall_8

    goto :goto_1c

    .line 47
    :catchall_8
    move-exception v0

    move v11, v1

    goto/16 :goto_29

    .line 113
    :cond_2a
    :goto_1c
    :try_start_26
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_26
    .catch Ljava/lang/Exception; {:try_start_26 .. :try_end_26} :catch_3
    .catchall {:try_start_26 .. :try_end_26} :catchall_9

    .line 119
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v1, :cond_2b

    move-object/from16 v3, v19

    goto :goto_1d

    :cond_2b
    move-object v3, v7

    :goto_1d
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_39

    goto/16 :goto_36

    .line 119
    :catchall_9
    move-exception v0

    move v11, v1

    goto/16 :goto_38

    .line 114
    :catch_3
    move-exception v0

    move v11, v1

    goto/16 :goto_33

    .line 111
    :catchall_a
    move-exception v0

    goto :goto_1e

    :catchall_b
    move-exception v0

    move-object/from16 v3, v25

    goto :goto_1e

    :catchall_c
    move-exception v0

    move-object/from16 v3, v25

    move v1, v2

    :goto_1e
    move/from16 v11, v16

    :goto_1f
    if-nez v11, :cond_2c

    :try_start_27
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->restore()Z

    move-result v2

    if-nez v2, :cond_2c

    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "CLEANUP_DETAIL=Select Stop ADB or Clean up test. If cleanup still fails, restart the box."

    invoke-virtual {v2, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 112
    :cond_2c
    throw v0
    :try_end_27
    .catchall {:try_start_27 .. :try_end_27} :catchall_d

    .line 47
    :catchall_d
    move-exception v0

    move v11, v1

    move-object v1, v0

    goto/16 :goto_27

    .line 80
    :cond_2d
    move-object/from16 v3, v25

    .line 81
    :goto_20
    if-eqz v24, :cond_2e

    :try_start_28
    const-string v0, "init.svc.adbd"

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v14, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2e

    .line 82
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "LAN_STATE=unmanaged\nTRIAL_RESULT=ADB is active outside this app; its connection was left unchanged\nCLEANUP=not_needed"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_21

    .line 83
    :cond_2e
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "LAN_STATE=off\nTRIAL_RESULT=App-managed root ADB is off\nCLEANUP=restored"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_28
    .catchall {:try_start_28 .. :try_end_28} :catchall_10

    .line 113
    :goto_21
    if-eqz v21, :cond_2f

    :try_start_29
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_29
    .catchall {:try_start_29 .. :try_end_29} :catchall_e

    goto :goto_22

    .line 47
    :catchall_e
    move-exception v0

    move-object v1, v0

    move v11, v2

    goto/16 :goto_2a

    .line 113
    :cond_2f
    :goto_22
    :try_start_2a
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_2a
    .catch Ljava/lang/Exception; {:try_start_2a .. :try_end_2a} :catch_4
    .catchall {:try_start_2a .. :try_end_2a} :catchall_f

    .line 119
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v2, :cond_30

    move-object/from16 v3, v19

    goto :goto_23

    :cond_30
    move-object v3, v7

    :goto_23
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_31

    move-object/from16 v4, v18

    goto :goto_24

    .line 121
    :cond_31
    move-object/from16 v4, v20

    :goto_24
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 84
    return-void

    .line 119
    :catchall_f
    move-exception v0

    move v11, v2

    goto/16 :goto_38

    .line 114
    :catch_4
    move-exception v0

    move v11, v2

    goto/16 :goto_33

    .line 47
    :catchall_10
    move-exception v0

    goto :goto_25

    :catchall_11
    move-exception v0

    move-object/from16 v3, v25

    :goto_25
    move-object v1, v0

    move v11, v2

    goto :goto_27

    :catchall_12
    move-exception v0

    move-object/from16 v21, v3

    move-object/from16 v22, v4

    move/from16 v24, v14

    move-object v3, v1

    :goto_26
    move-object v1, v0

    move/from16 v11, v16

    goto :goto_27

    .line 48
    :cond_32
    move-object/from16 v21, v3

    move-object/from16 v22, v4

    move/from16 v24, v14

    move-object v3, v1

    :try_start_2b
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Another trial is running; wait one minute"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2b
    .catchall {:try_start_2b .. :try_end_2b} :catchall_13

    .line 47
    :catchall_13
    move-exception v0

    goto :goto_26

    :goto_27
    if-eqz v21, :cond_33

    :try_start_2c
    invoke-virtual/range {v21 .. v21}, Ljava/nio/channels/FileLock;->close()V
    :try_end_2c
    .catchall {:try_start_2c .. :try_end_2c} :catchall_14

    goto :goto_28

    :catchall_14
    move-exception v0

    :try_start_2d
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_33
    :goto_28
    throw v1
    :try_end_2d
    .catchall {:try_start_2d .. :try_end_2d} :catchall_15

    :catchall_15
    move-exception v0

    :goto_29
    move-object v1, v0

    goto :goto_2a

    :catchall_16
    move-exception v0

    move-object v3, v1

    move-object/from16 v22, v4

    move/from16 v24, v14

    move-object v1, v0

    move/from16 v11, v16

    :goto_2a
    :try_start_2e
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_2e
    .catchall {:try_start_2e .. :try_end_2e} :catchall_17

    goto :goto_2b

    :catchall_17
    move-exception v0

    :try_start_2f
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_2b
    throw v1
    :try_end_2f
    .catch Ljava/lang/Exception; {:try_start_2f .. :try_end_2f} :catch_5
    .catchall {:try_start_2f .. :try_end_2f} :catchall_1c

    .line 114
    :catch_5
    move-exception v0

    goto :goto_33

    .line 119
    :catchall_18
    move-exception v0

    goto :goto_2e

    .line 114
    :catch_6
    move-exception v0

    move-object v3, v1

    goto :goto_31

    .line 119
    :catchall_19
    move-exception v0

    goto :goto_2d

    .line 114
    :catch_7
    move-exception v0

    move-object v3, v1

    goto :goto_30

    .line 42
    :cond_34
    move-object v3, v1

    move-object/from16 v18, v4

    move-object/from16 v20, v5

    move/from16 v24, v14

    .line 43
    :goto_2c
    :try_start_30
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid request"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_30
    .catch Ljava/lang/Exception; {:try_start_30 .. :try_end_30} :catch_8
    .catchall {:try_start_30 .. :try_end_30} :catchall_1a

    .line 119
    :catchall_1a
    move-exception v0

    goto :goto_2f

    .line 114
    :catch_8
    move-exception v0

    goto :goto_32

    .line 119
    :catchall_1b
    move-exception v0

    move-object/from16 v18, v4

    :goto_2d
    move-object/from16 v20, v5

    :goto_2e
    move/from16 v24, v14

    :goto_2f
    move/from16 v11, v16

    goto/16 :goto_38

    .line 114
    :catch_9
    move-exception v0

    move-object v3, v1

    move-object/from16 v18, v4

    :goto_30
    move-object/from16 v20, v5

    :goto_31
    move/from16 v24, v14

    :goto_32
    move/from16 v11, v16

    .line 115
    :goto_33
    :try_start_31
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 116
    if-eqz v24, :cond_36

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "LAN_STATE="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_35

    const-string v2, "needs_cleanup"

    goto :goto_34

    :cond_35
    const-string v2, "off"

    :goto_34
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 117
    :cond_36
    sget-object v0, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_37

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "CLEANUP=not_needed"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_31
    .catchall {:try_start_31 .. :try_end_31} :catchall_1c

    .line 119
    :cond_37
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v11, :cond_38

    move-object/from16 v3, v19

    goto :goto_35

    :cond_38
    move-object v3, v7

    :goto_35
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz v24, :cond_39

    :goto_36
    move-object/from16 v4, v18

    goto :goto_37

    .line 121
    :cond_39
    move-object/from16 v4, v20

    :goto_37
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 120
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 122
    nop

    .line 123
    return-void

    .line 119
    :catchall_1c
    move-exception v0

    :goto_38
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v11, :cond_3a

    move-object/from16 v3, v19

    goto :goto_39

    :cond_3a
    move-object v3, v7

    :goto_39
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v24, :cond_3b

    move-object/from16 v4, v18

    goto :goto_3a

    .line 121
    :cond_3b
    move-object/from16 v4, v20

    :goto_3a
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 120
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 122
    throw v0
.end method

.method private static preflight()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 170
    const-string v0, "ro.debuggable"

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 171
    const-string v0, "init.svc.adbd"

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "stopped"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 172
    const-string v0, "sys.usb.config"

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "adb"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_6

    const-string v0, "sys.usb.state"

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_6

    new-instance v0, Ljava/io/File;

    const-string v2, "/dev/usb-ffs/adb/ep0"

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 173
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_6

    .line 174
    const-string v0, "persist.adb.tls_server.enable"

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 175
    new-instance v0, Ljava/io/File;

    const-string v1, "/apex/com.android.adbd/bin/adbd"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 176
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 177
    const v1, 0x7a1200

    invoke-static {v0, v1}, Lcom/torre/v6rootcheck/RootTrial;->readBounded(Ljava/io/File;I)[B

    move-result-object v0

    .line 178
    new-instance v1, Ljava/lang/String;

    sget-object v2, Ljava/nio/charset/StandardCharsets;->ISO_8859_1:Ljava/nio/charset/Charset;

    invoke-direct {v1, v0, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 180
    const-string v2, "localfilesystem\u0000"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_1

    const-string v2, "_Z18socket_spec_listen"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    move v2, v3

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v2, 0x1

    .line 181
    :goto_1
    const-string v4, "service.adb.listen_addrs\u0000"

    invoke-virtual {v1, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    if-eqz v2, :cond_3

    .line 183
    const-string v1, "SHA-256"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v0

    .line 184
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    array-length v2, v0

    :goto_2
    if-ge v3, v2, :cond_2

    aget-byte v4, v0, v3

    and-int/lit16 v4, v4, 0xff

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "%02x"

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 185
    :cond_2
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ADBD_SHA256="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 186
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BEFORE_ADBD=stopped\nBEFORE_ROOT_PROPERTY="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "service.adb.root"

    invoke-static {v2}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 187
    return-void

    .line 182
    :cond_3
    new-instance v0, Ljava/io/IOException;

    const-string v1, "ADB private-socket support could not be verified; no settings changed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 176
    :cond_4
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Expected ADB module is unavailable"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 174
    :cond_5
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Wireless debugging is enabled; temporary test skipped"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 173
    :cond_6
    new-instance v0, Ljava/io/IOException;

    const-string v1, "USB debugging endpoint is present; temporary test skipped"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 171
    :cond_7
    new-instance v0, Ljava/io/IOException;

    const-string v1, "ADB is already active; test skipped to preserve the existing connection"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 170
    :cond_8
    new-instance v0, Ljava/io/IOException;

    const-string v1, "This build does not report debugging support"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static printNetwork(Ljava/util/Properties;)V
    .locals 4

    .line 163
    const-string v0, "address"

    invoke-virtual {p0, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "prefix"

    invoke-virtual {p0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 164
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "LAN_STATE=on\nLAN_ENDPOINT="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x15b3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\nLAN_ALLOWED="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 165
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0

    invoke-static {v0, p0}, Lcom/torre/v6rootcheck/LanPolicy;->subnet(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object p0

    const-string p0, "none"

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "\nTRIAL_RESULT=Root ADB is on\nCLEANUP=active"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 164
    invoke-virtual {v1, p0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 167
    return-void
.end method

.method private static property(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 283
    const-string v0, "/system/bin/getprop"

    filled-new-array {v0, p0}, [Ljava/lang/String;

    move-result-object v0

    const-wide/16 v1, 0x7d0

    const/4 v3, 0x0

    invoke-static {v1, v2, v3, v0}, Lcom/torre/v6rootcheck/RootTrial;->execute(JLjava/lang/String;[Ljava/lang/String;)Lcom/torre/v6rootcheck/RootTrial$Result;

    move-result-object v0

    .line 284
    iget v1, v0, Lcom/torre/v6rootcheck/RootTrial$Result;->exit:I

    if-nez v1, :cond_0

    iget-object p0, v0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Could not read "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static query(Ljava/lang/String;)V
    .locals 6

    .line 191
    :try_start_0
    invoke-static {p0}, Lcom/torre/v6rootcheck/RootTrial;->validateSocket(Ljava/lang/String;)V

    .line 192
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    const-wide/16 v2, 0xfa0

    add-long/2addr v0, v2

    .line 193
    const/4 v2, 0x0

    .line 194
    :goto_0
    if-nez v2, :cond_0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    cmp-long v3, v3, v0

    if-gez v3, :cond_0

    .line 195
    new-instance v3, Landroid/net/LocalSocket;

    invoke-direct {v3}, Landroid/net/LocalSocket;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 196
    :try_start_1
    new-instance v4, Landroid/net/LocalSocketAddress;

    sget-object v5, Landroid/net/LocalSocketAddress$Namespace;->FILESYSTEM:Landroid/net/LocalSocketAddress$Namespace;

    invoke-direct {v4, p0, v5}, Landroid/net/LocalSocketAddress;-><init>(Ljava/lang/String;Landroid/net/LocalSocketAddress$Namespace;)V

    invoke-virtual {v3, v4}, Landroid/net/LocalSocket;->connect(Landroid/net/LocalSocketAddress;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 197
    move-object v2, v3

    goto :goto_1

    :catch_0
    move-exception v4

    :try_start_2
    invoke-virtual {v3}, Landroid/net/LocalSocket;->close()V

    const-wide/16 v3, 0x64

    invoke-static {v3, v4}, Landroid/os/SystemClock;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 198
    :goto_1
    goto :goto_0

    .line 199
    :cond_0
    if-eqz v2, :cond_4

    .line 200
    nop

    .line 201
    const/16 p0, 0xfa0

    :try_start_3
    invoke-virtual {v2, p0}, Landroid/net/LocalSocket;->setSoTimeout(I)V

    .line 202
    invoke-virtual {v2}, Landroid/net/LocalSocket;->getPeerCredentials()Landroid/net/Credentials;

    move-result-object p0

    invoke-virtual {p0}, Landroid/net/Credentials;->getUid()I

    move-result p0

    .line 203
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ADB_PEER_UID="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 204
    if-nez p0, :cond_2

    .line 205
    sget-object p0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v2}, Landroid/net/LocalSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v2}, Landroid/net/LocalSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    const-string v3, "printf \'ADB_SHELL_UID=\'; id -u; printf \'ADB_CONTEXT=\'; id -Z; printf \'SELINUX=\'; getenforce; printf \'SELINUX_ENFORCE=\'; cat /sys/fs/selinux/enforce; echo; for p in /dev/block/by-name/boot_a /dev/block/by-name/boot_b /dev/block/by-name/init_boot_a /dev/block/by-name/init_boot_b /dev/block/by-name/vbmeta_a /dev/block/by-name/vbmeta_b; do if [ -e \"$p\" ]; then r=no; w=no; [ -r \"$p\" ] && r=yes; [ -w \"$p\" ] && w=yes; printf \'%s read=%s write=%s\\n\' \"$p\" \"$r\" \"$w\"; fi; done"

    invoke-static {v0, v1, v3}, Lcom/torre/v6rootcheck/AdbWire;->shell(Ljava/io/InputStream;Ljava/io/OutputStream;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 206
    if-eqz v2, :cond_1

    :try_start_4
    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    .line 207
    :cond_1
    goto :goto_3

    .line 204
    :cond_2
    :try_start_5
    new-instance p0, Ljava/io/IOException;

    const-string v0, "ADB daemon is not root; no shell command sent"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 200
    :catchall_0
    move-exception p0

    if-eqz v2, :cond_3

    :try_start_6
    invoke-virtual {v2}, Landroid/net/LocalSocket;->close()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception v0

    :try_start_7
    invoke-virtual {p0, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_3
    :goto_2
    throw p0

    .line 199
    :cond_4
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Private ADB socket did not open; root may be unavailable or the vendor may block ADB"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1

    .line 207
    :catch_1
    move-exception p0

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ADB_ERROR="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/torre/v6rootcheck/RootTrial;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 208
    :goto_3
    return-void
.end method

.method private static readBounded(Ljava/io/File;I)[B
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 276
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    :try_start_0
    new-instance p0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p0}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 277
    const/16 v1, 0x2000

    :try_start_1
    new-array v1, v1, [B

    .line 278
    :goto_0
    invoke-virtual {v0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v3

    add-int/2addr v3, v2

    if-gt v3, p1, :cond_0

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/io/IOException;

    const-string v1, "Input exceeds limit"

    invoke-direct {p1, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 279
    :cond_1
    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 280
    :try_start_2
    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 279
    return-object p1

    .line 276
    :catchall_0
    move-exception p1

    :try_start_3
    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p0

    :try_start_4
    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    :catchall_2
    move-exception p0

    :try_start_5
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    goto :goto_2

    :catchall_3
    move-exception p1

    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_2
    throw p0
.end method

.method private static readSmall(Ljava/io/File;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 274
    new-instance v0, Ljava/lang/String;

    const/16 v1, 0x1000

    invoke-static {p0, v1}, Lcom/torre/v6rootcheck/RootTrial;->readBounded(Ljava/io/File;I)[B

    move-result-object p0

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    return-object v0
.end method

.method private static rejectSymlink(Ljava/io/File;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 259
    :try_start_0
    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Landroid/system/Os;->lstat(Ljava/lang/String;)Landroid/system/StructStat;

    move-result-object p0

    iget p0, p0, Landroid/system/StructStat;->st_mode:I

    invoke-static {p0}, Landroid/system/OsConstants;->S_ISLNK(I)Z

    move-result p0

    if-nez p0, :cond_0

    .line 260
    goto :goto_0

    .line 259
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Unexpected symbolic link"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_0
    .catch Landroid/system/ErrnoException; {:try_start_0 .. :try_end_0} :catch_0

    .line 260
    :catch_0
    move-exception p0

    iget v0, p0, Landroid/system/ErrnoException;->errno:I

    sget v1, Landroid/system/OsConstants;->ENOENT:I

    if-ne v0, v1, :cond_1

    .line 261
    :goto_0
    return-void

    .line 260
    :cond_1
    throw p0
.end method

.method private static restore()Z
    .locals 10

    .line 213
    const-string v0, "init.svc.adbd"

    const-string v1, "service.adb.listen_addrs"

    const-string v2, "stopped"

    :try_start_0
    invoke-static {}, Lcom/torre/v6rootcheck/RootTrial;->loadState()Ljava/util/Properties;

    move-result-object v3

    .line 214
    const-string v4, "socket"

    invoke-virtual {v3, v4}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->validateSocket(Ljava/lang/String;)V

    .line 215
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "localfilesystem:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 216
    const-string v6, "target"

    invoke-virtual {v3, v6}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 217
    new-instance v6, Ljava/io/File;

    const-string v7, "/proc/sys/kernel/random/boot_id"

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v6}, Lcom/torre/v6rootcheck/RootTrial;->readSmall(Ljava/io/File;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    .line 218
    const-string v7, "boot"

    invoke-virtual {v3, v7}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    const/4 v7, 0x1

    if-nez v6, :cond_0

    .line 219
    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->discardState(Ljava/lang/String;)V

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "CLEANUP=restored\nCLEANUP_DETAIL=Box restarted; temporary properties reset"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    return v7

    .line 221
    :cond_0
    const-string v6, "lan"

    const-string v8, "kind"

    invoke-virtual {v3, v8}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v6

    invoke-static {v6}, Lcom/torre/v6rootcheck/RootAdbRelay;->stop(Ljava/io/File;)V

    .line 222
    :cond_1
    invoke-static {v1}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 223
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v9, "listen"

    if-nez v8, :cond_3

    :try_start_1
    invoke-virtual {v3, v9}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    goto :goto_0

    .line 224
    :cond_2
    new-instance v0, Ljava/io/IOException;

    const-string v1, "ADB listener was changed by another process; refusing to overwrite it"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 225
    :cond_3
    :goto_0
    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_5

    .line 226
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 227
    const-string v5, "stop"

    invoke-static {v5}, Lcom/torre/v6rootcheck/RootTrial;->control(Ljava/lang/String;)V

    const/16 v5, 0xfa0

    invoke-static {v2, v5}, Lcom/torre/v6rootcheck/RootTrial;->waitState(Ljava/lang/String;I)V

    goto :goto_1

    .line 226
    :cond_4
    new-instance v0, Ljava/io/IOException;

    const-string v1, "An unrelated ADB service is active"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 229
    :cond_5
    :goto_1
    const-string v5, "service.adb.root"

    const-string v6, "root"

    invoke-virtual {v3, v6}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/torre/v6rootcheck/RootTrial;->setProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 230
    invoke-virtual {v3, v9}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/torre/v6rootcheck/RootTrial;->setProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 231
    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 232
    invoke-static {v4}, Lcom/torre/v6rootcheck/RootTrial;->discardState(Ljava/lang/String;)V

    .line 233
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "CLEANUP=restored\nAFTER_ADBD=stopped\nCLEANUP_DETAIL=Previous root and listener properties restored"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 234
    return v7

    .line 231
    :cond_6
    new-instance v0, Ljava/io/IOException;

    const-string v1, "ADB did not remain stopped"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 216
    :cond_7
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid journal address"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 235
    :catch_0
    move-exception v0

    .line 236
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CLEANUP=failed\nCLEANUP_ERROR="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    const/4 v0, 0x0

    return v0
.end method

.method private static rootQuery(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 126
    invoke-static {p1}, Lcom/torre/v6rootcheck/RootTrial;->validateSocket(Ljava/lang/String;)V

    .line 127
    const-class v0, Lcom/torre/v6rootcheck/RootTrial;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "query"

    const-string v2, "/system/bin/app_process"

    const-string v3, "/system/bin"

    filled-new-array {v2, v3, v0, v1, p1}, [Ljava/lang/String;

    move-result-object p1

    const-wide/16 v0, 0x36b0

    invoke-static {v0, v1, p0, p1}, Lcom/torre/v6rootcheck/RootTrial;->execute(JLjava/lang/String;[Ljava/lang/String;)Lcom/torre/v6rootcheck/RootTrial$Result;

    move-result-object p0

    .line 128
    sget-object p1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    iget-object v0, p0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 129
    iget p1, p0, Lcom/torre/v6rootcheck/RootTrial$Result;->exit:I

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    const-string v0, "ADB_PEER_UID"

    invoke-static {p1, v0}, Lcom/torre/v6rootcheck/ProbeLogic;->value(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "0"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p0, p0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    .line 130
    const-string p1, "ADB_SHELL_UID"

    invoke-static {p0, p1}, Lcom/torre/v6rootcheck/ProbeLogic;->value(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    .line 129
    :goto_0
    return p0
.end method

.method private static saveState(Ljava/util/Properties;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 263
    sget-object v0, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->rejectSymlink(Ljava/io/File;)V

    .line 264
    new-instance v0, Ljava/io/FileOutputStream;

    sget-object v1, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    :try_start_0
    const-string v1, "Temporary V6 root trial; no persistent debug settings changed"

    invoke-virtual {p0, v0, v1}, Ljava/util/Properties;->store(Ljava/io/OutputStream;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object p0

    invoke-virtual {p0}, Ljava/io/FileDescriptor;->sync()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    .line 265
    sget-object p0, Lcom/torre/v6rootcheck/RootTrial;->JOURNAL:Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p0

    const/16 v0, 0x180

    invoke-static {p0, v0}, Landroid/system/Os;->chmod(Ljava/lang/String;I)V

    .line 266
    return-void

    .line 264
    :catchall_0
    move-exception p0

    :try_start_1
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v0

    invoke-virtual {p0, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p0
.end method

.method private static setProperty(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 287
    const-string v0, "/system/bin/setprop"

    filled-new-array {v0, p0, p1}, [Ljava/lang/String;

    move-result-object v0

    const-wide/16 v1, 0x7d0

    const/4 v3, 0x0

    invoke-static {v1, v2, v3, v0}, Lcom/torre/v6rootcheck/RootTrial;->execute(JLjava/lang/String;[Ljava/lang/String;)Lcom/torre/v6rootcheck/RootTrial$Result;

    move-result-object v0

    .line 288
    iget v1, v0, Lcom/torre/v6rootcheck/RootTrial$Result;->exit:I

    if-nez v1, :cond_0

    invoke-static {p0}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 289
    return-void

    .line 288
    :cond_0
    new-instance p1, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Could not set "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, ": "

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    iget-object v0, v0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootTrial;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method static validateSocket(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 250
    if-eqz p0, :cond_0

    const-string v0, "/data/system/v6-pc-only-adb/t[0-9a-f]{32}/a"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    .line 251
    return-void

    .line 250
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Invalid private socket path"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static waitState(Ljava/lang/String;I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 295
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    int-to-long v2, p1

    add-long/2addr v0, v2

    .line 296
    :goto_0
    const-string p1, "init.svc.adbd"

    invoke-static {p1}, Lcom/torre/v6rootcheck/RootTrial;->property(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    return-void

    :cond_0
    const-wide/16 v2, 0x64

    invoke-static {v2, v3}, Landroid/os/SystemClock;->sleep(J)V

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    cmp-long p1, v2, v0

    if-gez p1, :cond_1

    goto :goto_0

    .line 297
    :cond_1
    new-instance p1, Ljava/io/IOException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ADB did not become "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
