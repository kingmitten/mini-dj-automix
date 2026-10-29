# Automix Studio (OpenAutomix)

> **An open-source, browser-based DJ transition editor and 5-stage intelligent automix engine.**  
> Powered by client-side Web Audio API, HTML5 Canvas, and a high-performance Python DSP backend (NumPy + SciPy STFT + Viterbi Dynamic Programming).

---

## Built with AI & "Vibe Coding"

> **Full Transparency:** This project was created through **AI pair programming and "vibe coding"**.  
> Rather than hand-coding every single line of digital signal processing and Canvas coordinate math from scratch, this entire application was conceptualized, directed, and iteratively built by a human creator collaborating with an AI coding assistant.
> 
> The human drove the product direction, reverse-engineering ideas from screenshots of modern streaming automix features, testing audio feel, and steering features, while AI translated those musical intuitions into working NumPy/SciPy Viterbi algorithms, Web Audio signal chains, and 60fps waveform renderers.
> 
> We believe in 100% honesty about how software is built today — vibe coding allows wild musical ideas to turn into working reality!

---

##  Key Features

### 1. 🤖 Automated 5-Stage Decision Pipeline (`✨ Auto`)
When you click **`✨ Auto`**, the engine executes an intelligent decision tree:
- **Stage 1 (Profile Ingestion):** Gathers downbeats, Camelot harmonic key, sub-bass density (< 250 Hz), and real-time Voice Activity Detection (VAD) heatmaps.
- **Stage 2 (Multi-Bar Candidate Seam Search):** Tests **4 Bars**, **8 Bars**, and **16 Bars** simultaneously, scanning candidate downbeats in Song A's outro (last 75s) and Song B's intro (first 45s).
- **Stage 3 (Vocal Collision Avoidance):** Samples joint vocal probability ($\sum VAD_A \times VAD_B$). If a 16-bar mix causes two vocalists to sing over each other, it dynamically drops to an 8-bar or 4-bar seam where vocal clash is **0.00%**.
- **Stage 4 (Recipe Selection):** Automatically picks the optimal transition curve based on track dynamics and key compatibility.
- **Stage 5 (Microsecond Phase-Lock):** Locks downbeats with sub-millisecond precision ($\Delta t = 0.0$ ms) and sets up tempo ramping.

### 2. Complete 11-Preset Transition Suite
Visual multi-lane curve sculpting (Cyan = Volume, Yellow = Bass EQ, Pink = Resonant Filter):

| Preset | Volume Curve (Cyan) | Bass EQ (Yellow) | Filter Sweep (Pink) | Musical Context |
|---|---|---|---|---|
| **`Fade`** | Smooth S-curve | **Center Bass Swap** at midpoint | Flat open | Pop, Hip-Hop, Radio |
| **`Rise`** | Full overlap | Drop at end | High-pass sweep upward into drop | EDM / Club build-ups |
| **`Blend`** | Extended 16-bar overlap | Smooth midpoint crossover | Flat open | Deep House & Techno grooves |
| **`Wave`** | Full overlap | Center Bass Swap | Cross-filter (Track 1 LPF exit, Track 2 open) | Melodic tracks with clashing synths |
| **`Melt`** | Gentle drop to 30% | Center Bass Swap | High-pass wash dissolving into delay tail | Ambient & tempo deceleration |
| **`Slam`** | **Instant cut/drop switch** | Instant downbeat cut | Flat open | Beat switches & drops |
| **`Dissolve`** | Track 2 fades in early at 35% | Late bass swap (Bar 14) | Gentle high roll-off | Vocals over instrumentals |
| **`Surge`** | Fast crescendo surge on Track 2 | Late bass swap | Brightness rise | Peak-time festival drops |
| **`Afterglow`**| Outgoing tail lingers | Center Bass Swap | High-resonance melodic outro | Emotional vocal endings |
| **`Custom`** | Freehand point editing | Freehand point editing | Freehand point editing | Manual DJ sculpting |

### 3. 4 Spotify-Style Tempo Strategies
- **Continuous Ramp (Strategy 1):** Smooth sigmoid S-curve dynamic tempo ramp across the transition window.
- **Target Average (Strategy 2):** Locks both decks to their compromise average tempo $(BPM_1 + BPM_2) / 2$.
- **2:1 Harmonic Alignment (Strategy 3):** Integer octave multiple alignment ($0.5\times, 1.0\times, 2.0\times$) for half-time / double-time matching.
- **Radio Crossfade (Strategy 4):** Raw 1.0x native playback speeds without horizontal time-warping.

### 4. ThreeBandWaveform Renderer (Non-Linear Power Curves)
Renders high-resolution frequency bands using mathematical exponents to mimic streaming platform waveform aesthetics:
```javascript
const T = Math.pow(normLows,  0.55); // Bass (Amber): Square-root curve makes kick drums look punchy and solid
const g = Math.pow(normMids,  0.80); // Mids (Orange): Gentle curve keeping vocal melodies clear
const S = Math.pow(normHighs, 1.80); // Highs (Royal Blue): Severe transient squishing so only sharp drum hits pop out
const Spine = Math.min(T, g, S);     // Core Spine: Multi-band intersection creates luminous white center spine
```

### 5. Studio DJ Audio Engine
- **Independent Dual-Deck Signal Chains:** BufferSource $\to$ Gain Envelope $\to$ 3-Band Peaking/Shelf EQ $\to$ Resonant Lowpass/Highpass Dual Filter $\to$ Master Out.
- **60 FPS Live Parameter Tracking:** Gain, EQ cuts, and filter sweeps follow automation curves in real time.
- **Universal Drag & Drop:** Drop audio files anywhere onto the deck or viewport. Supports dragging **two files at once** to load Deck 1 and Deck 2 simultaneously.

---

## 🏗️ Architecture

```
Automix-Studio/
├── index.html               # Complete Single-Page Web Studio (UI, Web Audio, Canvas)
├── native_dsp_server.py     # High-Performance Python DSP Engine (FastAPI)
├── requirements.txt         # Python dependencies
├── README.md                # Project documentation
└── HANDOFF_NOTES.md         # Comprehensive engineering handoff
```

---

## Quick Start

### 1. Prerequisites
- **Python 3.9+** (with FFmpeg installed and in your system PATH)
- Any modern web browser (Chrome, Edge, Firefox, Brave)

### 2. Install Python DSP Backend
```bash
# Clone the repository
git clone https://github.com/your-username/automix-studio.git
cd automix-studio

# Install dependencies
pip install fastapi uvicorn numpy scipy python-multipart
```

### 3. Run the Studio
```bash
# Start the Native DSP server
python native_dsp_server.py
```

Open your browser and navigate to:
```
http://localhost:8765
```
*(Or simply double-click `index.html` to run in standalone browser mode!)*

---

## Supported Audio Formats
- MP3 (`.mp3`)
- WAV (`.wav`)
- FLAC (`.flac`)
- AAC / M4A (`.m4a`, `.aac`)
- Ogg Vorbis (`.ogg`)

---

## License & Disclaimer

Distributed under the **MIT License**. See `LICENSE` for details.

*Disclaimer: Automix Studio is an independent, clean-room educational project developed for audio hobbyists and DJs. It is not affiliated with, endorsed by, or associated with Spotify AB or any of its subsidiaries.*
