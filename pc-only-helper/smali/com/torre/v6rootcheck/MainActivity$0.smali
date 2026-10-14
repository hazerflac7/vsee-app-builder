.class public final synthetic Lcom/torre/v6rootcheck/MainActivity$0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/MainActivity;"
    method = "lambda$capture$11"
    proto = "(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Ljava/lang/Process;

.field public final synthetic f$1:Ljava/io/ByteArrayOutputStream;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity$0;->f$0:Ljava/lang/Process;

    iput-object p2, p0, Lcom/torre/v6rootcheck/MainActivity$0;->f$1:Ljava/io/ByteArrayOutputStream;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$0;->f$0:Ljava/lang/Process;

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity$0;->f$1:Ljava/io/ByteArrayOutputStream;

    invoke-static {v0, v1}, Lcom/torre/v6rootcheck/MainActivity;->lambda$capture$11(Ljava/lang/Process;Ljava/io/ByteArrayOutputStream;)V

    return-void
.end method
