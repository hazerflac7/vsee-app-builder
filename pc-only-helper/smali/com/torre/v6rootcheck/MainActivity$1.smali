.class Lcom/torre/v6rootcheck/MainActivity$1;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/torre/v6rootcheck/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/torre/v6rootcheck/MainActivity;


# direct methods
.method constructor <init>(Lcom/torre/v6rootcheck/MainActivity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 56
    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity$1;->this$0:Lcom/torre/v6rootcheck/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 57
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$1;->this$0:Lcom/torre/v6rootcheck/MainActivity;

    invoke-static {v0}, Lcom/torre/v6rootcheck/MainActivity;->access$000(Lcom/torre/v6rootcheck/MainActivity;)V

    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$1;->this$0:Lcom/torre/v6rootcheck/MainActivity;

    invoke-static {v0}, Lcom/torre/v6rootcheck/MainActivity;->access$100(Lcom/torre/v6rootcheck/MainActivity;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x1f4

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
