.class public final synthetic Lcom/torre/v6rootcheck/MainActivity$2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/MainActivity;"
    method = "lambda$runChecks$10"
    proto = "(Ljava/lang/String;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/torre/v6rootcheck/MainActivity;

.field public final synthetic f$1:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lcom/torre/v6rootcheck/MainActivity;Ljava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity$2;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    iput-object p2, p0, Lcom/torre/v6rootcheck/MainActivity$2;->f$1:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$2;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity$2;->f$1:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/torre/v6rootcheck/MainActivity;->lambda$runChecks$10$com-torre-v6rootcheck-MainActivity(Ljava/lang/String;)V

    return-void
.end method
