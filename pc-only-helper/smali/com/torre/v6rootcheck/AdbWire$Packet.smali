.class final Lcom/torre/v6rootcheck/AdbWire$Packet;
.super Ljava/lang/Object;
.source "AdbWire.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/torre/v6rootcheck/AdbWire;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Packet"
.end annotation


# instance fields
.field a:I

.field b:I

.field command:I

.field data:[B


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/torre/v6rootcheck/AdbWire$1;)V
    .locals 0

    .line 59
    invoke-direct {p0}, Lcom/torre/v6rootcheck/AdbWire$Packet;-><init>()V

    return-void
.end method
