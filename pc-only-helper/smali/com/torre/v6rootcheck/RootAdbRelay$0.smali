.class public final synthetic Lcom/torre/v6rootcheck/RootAdbRelay$0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/torre/v6rootcheck/RootAdbRelay;"
    method = "close"
    proto = "()V"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/torre/v6rootcheck/RootAdbRelay;


# direct methods
.method public synthetic constructor <init>(Lcom/torre/v6rootcheck/RootAdbRelay;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/torre/v6rootcheck/RootAdbRelay$0;->f$0:Lcom/torre/v6rootcheck/RootAdbRelay;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/torre/v6rootcheck/RootAdbRelay$0;->f$0:Lcom/torre/v6rootcheck/RootAdbRelay;

    invoke-static {v0}, Lcom/torre/v6rootcheck/RootAdbRelay;->$r8$lambda$hfA7fy631-ooHlBP5BlHtKjKz78(Lcom/torre/v6rootcheck/RootAdbRelay;)V

    return-void
.end method
