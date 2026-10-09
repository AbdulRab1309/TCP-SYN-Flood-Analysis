# TCP SYN Flood Detection and Analysis Using Wireshark

A networking and cybersecurity course project focused on analyzing TCP handshake behavior using Wireshark and automating basic packet analysis with Bash and TShark.

> **Project Scope:** This project demonstrates controlled TCP SYN traffic analysis in a laboratory environment. The current implementation performs basic packet counting and does not constitute a fully validated SYN flood detection system.

## Project Overview

The Transmission Control Protocol (TCP) establishes connections through a three-way handshake consisting of SYN, SYN-ACK, and ACK packets.

A TCP SYN flood is a type of Denial-of-Service (DoS) attack that exploits this connection-establishment process by generating numerous connection requests that may remain incomplete.

This project investigates TCP handshake behavior using Wireshark and automates basic packet analysis through a Bash script that uses TShark.

The experiments were conducted in a controlled laboratory environment using Kali Linux, Oracle VirtualBox, and a Windows host running a local TCP test server.

## Objectives

- Understand the TCP three-way handshake.
- Capture and analyze TCP traffic using Wireshark.
- Examine SYN, SYN-ACK, and ACK packet behavior.
- Perform a controlled TCP SYN packet experiment.
- Automate basic packet analysis using Bash and TShark.
- Generate a summary of observed TCP packet counts.
- Understand the limitations of packet-based attack analysis.

## Technologies Used

| Technology | Purpose |
|---|---|
| Kali Linux | Laboratory environment |
| Windows | Host system and TCP test server |
| Oracle VirtualBox | Virtual machine environment |
| Wireshark | Graphical network packet analysis |
| TShark | Command-line packet analysis |
| Bash | Automation and report generation |
| hping3 | Controlled SYN packet generation |
| Python | Local TCP test server |
| Netcat | Normal TCP connectivity testing |

## Project Architecture

```text
             Kali Linux VM
                  |
                  | Controlled SYN Experiment
                  v
          Windows TCP Test Server
               Port 9999
                  |
                  v
          Wireshark Packet Capture
                  |
                  v
            Saved PCAPNG File
                  |
                  v
          Bash Script: syn_detector.sh
                  |
                  v
           TShark Packet Analysis
                  |
                  v
          TCP Traffic Summary Report
```

## Project Implementation

### 1. Laboratory Setup

A host-only network was configured in Oracle VirtualBox to enable communication between Kali Linux and the Windows host.

A Python TCP test server was created on Windows and configured to listen on port `9999`.

### 2. Normal TCP Traffic Analysis

Netcat was used in Kali Linux to establish a TCP connection with the Windows test server.

```bash
nc 192.168.56.1 9999
```

Wireshark was used to inspect the TCP three-way handshake and observe subsequent communication.

### 3. Controlled SYN Experiment

The following command was executed in Kali Linux:

```bash
sudo hping3 -S -p 9999 -c 10 192.168.56.1
```

This command generated ten TCP SYN packets targeting the local Windows test server.

Wireshark captured the outgoing SYN packets and the corresponding SYN-ACK responses.

This was a bounded laboratory experiment, not a high-volume denial-of-service test.

### 4. Bash Automation

A Bash script named `syn_detector.sh` was developed to automate basic packet analysis using TShark.

The script:

- Validates the supplied capture filename.
- Checks whether the capture file exists.
- Checks whether TShark is installed.
- Counts initial SYN packets.
- Counts SYN-ACK packets.
- Counts selected ACK-bearing packets.
- Displays a formatted analysis summary.

## Installation and Usage

### Prerequisites

- Kali Linux or another compatible Linux environment
- Bash
- Wireshark/TShark
- A saved `.pcap` or `.pcapng` capture file

### Install TShark

```bash
sudo apt update
sudo apt install tshark
```

### Run the Analyzer

Navigate to the directory containing the script:

```bash
cd TCP-SYN-Flood-Analysis
```

Make the script executable:

```bash
chmod +x syn_detector.sh
```

Run the analyzer against a saved capture:

```bash
./syn_detector.sh syn_test.pcapng
```

Replace `syn_test.pcapng` with the actual filename or provide the full path to the capture.

## Wireshark Display Filters

### Initial SYN Packets

```wireshark
tcp.flags.syn == 1 && tcp.flags.ack == 0
```

### SYN-ACK Packets

```wireshark
tcp.flags.syn == 1 && tcp.flags.ack == 1
```

### TCP Traffic on Port 9999

```wireshark
tcp.port == 9999
```

### ACK-Bearing Packets

```wireshark
tcp.flags.ack == 1
```

These filters help isolate relevant packets for further inspection.

## Experimental Results

The initial Bash analyzer produced the following results:

| Parameter | Observed Result |
|---|---:|
| Initial SYN packets | 11 |
| SYN-ACK packets | 11 |
| Non-SYN ACK packets reported by the initial script | 0 |

Further inspection of the capture showed:

- Ten SYN packets used source ports `2841` through `2850`.
- These ten packets received SYN-ACK responses.
- The provided packet output did not show corresponding final ACK packets for those ten attempts.
- An additional connection used source port `41796`, and its handshake appeared to complete.

**Validation note:** The initial script reported zero non-SYN ACK packets, but the detailed packet output showed ordinary ACK-bearing packets for the connection using source port `41796`. This discrepancy must be resolved before the ACK count is treated as final.

The experiment demonstrates a controlled pattern of apparently incomplete TCP handshakes. It does not establish that a SYN flood attack occurred.

## Limitations

- The current implementation performs basic packet counting.
- It does not reliably correlate packets to individual TCP connections.
- ACK-bearing packets are not necessarily final handshake acknowledgments.
- Incomplete handshakes can occur for reasons other than an attack.
- Comprehensive time-based SYN flood detection has not been implemented.
- Packet counts alone cannot confirm a SYN flood attack.

## Future Improvements

- Implement TCP connection-level handshake correlation.
- Calculate SYN packet rates over defined time intervals.
- Compare normal traffic with controlled test traffic.
- Improve incomplete-handshake analysis.
- Generate more detailed automated reports.
- Add more comprehensive detection logic.

## Learning Outcomes

This project provided practical experience with:

- TCP connection establishment and TCP flags
- Wireshark packet capture and display filters
- TShark command-line packet analysis
- Bash scripting and command-line automation
- Network traffic investigation
- Experimental documentation and result analysis

## Safety Disclaimer

This project was developed for educational purposes. Experiments were performed against a local test server in a controlled laboratory environment.

Only test systems that you own or have explicit authorization to assess.

## References

- [Wireshark Documentation](https://www.wireshark.org/docs/)
- [TShark Manual](https://www.wireshark.org/docs/man-pages/tshark.html)
- [Kali Linux Documentation](https://www.kali.org/docs/)
- [GNU Bash Manual](https://www.gnu.org/software/bash/manual/)
