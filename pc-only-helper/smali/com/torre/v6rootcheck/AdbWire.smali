.class public final Lcom/torre/v6rootcheck/AdbWire;
.super Ljava/lang/Object;
.source "AdbWire.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/torre/v6rootcheck/AdbWire$Packet;
    }
.end annotation


# static fields
.field static final AUTH:I = 0x48545541

.field static final CLSE:I = 0x45534c43

.field static final CNXN:I = 0x4e584e43

.field static final OKAY:I = 0x59414b4f

.field static final OPEN:I = 0x4e45504f

.field static final WRTE:I = 0x45545257


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static readInt(Ljava/io/DataInputStream;)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 14
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readInt()I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->reverseBytes(I)I

    move-result p0

    return p0
.end method

.method private static receive(Ljava/io/DataInputStream;)Lcom/torre/v6rootcheck/AdbWire$Packet;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 25
    new-instance v0, Lcom/torre/v6rootcheck/AdbWire$Packet;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/torre/v6rootcheck/AdbWire$Packet;-><init>(Lcom/torre/v6rootcheck/AdbWire$1;)V

    invoke-static {p0}, Lcom/torre/v6rootcheck/AdbWire;->readInt(Ljava/io/DataInputStream;)I

    move-result v1

    iput v1, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    invoke-static {p0}, Lcom/torre/v6rootcheck/AdbWire;->readInt(Ljava/io/DataInputStream;)I

    move-result v1

    iput v1, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->a:I

    invoke-static {p0}, Lcom/torre/v6rootcheck/AdbWire;->readInt(Ljava/io/DataInputStream;)I

    move-result v1

    iput v1, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->b:I

    .line 26
    invoke-static {p0}, Lcom/torre/v6rootcheck/AdbWire;->readInt(Ljava/io/DataInputStream;)I

    move-result v1

    invoke-static {p0}, Lcom/torre/v6rootcheck/AdbWire;->readInt(Ljava/io/DataInputStream;)I

    move-result v2

    invoke-static {p0}, Lcom/torre/v6rootcheck/AdbWire;->readInt(Ljava/io/DataInputStream;)I

    move-result v3

    .line 27
    iget v4, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    not-int v4, v4

    if-ne v3, v4, :cond_2

    if-ltz v1, :cond_2

    const/high16 v3, 0x10000

    if-gt v1, v3, :cond_2

    .line 28
    new-array v1, v1, [B

    iput-object v1, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->data:[B

    iget-object v1, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->data:[B

    invoke-virtual {p0, v1}, Ljava/io/DataInputStream;->readFully([B)V

    .line 29
    iget-object p0, v0, Lcom/torre/v6rootcheck/AdbWire$Packet;->data:[B

    array-length v1, p0

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v3, v1, :cond_0

    aget-byte v5, p0, v3

    and-int/lit16 v5, v5, 0xff

    add-int/2addr v4, v5

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 30
    :cond_0
    if-ne v4, v2, :cond_1

    .line 31
    return-object v0

    .line 30
    :cond_1
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Invalid ADB checksum"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 27
    :cond_2
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Invalid ADB packet"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method static send(Ljava/io/OutputStream;III[B)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 19
    array-length v0, p4

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v1, v0, :cond_0

    aget-byte v3, p4, v1

    and-int/lit16 v3, v3, 0xff

    add-int/2addr v2, v3

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 20
    :cond_0
    invoke-static {p0, p1}, Lcom/torre/v6rootcheck/AdbWire;->writeInt(Ljava/io/OutputStream;I)V

    invoke-static {p0, p2}, Lcom/torre/v6rootcheck/AdbWire;->writeInt(Ljava/io/OutputStream;I)V

    invoke-static {p0, p3}, Lcom/torre/v6rootcheck/AdbWire;->writeInt(Ljava/io/OutputStream;I)V

    .line 21
    array-length p2, p4

    invoke-static {p0, p2}, Lcom/torre/v6rootcheck/AdbWire;->writeInt(Ljava/io/OutputStream;I)V

    invoke-static {p0, v2}, Lcom/torre/v6rootcheck/AdbWire;->writeInt(Ljava/io/OutputStream;I)V

    not-int p1, p1

    invoke-static {p0, p1}, Lcom/torre/v6rootcheck/AdbWire;->writeInt(Ljava/io/OutputStream;I)V

    .line 22
    invoke-virtual {p0, p4}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {p0}, Ljava/io/OutputStream;->flush()V

    .line 23
    return-void
.end method

.method public static shell(Ljava/io/InputStream;Ljava/io/OutputStream;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 34
    new-instance v0, Ljava/io/DataInputStream;

    invoke-direct {v0, p0}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 35
    const-string p0, "host::\u0000"

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    const v1, 0x4e584e43    # 9.072519E8f

    const/high16 v2, 0x1000000

    const/16 v3, 0x1000

    invoke-static {p1, v1, v2, v3, p0}, Lcom/torre/v6rootcheck/AdbWire;->send(Ljava/io/OutputStream;III[B)V

    .line 36
    invoke-static {v0}, Lcom/torre/v6rootcheck/AdbWire;->receive(Ljava/io/DataInputStream;)Lcom/torre/v6rootcheck/AdbWire$Packet;

    move-result-object p0

    .line 37
    iget v4, p0, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    const v5, 0x48545541

    if-eq v4, v5, :cond_9

    .line 38
    iget v4, p0, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    if-ne v4, v1, :cond_8

    iget p0, p0, Lcom/torre/v6rootcheck/AdbWire$Packet;->a:I

    if-lt p0, v2, :cond_8

    .line 39
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "shell:"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p2, "\u0000"

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    sget-object p2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, p2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    .line 40
    array-length p2, p0

    if-gt p2, v3, :cond_7

    .line 41
    const p2, 0x4e45504f    # 8.2759366E8f

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {p1, p2, v1, v2, p0}, Lcom/torre/v6rootcheck/AdbWire;->send(Ljava/io/OutputStream;III[B)V

    .line 42
    new-instance p0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 43
    move p2, v2

    move v3, p2

    :goto_0
    const/16 v4, 0x200

    if-ge p2, v4, :cond_6

    .line 44
    invoke-static {v0}, Lcom/torre/v6rootcheck/AdbWire;->receive(Ljava/io/DataInputStream;)Lcom/torre/v6rootcheck/AdbWire$Packet;

    move-result-object v4

    .line 45
    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    const v6, 0x45534c43

    if-ne v5, v6, :cond_1

    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->b:I

    if-ne v5, v1, :cond_1

    .line 46
    if-eqz v3, :cond_0

    iget p2, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->a:I

    if-ne p2, v3, :cond_0

    .line 47
    new-array p2, v2, [B

    invoke-static {p1, v6, v1, v3, p2}, Lcom/torre/v6rootcheck/AdbWire;->send(Ljava/io/OutputStream;III[B)V

    .line 48
    const-string p1, "UTF-8"

    invoke-virtual {p0, p1}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 46
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string p1, "ADB refused or closed the shell"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 50
    :cond_1
    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->b:I

    if-ne v5, v1, :cond_5

    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->a:I

    if-eqz v5, :cond_5

    .line 51
    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    const v6, 0x59414b4f

    if-ne v5, v6, :cond_2

    if-nez v3, :cond_2

    iget v3, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->a:I

    goto :goto_1

    .line 52
    :cond_2
    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->command:I

    const v7, 0x45545257

    if-ne v5, v7, :cond_4

    iget v5, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->a:I

    if-ne v3, v5, :cond_4

    .line 53
    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v5

    iget-object v7, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->data:[B

    array-length v7, v7

    add-int/2addr v5, v7

    const/16 v7, 0x3e80

    if-gt v5, v7, :cond_3

    .line 54
    iget-object v4, v4, Lcom/torre/v6rootcheck/AdbWire$Packet;->data:[B

    invoke-virtual {p0, v4}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 55
    new-array v4, v2, [B

    invoke-static {p1, v6, v1, v3, v4}, Lcom/torre/v6rootcheck/AdbWire;->send(Ljava/io/OutputStream;III[B)V

    .line 43
    :goto_1
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 53
    :cond_3
    new-instance p0, Ljava/io/IOException;

    const-string p1, "ADB report exceeds limit"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 52
    :cond_4
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Unexpected ADB response"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 50
    :cond_5
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Unexpected ADB stream"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 57
    :cond_6
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Too many ADB packets"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 40
    :cond_7
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Command too long"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 38
    :cond_8
    new-instance p0, Ljava/io/IOException;

    const-string p1, "ADB handshake failed"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 37
    :cond_9
    new-instance p0, Ljava/io/IOException;

    const-string p1, "ADB requires authorization; no authorization settings were changed"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static writeInt(Ljava/io/OutputStream;I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 16
    const/4 v0, 0x0

    :goto_0
    const/4 v1, 0x4

    if-ge v0, v1, :cond_0

    mul-int/lit8 v1, v0, 0x8

    ushr-int v1, p1, v1

    invoke-virtual {p0, v1}, Ljava/io/OutputStream;->write(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 17
    :cond_0
    return-void
.end method
