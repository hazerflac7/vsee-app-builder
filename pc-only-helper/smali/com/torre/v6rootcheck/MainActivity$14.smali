.class public final synthetic Lcom/torre/v6rootcheck/MainActivity$14;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/MainActivity;"
    method = "lambda$runChecks$9"
    proto = "()V"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/torre/v6rootcheck/MainActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/torre/v6rootcheck/MainActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity$14;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$14;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    invoke-virtual {v0}, Lcom/torre/v6rootcheck/MainActivity;->lambda$runChecks$9$com-torre-v6rootcheck-MainActivity()V

    return-void
.end method
