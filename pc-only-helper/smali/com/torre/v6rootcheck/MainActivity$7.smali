.class public final synthetic Lcom/torre/v6rootcheck/MainActivity$7;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/MainActivity;"
    method = "lambda$onCreate$4"
    proto = "(Landroid/view/View;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/torre/v6rootcheck/MainActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/torre/v6rootcheck/MainActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity$7;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$7;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    invoke-virtual {v0, p1}, Lcom/torre/v6rootcheck/MainActivity;->lambda$onCreate$4$com-torre-v6rootcheck-MainActivity(Landroid/view/View;)V

    return-void
.end method
