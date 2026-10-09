# TCP SYN Flood Detection and Analysis Using Wireshark

## Overview

This project explores TCP handshake behavior and examines packet
patterns associated with incomplete TCP connections.

Wireshark is used to capture and inspect network traffic, while
a Bash script using TShark automates basic packet counting and
generates a summary of the observed traffic.

The experiments were performed in a controlled laboratory
environment using Kali Linux and a Windows TCP test server.

## Objectives

- Understand the TCP three-way handshake.
- Capture and analyze TCP traffic using Wireshark.
- Examine SYN, SYN-ACK, and ACK packet behavior.
- Perform a controlled TCP SYN packet experiment.
- Automate basic packet analysis using Bash and TShark.

## Technologies Used

- Kali Linux
- Windows
- Oracle VirtualBox
- Wireshark
- TShark
- Bash
- hping3
- Python
- Netcat

## Project Workflow

1. Configure a host-only network between Kali Linux and Windows.
2. Run a TCP test server on Windows.
3. Capture normal TCP communication using Wireshark.
4. Perform a bounded SYN packet experiment in the lab.
5. Analyze saved packet captures using TShark.
6. Generate a packet-count summary using Bash.

## Bash Analyzer

The `syn_detector.sh` script:

- Validates the capture file.
- Counts initial SYN packets.
- Counts SYN-ACK packets.
- Counts selected ACK-bearing packets.
- Displays a formatted analysis summary.

## Experimental Observations

The initial analyzer reported:

- Initial SYN packets: 11
- SYN-ACK packets: 11

Detailed inspection showed ten SYN requests using source
ports 2841–2850 and an additional TCP connection using
source port 41796.

The provided capture output showed a completed handshake
for the additional connection. Corresponding final ACK
packets were not shown for the ten controlled SYN attempts.

The ACK-count discrepancy in the initial script output
requires verification.

## Limitations

- The current implementation performs basic packet counting.
- It does not reliably correlate individual TCP handshakes.
- It does not implement comprehensive time-based SYN flood detection.
- Packet counts alone cannot confirm a SYN flood attack.

## Future Improvements

- Calculate SYN packet rates over time.
- Correlate packets by TCP connection.
- Improve incomplete-handshake analysis.
- Generate more detailed automated reports.

## Learning Outcomes

This project provided practical experience with TCP,
network packet capture, Wireshark filters, TShark,
Linux command-line tools, and Bash automation.

## Disclaimer

This project was developed for educational purposes.
Experiments were performed against a local test server
in a controlled laboratory environment.
