#!/bin/bash

# TCP SYN Traffic Analyzer

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <capture.pcapng>"
    exit 1
fi

PCAP="$1"

if [ ! -f "$PCAP" ]; then
    echo "Error: Capture file not found: $PCAP"
    exit 1
fi

if ! command -v tshark >/dev/null 2>&1; then
    echo "Error: TShark is not installed."
    exit 1
fi

echo "======================================"
echo "       TCP SYN TRAFFIC ANALYZER"
echo "======================================"
echo "Capture file: $PCAP"
echo

SYN_COUNT=$(tshark -r "$PCAP" \
    -Y 'tcp.flags.syn == 1 && tcp.flags.ack == 0' \
    -T fields -e frame.number 2>/dev/null | wc -l)

SYN_ACK_COUNT=$(tshark -r "$PCAP" \
    -Y 'tcp.flags.syn == 1 && tcp.flags.ack == 1' \
    -T fields -e frame.number 2>/dev/null | wc -l)

ACK_COUNT=$(tshark -r "$PCAP" \
    -Y 'tcp.flags.ack == 1 && tcp.flags.syn == 0 && tcp.flags.fin == 0 && tcp.flags.rst == 0' \
    -T fields -e frame.number 2>/dev/null | wc -l)

echo "Initial SYN packets : $SYN_COUNT"
echo "SYN-ACK packets     : $SYN_ACK_COUNT"
echo "Non-SYN ACK packets : $ACK_COUNT"

echo
echo "Analysis:"
if [ "$SYN_COUNT" -eq 0 ]; then
    echo "No initial SYN packets found."
else
    echo "Initial SYN packets were detected."
    echo "Packet counts alone cannot confirm a SYN flood."
fi

echo
echo "======================================"