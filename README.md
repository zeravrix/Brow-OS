# Brow OS

### A lightweight, browser-first operating system for low-end computers.

**Brow OS** is a minimal Linux-based operating system designed for computers with limited hardware resources.

The project is built around a simple idea:

> **If a computer is mainly used for the web, why run a full desktop operating system?**

Brow OS removes unnecessary desktop components and background services and focuses the experience around the **Brave Browser**.

The goal is to give older and low-spec computers a simple, lightweight and practical environment for everyday web browsing.

---

## 🎯 Project Goals

Brow OS is designed to:

- Provide a lightweight operating system for low-end computers
- Boot directly into the browser
- Minimize RAM and CPU usage
- Remove unnecessary desktop components
- Reduce background services
- Provide a simple browser-focused experience
- Support live USB usage
- Support installation to internal storage
- Give older computers a second life

The project is especially targeted at computers where a traditional Windows installation or full desktop Linux distribution can feel too heavy for everyday browsing.

---

## 🖥️ How It Works

Brow OS is based on **Debian 13 "Trixie"** and uses a minimal graphical environment with **labwc on Wayland**.

Unlike a traditional Linux desktop, Brow OS does not provide a full desktop environment or a large collection of applications.

The system is designed around the browser as its primary graphical application.

### Traditional OS

**Power On → Operating System → Desktop → Applications → Browser**

### Brow OS

**Power On → Brow OS → Browser**

This approach reduces the amount of software running in the background and allows more of the computer's limited resources to be used by the browser.

---

## 🚀 Main Features

### Browser-First Interface

The browser starts automatically after boot.

There is no traditional desktop environment to navigate before browsing the web.

The intended workflow is:

**Power On → Boot → Browser → Browse**

### Lightweight System

Brow OS removes or disables many components that are unnecessary for a browser-focused computer, including:

- Full desktop environment
- File manager
- SSH services
- Printing services
- Modem services
- Unnecessary background services
- Large documentation packages
- Unnecessary translation packages

### Low-Memory Optimizations

The system includes several optimizations designed for computers with limited RAM:

- **ZRAM** compressed memory
- **earlyoom** for out-of-memory protection
- Brave Memory Saver
- Reduced browser background activity
- RAM-based system logs
- Low-end Chromium configuration on systems with limited RAM

The objective is to keep the operating system lightweight while allowing the browser to use the majority of the available memory.

---

## 💾 RAM Requirements

Brow OS is specifically designed for low-memory computers.

| RAM | Recommendation |
|---:|---|
| **1 GB** | Minimum |
| **2 GB** | Recommended |
| **3–4 GB** | Best experience |
| **4+ GB** | Excellent for heavier browsing |

### Expected Memory Usage

The operating system itself is designed to use approximately:

**200–400 MB RAM**

With the browser running and approximately **one browser page** open, typical usage is targeted at approximately:

**600–800 MB RAM**

These numbers are targets/approximate values and can vary depending on hardware, browser processes, extensions and the website being used.

The main idea is to keep the operating system itself extremely lightweight and leave as much memory as possible for browsing.

---

## 🌐 Browser & Web Experience

The **Brave Browser** is the primary application of Brow OS.

Brave's built-in ad blocking helps reduce unnecessary advertising and tracking activity while browsing.

The system also includes configuration intended to improve video playback on older hardware.

### YouTube

Brow OS uses the **enhanced-h264ify** extension so that YouTube can prefer H.264 video instead of more demanding codecs such as VP9 or AV1.

H.264 can be easier for older hardware to decode, particularly on systems with limited hardware video-decoding support.

Actual video performance depends heavily on the CPU, GPU and available hardware acceleration.

On very old hardware, **480p–720p H.264 video** may provide a more realistic experience than higher resolutions.

---

## 🔌 Live USB

Brow OS can run directly from a USB drive as a live operating system.

This allows users to test the system without replacing their existing operating system.

The live environment can also use a persistent save file to preserve data between sessions.

### Persistent Save File

The save file can preserve:

- Browser accounts
- Browser settings
- Bookmarks
- Saved logins
- Saved Wi-Fi networks
- Home-folder data

The save file is stored on a supported internal partition rather than the USB device.

> **Security warning:** The save file is not encrypted. Anyone with access to the drive may be able to access information stored inside it.

---

## 💽 Installation

Brow OS can also be installed to an internal disk and used as the computer's main operating system.

After installation, the computer continues to boot directly into the browser.

The installed system stores the user's profile directly on the internal disk, so browser settings and personal data are preserved normally.

---

## ⌨️ System Controls

Brow OS provides keyboard shortcuts for accessing system functions.

| Shortcut | Function |
|---|---|
| **Windows / Super** | Open terminal |
| **Super + Space** | Show or hide the top bar |
| **Ctrl + Shift + Delete** | Show or hide the top bar |
| **Alt + Tab** | Switch applications |

The single top bar shows the clock, Wi-Fi state and laptop battery percentage.
Press either bar shortcut to show or hide it. Click the Wi-Fi status to open a
network picker; secured networks ask for their password in a graphical prompt.

The regular Brave address bar and tabs remain available as described above.

---

## 📡 Bluetooth & USB Storage

