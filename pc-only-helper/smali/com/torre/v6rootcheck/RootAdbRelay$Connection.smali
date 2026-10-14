.class final Lcom/torre/v6rootcheck/RootAdbRelay$Connection;
.super Ljava/lang/Object;
.source "RootAdbRelay.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/torre/v6rootcheck/RootAdbRelay;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "Connection"
.end annotation


# instance fields
.field volatile done:Z

.field volatile local:Landroid/net/LocalSocket;

.field final path:Ljava/lang/String;

.field final tcp:Ljava/net/Socket;

.field final synthetic this$0:Lcom/torre/v6rootcheck/RootAdbRelay;


# direct methods
.method constructor <init>(Lcom/torre/v6rootcheck/RootAdbRelay;Ljava/net/Socket;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010,
            0x0,
            0x0
        }
        names = {
            null,
            null,
            null
        }
    .end annotation

    .line 67
    iput-object p1, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->this$0:Lcom/torre/v6rootcheck/RootAdbRelay;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->tcp:Ljava/net/Socket;

    iput-object p3, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->path:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method close()V
    .locals 1

    .line 85
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->done:Z

    .line 86
    :try_start_0
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->tcp:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 87
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    .line 88
    :cond_0
    :goto_1
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->this$0:Lcom/torre/v6rootcheck/RootAdbRelay;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->access$000(Lcom/torre/v6rootcheck/RootAdbRelay;)Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0, p0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 89
    return-void
.end method

.method synthetic lambda$start$0$com-torre-v6rootcheck-RootAdbRelay$Connection()V
    .locals 2

    .line 76
    :try_start_0
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->tcp:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    iget-object v1, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    invoke-virtual {v1}, Landroid/net/LocalSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/torre/v6rootcheck/RootAdbRelay;->access$200(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->close()V

    throw v0

    :catch_0
    move-exception v0

    :goto_0
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->close()V

    .line 77
    return-void
.end method

.method synthetic lambda$start$1$com-torre-v6rootcheck-RootAdbRelay$Connection()V
    .locals 4

    .line 71
    :try_start_0
    new-instance v0, Landroid/net/LocalSocket;

    invoke-direct {v0}, Landroid/net/LocalSocket;-><init>()V

    iput-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    .line 72
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    new-instance v1, Landroid/net/LocalSocketAddress;

    iget-object v2, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->path:Ljava/lang/String;

    sget-object v3, Landroid/net/LocalSocketAddress$Namespace;->FILESYSTEM:Landroid/net/LocalSocketAddress$Namespace;

    invoke-direct {v1, v2, v3}, Landroid/net/LocalSocketAddress;-><init>(Ljava/lang/String;Landroid/net/LocalSocketAddress$Namespace;)V

    invoke-virtual {v0, v1}, Landroid/net/LocalSocket;->connect(Landroid/net/LocalSocketAddress;)V

    .line 73
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->getPeerCredentials()Landroid/net/Credentials;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Credentials;->getUid()I

    move-result v0

    if-nez v0, :cond_2

    .line 74
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->this$0:Lcom/torre/v6rootcheck/RootAdbRelay;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->access$100(Lcom/torre/v6rootcheck/RootAdbRelay;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->done:Z

    if-eqz v0, :cond_0

    goto :goto_0

    .line 75
    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/torre/v6rootcheck/RootAdbRelay$Connection$0;

    invoke-direct {v1, p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection$0;-><init>(Lcom/torre/v6rootcheck/RootAdbRelay$Connection;)V

    const-string v2, "v6-adb-to-box"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 78
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 79
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->local:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    iget-object v1, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->tcp:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/torre/v6rootcheck/RootAdbRelay;->access$200(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    .line 80
    :cond_1
    :goto_0
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->close()V

    .line 74
    return-void

    .line 73
    :cond_2
    :try_start_1
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Private ADB peer is not root"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 80
    :catchall_0
    move-exception v0

    invoke-virtual {p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->close()V

    throw v0

    :catch_0
    move-exception v0

    :goto_1
    invoke-virtual {p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->close()V

    .line 81
    return-void
.end method

.method start()V
    .locals 3

    .line 69
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/torre/v6rootcheck/RootAdbRelay$Connection$1;

    invoke-direct {v1, p0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection$1;-><init>(Lcom/torre/v6rootcheck/RootAdbRelay$Connection;)V

    const-string v2, "v6-adb-to-client"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 82
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 83
    return-void
.end method
