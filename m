From: Michael Muldoon <mbmuldoon07@gmail.com>
Subject: Re: can acknowledgment
Date: Thu, 5 Sep 2013 08:47:44 -0400
Message-ID: <CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
	<CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
	<818b112277dbc87b883edf93f165ecff@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64618 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab3IEMrp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Sep 2013 08:47:45 -0400
Received: by mail-wi0-f169.google.com with SMTP id hj3so4560856wib.4
        for <linux-can@vger.kernel.org>; Thu, 05 Sep 2013 05:47:44 -0700 (PDT)
In-Reply-To: <818b112277dbc87b883edf93f165ecff@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Aiken, Scott" <Scott.Aiken@karlstorz.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Before doing anything
can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
mode DEFAULT qlen 10
    link/can
    can <TRIPLE-SAMPLING> state ERROR-ACTIVE restart-ms 0
    bitrate 500000 sample-point 0.850
    tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 10000000

candump works fine as long as there are two other devices on the
network if just one there is nothing.

after attempting to send a can message:
can0: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN
mode DEFAULT qlen 10
    link/can
    can <TRIPLE-SAMPLING> state BUS-OFF restart-ms 0
    bitrate 500000 sample-point 0.850
    tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 10000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          1          1          1
    RX: bytes  packets  errors  dropped overrun mcast
    101600     12700    0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
if restart-ms is set it doesn't go down after sending a can message.

Also the device I' using is a Janus-RC intelligent terminus using busy
box if you guys know anything about it and has two can networks and it
is exactly the same for both so I don't know if that means it could
still be a CAN_TX pin problem or not.

Thanks

On Thu, Sep 5, 2013 at 4:31 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On Wed, 4 Sep 2013 16:40:37 -0400, Michael Muldoon <mbmuldoon07@gmail.com>
> wrote:
>> Thanks for responding.  The bitrate is definitely right if I send the
>> candump command I can see the traffic being sent by the other two
>> devices on the network. The problem is if I take either of the other
>> two devices off the network candump sees nothing and at not point does
>> cansend ever work.
>
> What does "ip -d -s link show can0" list after you try sending out
> messages?
> And what does "candump -e any,0:0,#FFFFFFFF" report while sending?
>
> Wolfgang.
>
