# GCD 電路的低功耗設計與功耗量測

以一個 FSM + Datapath 架構的 GCD（最大公因數）電路為對象，比較三種設計版本的面積、平均功耗與能量。流程是先用 Design Compiler 合成成 gate-level netlist，再以 VCS 做 gate-level simulation 產生真實的切換行為（VCD），最後交給 PrimeTime 計算平均功耗。

## 設計版本

| 資料夾 | 版本 | 做法 |
|---|---|---|
| `V1/` | Baseline | 不使用任何低功耗技巧 |
| `V3/` | Latches | 在 ALU 的兩個輸入前加入 8-bit D-latch，只在需要運算的 state（S4）才透通 |
| `V4/` | AND gates | 在 ALU 的兩個輸入前加入 AND gate，非運算 state 時把輸入強制為 0 |

V3 與 V4 都屬於 **operand isolation**：ALU 只有在 S4 這個 state 的結果才會被使用，其他時間暫存器 A、B 的值改變時，若直接接到 ALU，ALU 內部的加減法器仍會跟著切換、白白耗電。在 ALU 前面加一道「閘門」，就能擋住這些沒有用的切換。

GCD 電路由 `Controller`（FSM）與 `Datapath` 組成，Datapath 包含三個 8-bit 暫存器（A、B、R）、三個 MUX、一個 ALU（減法器、加法器、遞增器）以及一個比較器。

## 設計流程

```
RTL ──Design Compiler──▶ GCD_syn.v / .sdf / .sdc / .ddc
                              │
                              ▼
                     VCS gate-level simulation
                       （載入 SDF 時序）
                              │
                              ▼
                         GCD_syn.vcd
                              │
                              ▼
                PrimeTime：依 VCD 計算平均功耗
                              │
                              ▼
                 report_power_average_vcd.txt
```

| 步驟 | 腳本 | 說明 |
|---|---|---|
| 合成（無 clock gating） | `scripts/GCD_dc_clk.tcl` | `compile -exact_map` |
| 合成（clock gating） | `scripts/GCD_dc_gclk.tcl` | 加上 `set_clock_gating_style -sequential_cell latch` 與 `compile -exact_map -gate_clock` |
| Gate-level simulation | `tb/GCD_tb_gate.v` | 載入 `GCD_syn.sdf`，輸出 `GCD_syn.vcd` |
| 功耗分析 | `scripts/GCD_pt.tcl` | `power_analysis_mode averaged`，讀入 VCD 後執行 `report_power -hierarchy` |

```bash
dc_shell -f scripts/GCD_dc_clk.tcl           # 或 GCD_dc_gclk.tcl
vcs -R tb/GCD_tb_gate.v GCD_syn.v -v <標準元件庫的 Verilog 模型>
pt_shell -f scripts/GCD_pt.tcl
```

腳本內的元件庫路徑為課程伺服器上的 TSMC 90 nm CBDK，需要依自己的環境修改。

**Testbench：** 時脈週期 20 ns，重置後送入 A = 15、B = 9，等待 `done` 拉高後印出結果（GCD = 3）。`GCD_tb_rtl.v` 用於 RTL 模擬，`GCD_tb_gate.v` 另外載入 SDF 並輸出 VCD。

**合成條件：** TSMC 90 nm 製程（`slow.db`，0.9 V）、wire load model `tsmc090_wl10`、時脈週期 10 ns（100 MHz）。三個版本都滿足時序，V1 的 slack 為 4.36 ns，V3/V4 為 3.62 ns。

Design Compiler 的 `report_power` 只能用預設的切換率粗估功耗；PrimeTime 則依照 gate-level simulation 實際記錄的每條訊號切換來計算，結果較接近真實情況。因此本專案的功耗比較都以 PrimeTime 的結果為準。

## 目錄結構

```
├── rtl/GCD.v          # 課程提供的 baseline RTL（見「已知問題」）
├── scripts/           # Design Compiler 與 PrimeTime 腳本
├── tb/                # RTL 與 gate-level testbench
└── V1/ V3/ V4/        # 各版本的合成與功耗分析結果
```

每個版本的資料夾內容相同：

```
V1/  V3/  V4/
├── GCD_syn.v                     # 合成後的 gate-level netlist
├── GCD_syn.sdf                   # 時序資訊，供 gate-level simulation 使用
├── GCD_syn.sdc                   # 時序約束
├── GCD_syn.ddc                   # Design Compiler 資料庫
├── GCD_syn.vcd                   # gate-level simulation 的切換紀錄
├── area_report.txt               # 面積報告
├── timing_report.txt             # 時序報告
├── power_report.txt              # Design Compiler 功耗估計（V3 無此檔）
└── report_power_average_vcd.txt  # PrimeTime 依 VCD 計算的平均功耗
```

