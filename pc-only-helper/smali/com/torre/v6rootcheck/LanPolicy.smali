.class public final Lcom/torre/v6rootcheck/LanPolicy;
.super Ljava/lang/Object;
.source "LanPolicy.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static allows(Ljava/lang/String;ILjava/lang/String;)Z
    .locals 1

    # The public builder needs the protected local filesystem socket only.
    # Never forward a TCP client to root ADB, including a localhost client.
    const/4 v0, 0x0

    return v0
.end method

.method public static ipv4(Ljava/lang/String;)I
    .locals 6

    .line 6
    const-string v0, "\\."

    const/4 v1, -0x1

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object p0

    .line 7
    array-length v0, p0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_3

    .line 8
    nop

    .line 9
    array-length v0, p0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v1, v0, :cond_2

    aget-object v3, p0, v1

    .line 10
    const-string v4, "0|[1-9][0-9]{0,2}"

    invoke-virtual {v3, v4}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v4

    const-string v5, "Invalid IPv4 address"

    if-eqz v4, :cond_1

    .line 11
    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    .line 12
    const/16 v4, 0xff

    if-gt v3, v4, :cond_0

    .line 13
    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v2, v3

    .line 9
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 12
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 10
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 15
    :cond_2
    return v2

    .line 7
    :cond_3
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Expected an IPv4 address"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static mask(I)I
    .locals 1

    .line 24
    const/16 v0, 0x8

    if-lt p0, v0, :cond_0

    const/16 v0, 0x1e

    if-gt p0, v0, :cond_0

    .line 25
    rsub-int/lit8 p0, p0, 0x20

    const/4 v0, -0x1

    shl-int p0, v0, p0

    return p0

    .line 24
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Unsupported LAN prefix"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static privateAddress(Ljava/lang/String;)Z
    .locals 3

    .line 19
    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0}, Lcom/torre/v6rootcheck/LanPolicy;->ipv4(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 20
    ushr-int/lit8 v1, p0, 0x18

    const/16 v2, 0xa

    if-eq v1, v2, :cond_0

    ushr-int/lit8 v1, p0, 0x14

    const/16 v2, 0xac1

    if-eq v1, v2, :cond_0

    ushr-int/lit8 p0, p0, 0x10

    const v1, 0xc0a8

    if-ne p0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :cond_1
    return v0

    .line 21
    :catch_0
    move-exception p0

    return v0
.end method

.method public static subnet(Ljava/lang/String;I)Ljava/lang/String;
    .locals 3

    .line 33
    invoke-static {p0}, Lcom/torre/v6rootcheck/LanPolicy;->ipv4(Ljava/lang/String;)I

    move-result p0

    invoke-static {p1}, Lcom/torre/v6rootcheck/LanPolicy;->mask(I)I

    move-result v0

    and-int/2addr p0, v0

    .line 34
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    ushr-int/lit8 v1, p0, 0x18

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    ushr-int/lit8 v2, p0, 0x10

    and-int/lit16 v2, v2, 0xff

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    ushr-int/lit8 v2, p0, 0x8

    and-int/lit16 v2, v2, 0xff

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    and-int/lit16 p0, p0, 0xff

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "/"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    # No TCP client is allowed to reach the protected root socket.
    const-string p0, "none"

    return-object p0
.end method
