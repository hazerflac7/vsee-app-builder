.class public final synthetic Lcom/torre/v6rootcheck/MainActivity$11;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/View$OnKeyListener;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/MainActivity;"
    method = "lambda$onCreate$8"
    proto = "(Landroid/widget/ScrollView;Landroid/view/View;ILandroid/view/KeyEvent;)Z"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/torre/v6rootcheck/MainActivity;

.field public final synthetic f$1:Landroid/widget/ScrollView;


# direct methods
.method public synthetic constructor <init>(Lcom/torre/v6rootcheck/MainActivity;Landroid/widget/ScrollView;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/MainActivity$11;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    iput-object p2, p0, Lcom/torre/v6rootcheck/MainActivity$11;->f$1:Landroid/widget/ScrollView;

    return-void
.end method


# virtual methods
.method public final onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/MainActivity$11;->f$0:Lcom/torre/v6rootcheck/MainActivity;

    iget-object v1, p0, Lcom/torre/v6rootcheck/MainActivity$11;->f$1:Landroid/widget/ScrollView;

    invoke-virtual {v0, v1, p1, p2, p3}, Lcom/torre/v6rootcheck/MainActivity;->lambda$onCreate$8$com-torre-v6rootcheck-MainActivity(Landroid/widget/ScrollView;Landroid/view/View;ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method
