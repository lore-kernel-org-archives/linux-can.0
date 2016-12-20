From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: Troubleshooting bus errors, bus turns off during canplayer playback
Date: Tue, 20 Dec 2016 00:23:31 -0500
Message-ID: <CAGt3f4kYuUb5VDe7w-HjLYVJDFuE22jE_2dZ_06vGw8rBeLEvg@mail.gmail.com>
References: <CAFoRp-PSPtdenVSihp+Ar-1xfsOQd1M6rrUN6kgMOGd2egCcoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36486 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbcLTFYE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Dec 2016 00:24:04 -0500
Received: by mail-lf0-f41.google.com with SMTP id t196so68595808lff.3
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2016 21:24:03 -0800 (PST)
In-Reply-To: <CAFoRp-PSPtdenVSihp+Ar-1xfsOQd1M6rrUN6kgMOGd2egCcoA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hans L <thehans@gmail.com>
Cc: linux-can@vger.kernel.org

Are you sending messages from the log file with the same source
address as something else currently on the bus is sending from? I get
those same symptoms when I do that (doing the same thing too). I'm
pretty sure the problem is both nodes think they won the arbitration
because they're using the same address, but then the first to try
sending a recessive data bit when the other one's sending a dominant
one gets a bit error. The first node which detected the error then
sends an error frame so all nodes on the bus ignore the frame and see
an error.

I'm using a PEAK PCAN-miniPCIe card with 3.14.43-rt42, and I have a
"berr-counter tx NNN rx NNN" in the `ip -d -s link show` output. I
don't recall whether I've ever looked at those when two nodes are
sending with the same address to see if they increment, but I can
check in a few days after I'm done travelling. For reference, this is
what that output looks like on a random box of mine (I think it has no
CAN wires attached):
brian@box:~$ sudo ip -d -s link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can <TRIPLE-SAMPLING> state ERROR-PASSIVE (berr-counter tx 0 rx
135) restart-ms 1000
        bitrate 250000 sample-point 0.875
        tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
        sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
        clock 8000000
        re-started bus-errors arbit-lost error-warn error-pass bus-off
        0          0          -688250473 1          1          0
    RX: bytes  packets  errors  dropped overrun mcast
    28853734600 3606716825 0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        3606716823 0       0       0

Interestingly, that appears to be without berr-reporting on. When I
explicitly pass "berr-reporting on" in the `ip link set can0 up ...`
command, BERR-REPORTING shows up next to TRIPLE-SAMPLING as expected.
I'll have to check if that has any noticeable effect on the numbers
reported. I too would appreciate a pointer to more detailed
documentation on what exactly that option does.
