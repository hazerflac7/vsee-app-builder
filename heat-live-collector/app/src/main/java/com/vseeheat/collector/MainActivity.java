package com.vseeheat.collector;

import android.app.Activity;
import android.app.Dialog;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.StateListDrawable;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** Local TV flow for selected, verified source app owner builds. */
public final class MainActivity extends Activity {
    private static final String[] APP_LABELS = {"Heat Live", "HeatVod", "Vod Ultra",
            "HeatLive Backup", "Live Ultra", "Live Ultra+"};
    // A changed notice must be accepted again, including after an in-place update.
    private static final String AGREEMENT_PREF = "testing_terms_v2_accepted";
    private static final String AGREEMENT_TIME_PREF = "testing_terms_v2_accepted_at";
    private static final String BUILDER_STATUS_PREF = "builder_status";
    private final ExecutorService worker = Executors.newSingleThreadExecutor();
    private TextView status;
    private TextView heroTitle;
    private TextView heroBody;
    private TextView progress;
    private Button checkButton;
    private Button makeButton;
    private TextView buildStatus;
    private ProgressBar workProgress;
    private final TextView[] appStates = new TextView[6];
    private final TextView[] appNames = new TextView[6];
    private final LinearLayout[] appTiles = new LinearLayout[6];
    private final boolean[] matched = new boolean[6];
    private final boolean[] selected = new boolean[6];
    private boolean[] buildSelection;
    private int verifiedUid = -1;
    private boolean fullReady;
    private boolean busy;
    private boolean exported;
    private boolean buildAfterCollect;

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        buildScreen();
        refreshButtons();
        checkButton.requestFocus();
        if (!getPreferences(MODE_PRIVATE).getBoolean(AGREEMENT_PREF, false)) {
            showDisclaimer();
        }
    }

    private void buildScreen() {
        ScrollView scroll = new ScrollView(this);
        scroll.setFillViewport(true);
        scroll.setBackground(new GradientDrawable(GradientDrawable.Orientation.TL_BR,
                new int[]{Color.rgb(18, 27, 43), Color.rgb(10, 17, 29)}));

        LinearLayout content = new LinearLayout(this);
        content.setOrientation(LinearLayout.VERTICAL);
        content.setGravity(Gravity.CENTER);
        content.setPadding(dp(16), dp(16), dp(16), dp(16));
        scroll.addView(content);
        setContentView(scroll);

        LinearLayout page = new LinearLayout(this);
        page.setOrientation(LinearLayout.HORIZONTAL);
        page.setBackground(roundRect(Color.rgb(18, 28, 44), Color.rgb(31, 48, 69), 18));
        int available = getResources().getDisplayMetrics().widthPixels - dp(32);
        content.addView(page, new LinearLayout.LayoutParams(Math.min(dp(1100), available),
                LinearLayout.LayoutParams.WRAP_CONTENT));

        LinearLayout rail = new LinearLayout(this);
        rail.setOrientation(LinearLayout.VERTICAL);
        rail.setGravity(Gravity.CENTER_HORIZONTAL);
        rail.setPadding(dp(8), dp(20), dp(8), dp(18));
        rail.setBackground(roundRect(Color.rgb(34, 49, 74), Color.rgb(34, 49, 74), 18));
        page.addView(rail, new LinearLayout.LayoutParams(dp(78),
                LinearLayout.LayoutParams.MATCH_PARENT));
        ImageView mark = new ImageView(this);
        mark.setImageResource(R.drawable.app_icon);
        rail.addView(mark, new LinearLayout.LayoutParams(dp(47), dp(47)));
        TextView railBrand = add(rail, "VSEE\nAPP\nBUILDER", 11,
                Color.rgb(172, 210, 226), 0);
        railBrand.setGravity(Gravity.CENTER);
        railBrand.setTypeface(null, Typeface.BOLD);
        railBrand.setLetterSpacing(0.12f);
        LinearLayout.LayoutParams railBrandLayout = (LinearLayout.LayoutParams)
                railBrand.getLayoutParams();
        railBrandLayout.topMargin = dp(98);
        railBrand.setLayoutParams(railBrandLayout);

        LinearLayout body = new LinearLayout(this);
        body.setOrientation(LinearLayout.VERTICAL);
        body.setPadding(dp(32), dp(23), dp(32), dp(23));
        page.addView(body, new LinearLayout.LayoutParams(0,
                LinearLayout.LayoutParams.WRAP_CONTENT, 1));

        LinearLayout header = new LinearLayout(this);
        header.setOrientation(LinearLayout.HORIZONTAL);
        header.setGravity(Gravity.CENTER_VERTICAL);
        body.addView(header, new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT));
        LinearLayout heading = new LinearLayout(this);
        heading.setOrientation(LinearLayout.VERTICAL);
        header.addView(heading, new LinearLayout.LayoutParams(0,
                LinearLayout.LayoutParams.WRAP_CONTENT, 1));
        TextView source = add(heading, "SOURCE: THIS V6", 10,
                Color.rgb(100, 211, 201), 3);
        source.setTypeface(null, Typeface.BOLD);
        source.setLetterSpacing(0.1f);
        TextView title = add(heading, "Six original apps", 25, Color.WHITE, 0);
        title.setTypeface(null, Typeface.BOLD);
        TextView edition = new TextView(this);
        edition.setText("V6 PRO");
        edition.setTextColor(Color.rgb(154, 171, 198));
        edition.setTextSize(10);
        edition.setTypeface(null, Typeface.BOLD);
        edition.setLetterSpacing(0.12f);
        header.addView(edition);
        add(body, "Compatibility results appear here after the check.", 12,
                Color.rgb(155, 173, 195), 19);

        for (int rowIndex = 0; rowIndex < 2; rowIndex++) {
            LinearLayout row = new LinearLayout(this);
            row.setOrientation(LinearLayout.HORIZONTAL);
            LinearLayout.LayoutParams rowLayout = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT, dp(94));
            rowLayout.bottomMargin = dp(10);
            body.addView(row, rowLayout);
            for (int col = 0; col < 3; col++) {
                int index = rowIndex * 3 + col;
                LinearLayout tile = new LinearLayout(this);
                tile.setOrientation(LinearLayout.VERTICAL);
                tile.setGravity(Gravity.CENTER_VERTICAL);
                tile.setPadding(dp(14), dp(8), dp(12), dp(8));
                tile.setBackground(roundRect(Color.rgb(31, 45, 64),
                        Color.rgb(59, 80, 106), 9));
                LinearLayout.LayoutParams tileLayout = new LinearLayout.LayoutParams(
                        0, LinearLayout.LayoutParams.MATCH_PARENT, 1);
                if (col != 2) tileLayout.rightMargin = dp(10);
                row.addView(tile, tileLayout);
                TextView appName = add(tile, APP_LABELS[index], 15, Color.WHITE, 15);
                appName.setTypeface(null, Typeface.BOLD);
                appNames[index] = appName;
                TextView tileState = add(tile, "NOT CHECKED", 10,
                        Color.rgb(147, 171, 195), 0);
                tileState.setTypeface(null, Typeface.BOLD);
                tileState.setLetterSpacing(0.06f);
                tileState.setMaxLines(2);
                appStates[index] = tileState;
                appTiles[index] = tile;
                tile.setFocusable(true);
                tile.setClickable(true);
                tile.setOnClickListener(view -> toggleSelection(index));
                tile.setOnFocusChangeListener((view, focused) -> refreshTile(index));
            }
        }

        LinearLayout bottom = new LinearLayout(this);
        bottom.setOrientation(LinearLayout.HORIZONTAL);
        bottom.setGravity(Gravity.BOTTOM);
        LinearLayout.LayoutParams bottomLayout = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        bottomLayout.topMargin = dp(24);
        body.addView(bottom, bottomLayout);
        LinearLayout messages = new LinearLayout(this);
        messages.setOrientation(LinearLayout.VERTICAL);
        LinearLayout.LayoutParams messageLayout = new LinearLayout.LayoutParams(0,
                LinearLayout.LayoutParams.WRAP_CONTENT, 1);
        messageLayout.rightMargin = dp(18);
        bottom.addView(messages, messageLayout);
        progress = add(messages, "STATUS", 10, Color.rgb(100, 211, 201), 9);
        progress.setTypeface(null, Typeface.BOLD);
        progress.setLetterSpacing(0.11f);
        heroTitle = add(messages, "Ready to check this V6.", 15, Color.WHITE, 5);
        heroTitle.setTypeface(null, Typeface.BOLD);
        heroBody = add(messages, "Check the apps, then choose which APKs to make.", 12,
                Color.rgb(166, 182, 204), 6);
        heroBody.setMaxLines(3);
        status = add(messages, "", 11, Color.rgb(255, 178, 166), 5);
        status.setVisibility(View.GONE);
        status.setMaxLines(6);
        buildStatus = add(messages, "", 11, Color.rgb(255, 178, 166), 5);
        buildStatus.setVisibility(View.GONE);
        workProgress = new ProgressBar(this, null,
                android.R.attr.progressBarStyleHorizontal);
        workProgress.setMax(8);
        workProgress.setProgressTintList(ColorStateList.valueOf(Color.rgb(100, 211, 201)));
        workProgress.setProgressBackgroundTintList(
                ColorStateList.valueOf(Color.rgb(48, 65, 89)));
        messages.addView(workProgress, new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, dp(5)));
        workProgress.setVisibility(View.GONE);

        LinearLayout controls = new LinearLayout(this);
        controls.setOrientation(LinearLayout.HORIZONTAL);
        bottom.addView(controls, new LinearLayout.LayoutParams(0, dp(67), 1));
        checkButton = addButton(controls, "1   Check compatibility");
        LinearLayout.LayoutParams checkLayout = (LinearLayout.LayoutParams)
                checkButton.getLayoutParams();
        checkLayout.width = 0;
        checkLayout.height = dp(67);
        checkLayout.weight = 1;
        checkLayout.rightMargin = dp(8);
        checkLayout.bottomMargin = 0;
        checkButton.setLayoutParams(checkLayout);
        checkButton.setTextSize(14);
        checkButton.setOnClickListener(view -> inspect());
        makeButton = addButton(controls, "2   Make APKs");
        LinearLayout.LayoutParams makeLayout = (LinearLayout.LayoutParams)
                makeButton.getLayoutParams();
        makeLayout.width = 0;
        makeLayout.height = dp(67);
        makeLayout.weight = 1;
        makeLayout.bottomMargin = 0;
        makeButton.setLayoutParams(makeLayout);
        makeButton.setTextSize(14);
        makeButton.setOnClickListener(view -> makeApks());

        TextView byline = add(body, "BY TORR3NT'S TECH  ·  SELECTED FILES TO DOWNLOADS", 10,
                Color.rgb(128, 151, 181), 0);
        byline.setLetterSpacing(0.07f);
        LinearLayout.LayoutParams bylineLayout = (LinearLayout.LayoutParams)
                byline.getLayoutParams();
        bylineLayout.topMargin = dp(14);
        byline.setLayoutParams(bylineLayout);
    }

    private void showDisclaimer() {
        Dialog dialog = new Dialog(this);
        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        box.setPadding(dp(30), dp(27), dp(30), dp(28));
        box.setBackground(roundRect(Color.rgb(24, 39, 50),
                Color.rgb(55, 112, 121), 20));

        TextView label = add(box, "TESTING ONLY  /  ACCOUNT RISK", 14,
                Color.rgb(113, 225, 214), 12);
        label.setTypeface(null, Typeface.BOLD);
        label.setLetterSpacing(0.13f);
        TextView heading = add(box, "Read before using this builder", 29,
                Color.WHITE, 13);
        heading.setTypeface(null, Typeface.BOLD);
        add(box, "Vsee App Builder is an experimental testing tool. It uses information "
                        + "from this V6 to make selected modified app files. Use it only for lawful "
                        + "tests on devices and apps you own or are authorized to manage. "
                        + "We recommend that you do not use it with any vSeeBox or Heat account "
                        + "or service unless the provider has expressly authorized your test.",
                18, Color.rgb(215, 211, 220), 13);
        add(box, "Using this builder or its APKs may violate service terms or law. "
                        + "Your account or device access could be suspended or permanently "
                        + "banned. Apps may stop working, and installing a generated file may "
                        + "erase existing app data. You are responsible for deciding whether "
                        + "your use is permitted and for the consequences.",
                17, Color.rgb(189, 187, 202), 13);
        add(box, "TORR3NT's Tech provides this preview and its output AS IS, without "
                        + "warranties. To the fullest extent permitted by applicable law, "
                        + "TORR3NT's Tech disclaims liability for account action, lost service, "
                        + "data loss, or other damages arising from use. This notice does not "
                        + "limit liability that the law does not allow us to exclude.",
                17, Color.rgb(189, 187, 202), 17);

        CheckBox agreement = new CheckBox(this);
        agreement.setText("I have read and agree to these testing-only terms. "
                + "I understand that my account could be banned and accept responsibility "
                + "for my use.");
        agreement.setTextSize(18);
        agreement.setTextColor(Color.WHITE);
        agreement.setButtonTintList(new ColorStateList(
                new int[][]{new int[]{android.R.attr.state_checked}, new int[]{}},
                new int[]{Color.rgb(97, 219, 209), Color.rgb(202, 199, 211)}));
        LinearLayout.LayoutParams agreeLayout = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT);
        agreeLayout.bottomMargin = dp(18);
        box.addView(agreement, agreeLayout);

        Button continueButton = addButton(box, "I agree — continue");
        LinearLayout.LayoutParams continueLayout = (LinearLayout.LayoutParams)
                continueButton.getLayoutParams();
        continueLayout.width = LinearLayout.LayoutParams.MATCH_PARENT;
        continueLayout.height = dp(62);
        continueButton.setLayoutParams(continueLayout);
        continueButton.setEnabled(false);
        agreement.setOnCheckedChangeListener((button, checked) ->
                continueButton.setEnabled(checked));
        continueButton.setOnClickListener(view -> {
            if (!agreement.isChecked()) return;
            boolean saved = getPreferences(MODE_PRIVATE).edit()
                    .putBoolean(AGREEMENT_PREF, true)
                    .putLong(AGREEMENT_TIME_PREF, System.currentTimeMillis())
                    .commit();
            if (!saved) {
                Toast.makeText(this, "Could not save agreement. Please try again.",
                        Toast.LENGTH_LONG).show();
                return;
            }
            dialog.dismiss();
            checkButton.requestFocus();
        });
        ScrollView noticeScroll = new ScrollView(this);
        noticeScroll.setFillViewport(false);
        noticeScroll.addView(box);
        dialog.setContentView(noticeScroll);
        dialog.setCancelable(true);
        dialog.setCanceledOnTouchOutside(false);
        dialog.setOnCancelListener(ignored -> finish());
        dialog.show();
        if (dialog.getWindow() != null) {
            dialog.getWindow().setBackgroundDrawableResource(android.R.color.transparent);
            dialog.getWindow().addFlags(android.view.WindowManager.LayoutParams.FLAG_DIM_BEHIND);
            android.view.WindowManager.LayoutParams attributes = dialog.getWindow().getAttributes();
            attributes.width = Math.min(dp(760), getResources().getDisplayMetrics().widthPixels
                    - dp(40));
            attributes.height = Math.min(dp(650),
                    getResources().getDisplayMetrics().heightPixels - dp(40));
            attributes.dimAmount = 0.82f;
            dialog.getWindow().setAttributes(attributes);
        }
        agreement.requestFocus();
    }

    private void makeApks() {
        if (busy || verifiedUid < 0 || selectedCount() == 0) return;
        buildSelection = selected.clone();
        int count = selectedCount();
        recordStage("MAKE_PRESSED");
        exported = false;
        buildStatus.setVisibility(View.GONE);
        busy = true;
        refreshButtons();
        workProgress.setVisibility(View.VISIBLE);
        workProgress.setMax(2 + count);
        workProgress.setProgress(0);
        workProgress.setIndeterminate(true);
        heroTitle.setText("Preparing " + apkCountLabel(count) + "…");
        heroBody.setText("Starting V6 access. This may take a moment.");
        progress.setText("STARTING V6 ACCESS");
        worker.execute(() -> {
            String failure = null;
            try {
                EmbeddedRootAdb.ensure(getApplicationContext(), message ->
                        runOnUiThread(() -> {
                            if (!isFinishing() && !isDestroyed()) heroBody.setText(message);
                        }));
            } catch (HeatLiveApkBuilder.BuildFailure error) {
                failure = error.stage;
            }
            final String stage = failure;
            runOnUiThread(() -> {
                if (isFinishing() || isDestroyed()) return;
                if (stage != null) {
                    recordStage(stage);
                    busy = false;
                    workProgress.setIndeterminate(false);
                    workProgress.setVisibility(View.GONE);
                    heroTitle.setText("V6 access needs attention [" + stage + "]");
                    heroBody.setText("The app could not start its protected V6 access. "
                            + "Check the V6 connection and try again.");
                    progress.setText("STARTUP NEEDS ATTENTION [" + stage + "]");
                    buildStatus.setText("No APKs were made. [" + stage + "]");
                    buildStatus.setVisibility(View.VISIBLE);
                    refreshButtons();
                    return;
                }
                workProgress.setIndeterminate(false);
                workProgress.setProgress(1);
                recordStage("ADB_READY");
                busy = false;
                if (fullReady) {
                    buildApk();
                } else {
                    buildAfterCollect = true;
                    collect();
                }
            });
        });
    }

    private void inspect() {
        verifiedUid = -1;
        for (int index = 0; index < selected.length; index++) {
            selected[index] = false;
            matched[index] = false;
        }
        busy = true;
        refreshButtons();
        heroTitle.setText("Checking compatibility…");
        heroBody.setText("Checking this V6 and all six installed apps.");
        status.setVisibility(View.GONE);
        for (int index = 0; index < appStates.length; index++) {
            setAppState(index, "CHECKING…", false);
        }
        worker.execute(new Runnable() {
            @Override public void run() {
                CompatibilityUpdates.refreshAndPrepare(getApplicationContext());
                final HeatLiveGate.Result result = HeatLiveGate.inspect(getApplicationContext());
                final OtherHeatGate.Status[] others = OtherHeatGate.inspectAll(
                        getApplicationContext());
                final boolean ready = result.supported();
                boolean full = false;
                if (result.supported()) {
                    try {
                        full = PrivateProfileStore.loadFull(getApplicationContext(),
                                result.originalUid) != null;
                    } catch (Exception ignored) { /* protected data may be absent */ }
                }
                final boolean hasFull = full;
                runOnUiThread(new Runnable() {
                    @Override public void run() {
                        if (isFinishing() || isDestroyed()) return;
                        verifiedUid = ready ? result.originalUid : -1;
                        fullReady = hasFull;
                        busy = false;
                        matched[0] = result.supported();
                        selected[0] = ready;
                        setAppState(0, result.supported() ? "MATCHED"
                                : heatLiveReason(result), result.supported());
                        for (int index = 0; index < others.length; index++) {
                            OtherHeatGate.Status other = others[index];
                            matched[index + 1] = other.supported();
                            selected[index + 1] = ready && other.supported();
                            setAppState(index + 1, other.supported() ? "MATCHED"
                                    : other.reason(), other.supported());
                        }
                        status.setVisibility(View.GONE);
                        if (ready) {
                            int count = selectedCount();
                            heroTitle.setText(count + " compatible "
                                    + (count == 1 ? "app" : "apps") + " selected");
                            heroBody.setText("Press OK on a matched tile to add or remove it. "
                                    + "Only selected apps will be saved in Downloads.");
                            progress.setText("STEP 2 OF 2  /  " + count + " APPS SELECTED");
                        } else {
                            heroTitle.setText("Heat Live setup needs attention");
                            heroBody.setText(result.trustedUpdateDetected()
                                    ? "The original live TV app has changed to version "
                                            + result.installedVersion + ". Compatible instructions "
                                            + "are not available yet. Check again later."
                                    : "The original Heat Live app is required to read this "
                                            + "V6's setup, even if you only want other apps. "
                                            + "Review its tile, then try again.");
                            progress.setText("CHECK NEEDS ATTENTION");
                        }
                        refreshButtons();
                        if (ready) makeButton.requestFocus();
                    }
                });
            }
        });
    }

    private void collect() {
        if (verifiedUid < 0) return;
        int count = buildCount();
        recordStage("COLLECTING");
        busy = true;
        refreshButtons();
        heroTitle.setText("Preparing " + apkCountLabel(count) + "…");
        heroBody.setText("Reading this V6's setup. Keep it on while the file is made.");
        progress.setText("READING THIS V6'S SETUP");
        worker.execute(new Runnable() {
            @Override public void run() {
                final String result = PrivilegedCollector.collect(getApplicationContext());
                boolean complete = false;
                String profileFailure = "PROFILE_CHECK_FAILED";
                if ("SAVED".equals(result)) {
                    try {
                        HeatLiveGate.Result gate = HeatLiveGate.inspect(
                                getApplicationContext());
                        if (gate.supported() && gate.originalUid == verifiedUid) {
                            PrivateProfileStore.saveFull(getApplicationContext(),
                                    verifiedUid);
                            complete = PrivateProfileStore.loadFull(
                                    getApplicationContext(), verifiedUid) != null;
                        }
                    } catch (PrivateProfileStore.IdentityFailure failure) {
                        profileFailure = failure.stage;
                    } catch (Exception ignored) { /* private fields stay private */ }
                }
                final boolean ready = complete;
                final String stage = profileFailure;
                runOnUiThread(new Runnable() {
                    @Override public void run() {
                        if (isFinishing() || isDestroyed()) return;
                        fullReady = ready;
                        busy = false;
                        if (ready) {
                            recordStage("PROFILE_READY");
                            workProgress.setProgress(2);
                            heroTitle.setText("Setup is ready");
                            heroBody.setText("Making your " + count + " selected files now.");
                            progress.setText("SETUP READY  /  MAKING " + apkCountLabel(count));
                        } else {
                            recordStage("SAVED".equals(result) ? stage : result);
                            buildAfterCollect = false;
                            workProgress.setVisibility(View.GONE);
                            heroTitle.setText("Setup needs attention");
                            heroBody.setText("SAVED".equals(result)
                                    ? "The original app changed while reading it. "
                                            + "Open the original live TV app, then try again. [" + stage + "]"
                                    : collectionMessage(result));
                            progress.setText("SETUP NEEDS ATTENTION");
                        }
                        refreshButtons();
                        if (ready && buildAfterCollect) {
                            buildAfterCollect = false;
                            buildApk();
                        }
                    }
                });
            }
        });
    }

    private void buildApk() {
        if (verifiedUid < 0 || !fullReady || buildSelection == null) return;
        final boolean[] selection = buildSelection.clone();
        final int count = buildCount();
        recordStage("BUILDING");
        busy = true;
        refreshButtons();
        progress.setText("MAKING " + apkCountLabel(count));
        heroTitle.setText("Making your " + apkCountLabel(count) + "…");
        heroBody.setText("Keep the V6 on while each app is checked and saved.");
        buildStatus.setVisibility(View.GONE);
        worker.execute(() -> {
            String result;
            String outputFolder = null;
            try {
                OwnerSigningKeys.Material owner = OwnerSigningKeys.load(
                        getApplicationContext());
                if (owner == null) owner = OwnerSigningKeys.createLocal(
                        getApplicationContext());
                SixApkBuilder.Result output = SixApkBuilder.buildSelected(
                        getApplicationContext(), selection,
                        (completed, appIndex, message) -> runOnUiThread(() -> {
                            if (!isFinishing() && !isDestroyed()) {
                                heroBody.setText(message);
                                workProgress.setProgress(2 + completed);
                                if (appIndex >= 0 && message.startsWith("Saved ")) {
                                    setAppState(appIndex, "APK SAVED", true);
                                }
                            }
                        }));
                outputFolder = output.folder;
                result = output.count == count ? "SAVED" : "EXPORT_FAILED";
            } catch (HeatLiveApkBuilder.BuildFailure failure) {
                result = failure.stage;
            } catch (Exception ignored) {
                result = "BUILD_FAILED";
            }
            final String stage = result;
            final String folder = outputFolder;
            runOnUiThread(() -> {
                if (isFinishing() || isDestroyed()) return;
                busy = false;
                exported = "SAVED".equals(stage);
                recordStage(stage);
                workProgress.setProgress(exported ? 2 + count : workProgress.getProgress());
                if (!exported) workProgress.setVisibility(View.GONE);
                if (!exported) {
                    for (int index = 0; index < appStates.length; index++) {
                        if (selection[index]) {
                            setAppState(index, "PARTIAL_OUTPUTS".equals(stage)
                                    ? "CHECK DOWNLOADS" : "CHECK AGAIN", false);
                        }
                    }
                }
                if ("IDENTITY_CHANGED".equals(stage)) {
                    fullReady = false;
                }
                heroTitle.setText(exported
                        ? "Your " + apkCountLabel(count) + (count == 1 ? " is ready" : " are ready")
                        : "The APKs were not made");
                heroBody.setText(exported
                        ? "Find the " + folder + " folder in Downloads. "
                                + "Copy the selected files to a USB drive and install them on your other TV."
                        : "IDENTITY_CHANGED".equals(stage)
                        ? "An original app changed on this V6. Read the setup again."
                        : missingOriginalMessage(stage) != null
                        ? missingOriginalMessage(stage)
                        : "The build stopped. See the error below, then try again.");
                progress.setText(exported
                        ? apkCountLabel(count) + " SAVED"
                        : "BUILD NEEDS ATTENTION");
                buildStatus.setText("IDENTITY_CHANGED".equals(stage)
                        ? "The APK was not exported. Collect protected setup "
                                + "values again. [IDENTITY_CHANGED]"
                        : "The APK was not exported. [" + stage + "]");
                buildStatus.setVisibility(exported ? View.GONE : View.VISIBLE);
                refreshButtons();
            });
        });
    }

    private void refreshButtons() {
        if (checkButton == null || makeButton == null) return;
        checkButton.setEnabled(!busy);
        checkButton.setText(busy && verifiedUid < 0
                ? "Checking…" : "1   Check compatibility");
        int count = selectedCount();
        makeButton.setEnabled(!busy && verifiedUid >= 0 && count > 0);
        makeButton.setText(busy && verifiedUid >= 0
                ? "Making APKs…" : exported ? "2   Make " + apkCountLabel(count) + " again"
                : count > 0 ? "2   Make " + apkCountLabel(count) : "2   Make APKs");
        for (int index = 0; index < appTiles.length; index++) {
            if (appTiles[index] != null) appTiles[index].setEnabled(!busy && verifiedUid >= 0
                    && matched[index]);
        }
    }

    private int selectedCount() {
        int count = 0;
        for (boolean value : selected) if (value) count++;
        return count;
    }

    private static String apkCountLabel(int count) {
        return count + (count == 1 ? " APK" : " APKs");
    }

    private int buildCount() {
        int count = 0;
        if (buildSelection != null) {
            for (boolean value : buildSelection) if (value) count++;
        }
        return count;
    }

    private void toggleSelection(int index) {
        if (busy || verifiedUid < 0 || !matched[index]) return;
        selected[index] = !selected[index];
        exported = false;
        setAppState(index, selected[index] ? "MATCHED · SELECTED" : "MATCHED · SKIPPED", true);
        int count = selectedCount();
        heroTitle.setText(count == 0 ? "Choose at least one app"
                : count + (count == 1 ? " app selected" : " apps selected"));
        heroBody.setText("Press OK on a tile to add or remove it. "
                + "Make APKs saves only the selected apps.");
        progress.setText("STEP 2 OF 2  /  " + count + " APPS SELECTED");
        refreshButtons();
    }

    private void refreshTile(int index) {
        if (appTiles[index] == null || appNames[index] == null) return;
        boolean checked = selected[index] && verifiedUid >= 0;
        appNames[index].setText((verifiedUid >= 0 && matched[index]
                ? checked ? "☑  " : "☐  " : "") + APP_LABELS[index]);
        appTiles[index].setContentDescription(APP_LABELS[index] + ", "
                + (matched[index] ? checked ? "selected" : "not selected"
                : appStates[index].getText()));
        boolean focused = appTiles[index].hasFocus();
        int fill = focused ? Color.rgb(39, 64, 88)
                : checked ? Color.rgb(27, 57, 68) : Color.rgb(31, 45, 64);
        int edge = focused ? Color.rgb(100, 211, 201)
                : checked ? Color.rgb(69, 153, 151) : Color.rgb(59, 80, 106);
        appTiles[index].setBackground(roundRect(fill, edge, 9));
    }

    private void setAppState(int index, String value, boolean good) {
        if (index < 0 || index >= appStates.length || appStates[index] == null) return;
        boolean waiting = "CHECKING…".equals(value) || "CHECK AGAIN".equals(value);
        appStates[index].setText(value);
        appStates[index].setTextColor(good ? Color.rgb(105, 221, 205)
                : waiting ? Color.rgb(147, 171, 195) : Color.rgb(255, 179, 163));
        refreshTile(index);
    }

    private static String heatLiveReason(HeatLiveGate.Result result) {
        if (false) return "V6 NOT SUPPORTED";
        if (!result.originalFound) return "NOT INSTALLED";
        if (false) return "VERSION NOT SUPPORTED";
        if (!result.signerMatches) return "SIGNATURE NOT VERIFIED";
        if (!result.singleApk || !result.ownerUser) return "INSTALL NOT SUPPORTED";
        if (!result.apkReadable) return "COULD NOT READ APP";
        if (!result.apkMatches && !result.payloadMatches) return "APP CONTENTS CHANGED";
        if (false) return "V6 SERVICE NOT VERIFIED";
        return "NEEDS ATTENTION";
    }

    private void recordStage(String stage) {
        getSharedPreferences(BUILDER_STATUS_PREF, MODE_PRIVATE).edit()
                .putString("last_stage", stage)
                .putLong("updated_at", System.currentTimeMillis())
                .commit();
        android.util.Log.i("VseeBuilderFlow", stage);
    }

    private static String missingOriginalMessage(String stage) {
        if (stage == null || !stage.startsWith("OPEN_ORIGINAL_APP_")) return null;
        try {
            int number = Integer.parseInt(stage.substring("OPEN_ORIGINAL_APP_".length()));
            if (number >= 2 && number <= 6) {
                return "Open the original " + HeatAppSpec.OTHER[number - 2].label
                        + " app on this V6, then try again.";
            }
        } catch (NumberFormatException ignored) { }
        return null;
    }

    private static String collectionMessage(String result) {
        switch (result) {
            case "SAVED":
                return "Two setup values were saved privately. Complete the owner profile next.";
            case "OPEN_ORIGINAL_APP_FIRST":
                return "The original app's Android ID is not recorded yet. "
                        + "Open the original live TV app, then come back and check again. "
                        + "[OPEN_ORIGINAL_APP_FIRST]";
            case "PREFERENCE_UNAVAILABLE":
                return "The original app's private setup value was unavailable. "
                        + "Open the original live TV app, then check again. "
                        + "[PREFERENCE_UNAVAILABLE]";
            case "ROOT_ADB_NOT_READY":
                return "The V6 ADB helper is not ready. Start its root ADB session, "
                        + "then try again. [ROOT_ADB_NOT_READY]";
            case "ROOT_ADB_UNVERIFIED":
                return "The local ADB session could not be verified as root. "
                        + "[ROOT_ADB_UNVERIFIED]";
            case "SSAID_READ_FAILED":
                return "The V6 Android ID record could not be read. "
                        + "[SSAID_READ_FAILED]";
            case "PREFERENCE_READ_FAILED":
                return "The original app's setup record could not be read. "
                        + "[PREFERENCE_READ_FAILED]";
            case "SERVICE_START_FAILED":
                return "The V6 system service did not accept the collection request. "
                        + "[SERVICE_START_FAILED]";
            case "PROBE_TIMEOUT":
                return "The V6 system service did not reply in time. [PROBE_TIMEOUT]";
            case "CHANNEL_REJECTED":
            case "CHANNEL_FAILED":
                return "The local collector reply could not be verified. [" + result + "]";
            case "STORE_FAILED":
                return "The local values were read but could not be saved securely. "
                        + "[STORE_FAILED]";
            case "PROBE_FAILED":
                return "The V6 probe stopped before collection completed. [PROBE_FAILED]";
            case "CHECK_FAILED":
                return "The box or app changed since the check. Check this box again.";
            default:
                return "Collection could not be verified on this box. No new profile was saved. "
                        + "[UNKNOWN_STAGE]";
        }
    }

    private TextView add(LinearLayout parent, String value, int size, int color,
                         int marginBottom) {
        TextView text = new TextView(this);
        text.setText(value);
        text.setTextSize(size);
        text.setTextColor(color);
        LinearLayout.LayoutParams layout = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        layout.bottomMargin = dp(marginBottom);
        parent.addView(text, layout);
        return text;
    }

    private Button addButton(LinearLayout parent, String value) {
        Button button = new Button(this);
        button.setText(value);
        button.setTextSize(18);
        button.setTextColor(Color.WHITE);
        button.setTypeface(null, Typeface.BOLD);
        button.setAllCaps(false);
        button.setBackground(buttonBackground(true));
        LinearLayout.LayoutParams layout = new LinearLayout.LayoutParams(dp(410), dp(58));
        layout.gravity = Gravity.START;
        layout.bottomMargin = dp(12);
        parent.addView(button, layout);
        return button;
    }

    private StateListDrawable buttonBackground(boolean action) {
        StateListDrawable states = new StateListDrawable();
        states.addState(new int[]{android.R.attr.state_pressed},
                action ? actionRect(Color.rgb(76, 222, 210), Color.rgb(27, 155, 165),
                        Color.WHITE) : roundRect(Color.rgb(55, 86, 98), Color.WHITE, 12));
        states.addState(new int[]{android.R.attr.state_focused},
                action ? actionRect(Color.rgb(53, 208, 196), Color.rgb(24, 147, 158),
                        Color.WHITE) : roundRect(Color.rgb(55, 86, 98), Color.WHITE, 12));
        states.addState(new int[]{-android.R.attr.state_enabled},
                roundRect(Color.rgb(48, 59, 68), Color.rgb(48, 59, 68), 12));
        states.addState(new int[]{},
                action ? actionRect(Color.rgb(38, 190, 180), Color.rgb(20, 129, 150),
                        Color.rgb(89, 219, 207))
                        : roundRect(Color.rgb(34, 57, 70), Color.rgb(70, 108, 120), 12));
        return states;
    }

    private GradientDrawable actionRect(int top, int bottom, int border) {
        GradientDrawable background = new GradientDrawable(
                GradientDrawable.Orientation.TL_BR, new int[]{top, bottom});
        background.setCornerRadius(dp(12));
        background.setStroke(dp(1), border);
        return background;
    }

    private GradientDrawable roundRect(int fill, int border, int radiusDp) {
        GradientDrawable background = new GradientDrawable();
        background.setColor(fill);
        background.setCornerRadius(dp(radiusDp));
        background.setStroke(dp(1), border);
        return background;
    }

    private int dp(int value) {
        return (int) (value * getResources().getDisplayMetrics().density + 0.5f);
    }

    @Override
    protected void onDestroy() {
        worker.shutdownNow();
        super.onDestroy();
    }
}
