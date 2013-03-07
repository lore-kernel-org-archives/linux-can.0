From: =?ISO-8859-1?Q?Michael_Th=E9nault?= <michael.thenault@gmail.com>
Subject: write: No buffer space available
Date: Thu, 7 Mar 2013 10:55:08 +0100
Message-ID: <CACekSAN4Roq50mr7+2P5Fk8zxY6hSOErqgrxu-3sLbyS7SzwJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36988 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab3CGJz2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Mar 2013 04:55:28 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so287015iea.8
        for <linux-can@vger.kernel.org>; Thu, 07 Mar 2013 01:55:28 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

hello,

I'm working on a arm system with the 2.6.38.8 kernel.
When I try to send can frames (with cansend, cangen or sockets) the tx
queue is getting full and then i get this error :

write: No buffer space available

I've been monitoring the CAN bus with an oscilloscope and nothing
seems to happen.
I saw a thread with the similar problem, and there was some problem
with the one-shot mode. This mode doesn't work with me :

# ip link set can0 up type can one-shot on
RTNETLINK answers: Operation not supported

here are some details :

# ip -details -statistics link show can0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-PASSIVE restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          4          4          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        3       3       0       0

what am i doing wrong ?
Thank you in advance for your help