## 實驗結果

| 版本 | 面積 | 平均功耗 | 暫存器功耗（A + B + R） | ALU 功耗 | 能量 |
|---|---|---|---|---|---|
| V1 Baseline | 1602.42 | 68.5 µW | 24.72 µW | 20.9 µW | 2.81 × 10⁻¹¹ J |
| V3 Latches | 1761.88（+10.0%） | 59.0 µW（−13.9%） | 23.70 µW | 7.57 µW | 2.42 × 10⁻¹¹ J |
| V4 AND gates | 1662.39（+3.7%） | 68.1 µW（−0.6%） | 22.79 µW | 16.7 µW | 2.80 × 10⁻¹¹ J |

- 面積為 Design Compiler 的 total cell area。
- 能量 = 平均功耗 × 模擬時間，三個版本的 testbench 都只計算一組 GCD(15, 9)，模擬時間約 411 ns（以 20 ns 時脈計約 20 個週期）。
- V3 的 ALU 功耗不含兩組 latch 本身的 4.19 µW；含 latch 為 11.76 µW，仍只有 V1 ALU 的 56%。

## 分析

**Latch 版本省最多電。** 加入 latch 後，ALU 的功耗從 20.9 µW 降到 7.57 µW，降幅約 64%，整體功耗下降 13.9%。代價是面積增加 10%：多了 16 個 latch（`TLATX1` / `TLATX2`），sequential cell 從 27 個增加到 43 個。

**AND gate 版本幾乎沒有效果。** ALU 功耗只降了 20%，整體功耗只降 0.6%。差別在於兩者「關閉」時的行為：

- **Latch 關閉時會保持上一次的值。** ALU 的輸入完全不動，內部也就不會切換。
- **AND gate 關閉時會把輸入強制為 0。** 每次在運算 state 與非運算 state 之間切換時，ALU 的輸入都會在「實際數值」與「0」之間跳動，這些跳動本身就會讓 ALU 內部切換。GCD 運算過程中 state 切換很頻繁，省下來的切換大部分又被這些額外的跳動抵消了。

這是 operand isolation 常見的取捨：AND gate 面積小、沒有 latch 的時序問題，但只有在被隔離的模組「長時間閒置」時才划算；latch 能真正凍結輸入，效果較好，但面積較大，而且 latch 屬於 level-sensitive 元件，靜態時序分析比 flip-flop 複雜。

## 已知問題

- **Clock gating 版本的結果未保留。** 作業原本有第四個版本：以 `scripts/GCD_dc_gclk.tcl` 合成（`set_clock_gating_style -sequential_cell latch` 加上 `compile -gate_clock`），讓 Design Compiler 自動把暫存器的 load 回授 MUX 換成 clock gating cell。但當時交出的 clock gating 結果與 baseline 的 netlist 除日期外完全相同，暫存器仍是「flip-flop 加 AO22 回授 MUX」的結構，表示實際上沒有插入 clock gating，很可能是誤用了 `GCD_dc_clk.tcl`。由於已無法重新合成，這個版本的結果沒有放進 repo，只保留合成腳本。
- **V3、V4 的 ALU 運算選擇被固定成常數。** V1 的 ALU `sel` 由 Controller 控制，V3 與 V4 則在 Datapath 中把 `sel` 接成固定值 `3'b100`。ALU 的控制輸入不再切換，本身也會讓 ALU 少耗一些電，因此 V3、V4 的 ALU 功耗下降不完全是 operand isolation 的效果。
- **`rtl/GCD.v` 是課程提供的原始版本，不是 V1–V4 實際使用的 RTL。** 這份 RTL 的運算單元是單純的減法器 `Sub`，但 V1–V4 的 netlist 都是改寫過的 `ALU`（含減法器、加法器、遞增器與 `sel`），V3、V4 另外有 `In_S4` 訊號與 latch / AND gate。各版本實際的 RTL 目前沒有保留。
- **模擬時脈與合成時脈不同。** 合成約束是 10 ns（100 MHz），testbench 卻是 20 ns（50 MHz），因此量到的平均功耗對應的是 50 MHz 下的操作。
- **只有一組測試資料。** 平均功耗只來自單一一次 GCD(15, 9) 運算、約 20 個週期，資料量偏少，換一組輸入結果可能就會不同；testbench 也沒有自動比對結果是否正確。

## 使用工具

Synopsys Design Compiler U-2022.12 · Synopsys VCS · Synopsys PrimeTime · TSMC 90 nm 標準元件庫
