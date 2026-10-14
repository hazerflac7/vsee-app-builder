.class final Lcom/torre/v6rootcheck/RootTrial$Result;
.super Ljava/lang/Object;
.source "RootTrial.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/torre/v6rootcheck/RootTrial;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Result"
.end annotation


# instance fields
.field final exit:I

.field final output:Ljava/lang/String;


# direct methods
.method constructor <init>(ILjava/lang/String;)V
    .locals 0

    .line 318
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/torre/v6rootcheck/RootTrial$Result;->exit:I

    iput-object p2, p0, Lcom/torre/v6rootcheck/RootTrial$Result;->output:Ljava/lang/String;

    return-void
.end method