Bluetooth and USB storage support are included but disabled by default to reduce unnecessary background activity.

They can be enabled when required.

### Bluetooth

```bash
brow-os-switch bluetooth pair
```

Disable Bluetooth:

```bash
brow-os-switch bluetooth off
```

### USB Storage

```bash
brow-os-switch usb on
```

Connected drives can then be identified using:

```bash
lsblk
```

USB devices can be mounted using standard Linux storage tools.

> Bluetooth audio and some device-specific functionality may require additional testing.

---

## 🔧 Hardware Detection

Brow OS includes hardware-detection tools designed to identify hardware and missing firmware.

Common firmware for supported Wi-Fi hardware is included where possible.

The system can also detect missing firmware and attempt to install the appropriate Debian firmware package when a network connection is available.

This helps improve compatibility with different low-end laptops and desktop computers.

---

## 🔐 Security

Brow OS maintains a minimal security-focused configuration while keeping the system lightweight.

It includes:

- Brave Browser sandbox
- Unprivileged browser user
- Default-deny inbound firewall
- Debian security updates
- Brave Browser updates

The goal is to avoid unnecessary services while maintaining the basic security features required for modern web browsing.

---

## 🧪 Testing & Diagnostics

Brow OS is intended to be tested on real low-end hardware.

Testing is particularly valuable on computers with:

- 1–4 GB RAM
- Older Intel processors
- Older AMD processors
- Integrated graphics
- Older Wi-Fi adapters
- Older storage hardware

Useful testing information includes:

- CPU model
- RAM capacity
- GPU
- Wi-Fi adapter
- Storage device
- Boot time
- Idle RAM usage
- Browser performance
- YouTube performance
- Hardware video decoding
- Bluetooth functionality
- USB storage functionality

### Hardware Probe

```bash
sudo brow-os-probe /tmp
```

### Memory Report

```bash
brow-os-memreport
```

---

## ⚠️ Known Limitations

Brow OS is an experimental project and hardware compatibility may vary between computers.

Some areas still require additional testing, including:

- Hardware video decoding
- Older Intel graphics
- Bluetooth audio
- Some Wi-Fi adapters
- Legacy BIOS systems
- Certain Wayland/labwc configurations
- Installation on unusual disk configurations

### Very Old Intel Hardware

Hardware video decoding on some older Intel processors has not been fully verified.

If YouTube playback is slow or unstable, the information shown at:

```text
chrome://gpu
```

can be useful for diagnosing the problem.

### Braswell Systems

Some Braswell-based systems may experience Linux kernel idle-freeze issues.

If a system freezes while idle, the following kernel parameter may help:

```text
intel_idle.max_cstate=1
```

---

## 📊 Resource Philosophy

Brow OS follows a simple resource philosophy:

> **Use the minimum resources necessary for the operating system and give the remaining resources to the browser.**

The target is approximately:

### OS Only
**200–400 MB RAM**

### OS + One Browser Page
**600–800 MB RAM**

This makes Brow OS particularly suitable for computers that would otherwise struggle with a modern desktop operating system.

---

## 📦 Repository

This repository contains the Brow OS project files and the generated ISO image.

The ISO can be used to test Brow OS on compatible hardware or inside a virtual machine.

---

## 🛠️ Project Status

Brow OS is an **experimental open-source project** focused on creating a practical browser-first operating system for low-end hardware.

Current development focuses on:

- Real hardware testing
- RAM optimization
- Browser performance
- YouTube playback
- Hardware compatibility
- Boot reliability
- Installation reliability

Performance and compatibility can vary significantly depending on the computer.

Bug reports, testing results, hardware compatibility reports and improvements are welcome.

---

## 🔮 Future Plans

Possible future improvements include:

- Further RAM reduction
- Faster boot times
- Improved hardware compatibility
- Better Wi-Fi support
- Improved Bluetooth support
- Better audio support
- Improved hardware video decoding
- Better YouTube performance
- More polished browser-only interface
- Improved installation experience
- Recovery options
- Better persistence support
- Wider testing on very old hardware

---

## 🤝 Contributing

Brow OS is an open-source project and contributions are welcome.

Testing the operating system on different low-end computers is particularly valuable.

When reporting a problem, useful information includes:

- Computer model
- CPU
- RAM
- Graphics hardware
- Wi-Fi hardware
- Storage device
- What happened during boot
- Browser performance
- Video playback performance
- Relevant error messages

Hardware compatibility reports help determine which systems Brow OS works best on.

---

## 📜 License & Trademarks

Brow OS is an independent open-source project.

The original Brow OS source code, scripts, configurations and other original work in this repository are licensed under the license specified in the repository's `LICENSE` file.

Third-party software included in the ISO remains subject to its own licenses.

**Brave** and the **Brave Browser** name and trademarks belong to **Brave Software, Inc.**

**Debian** is a trademark of **Software in the Public Interest, Inc.**

**Linux** is a registered trademark of **Linus Torvalds**.

Brow OS is **not affiliated with, endorsed by, sponsored by, or officially connected to Brave Software, Inc., Debian, or the Linux Foundation.**

See [`THIRD-PARTY.md`](THIRD-PARTY.md) for information about third-party software, licenses and sources included in Brow OS.
