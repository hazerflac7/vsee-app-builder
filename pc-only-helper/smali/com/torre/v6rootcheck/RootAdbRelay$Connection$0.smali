.class public final synthetic Lcom/torre/v6rootcheck/RootAdbRelay$Connection$0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/RootAdbRelay$Connection;"
    method = "lambda$start$0"
    proto = "()V"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/torre/v6rootcheck/RootAdbRelay$Connection;


# direct methods
.method public synthetic constructor <init>(Lcom/torre/v6rootcheck/RootAdbRelay$Connection;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection$0;->f$0:Lcom/torre/v6rootcheck/RootAdbRelay$Connection;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$Connection$0;->f$0:Lcom/torre/v6rootcheck/RootAdbRelay$Connection;

    invoke-virtual {v0}, Lcom/torre/v6rootcheck/RootAdbRelay$Connection;->lambda$start$0$com-torre-v6rootcheck-RootAdbRelay$Connection()V

    return-void
.end method
