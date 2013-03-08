From: =?ISO-8859-1?Q?Michael_Th=E9nault?= <michael.thenault@gmail.com>
Subject: Re: write: No buffer space available
Date: Fri, 8 Mar 2013 11:24:43 +0100
Message-ID: <CACekSAML-BgcW5CWNfns_V0HgqsEFEHXQ06AdLAMupDKefmnFQ@mail.gmail.com>
References: <CACekSAN4Roq50mr7+2P5Fk8zxY6hSOErqgrxu-3sLbyS7SzwJQ@mail.gmail.com>
 <5138C20B.1070306@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37127 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab3CHKZE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 05:25:04 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so1797490iea.33
        for <linux-can@vger.kernel.org>; Fri, 08 Mar 2013 02:25:03 -0800 (PST)
In-Reply-To: <5138C20B.1070306@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hello,

Indeed after connecting the arm board to a termination, I'm able to
see traffic with the oscilloscope.
I noticed that after sending only one frame with cansend, I see
traffic all the time with the oscilloscope. I guess that the reason is
the lack of ACK frames coming from other nodes, which causes re-sends.

Thanks again,

Michael


2013/3/7 Oliver Hartkopp <socketcan@hartkopp.net>:
> Hello Michael,
>
> there are more than one threads handling the "no buffer space" questi=
on :-)
>
> Usually there is no correct CAN network attached to the CAN interface=
, means:
>
> - there is a least a second CAN node which can acknowledge the sent C=
AN frames
> - the bitrate is identical for all CAN nodes
> - the CAN bus is terminated properly (with 2x 120 =3D 60 Ohms)
>
> If you have a working CAN network try to attach your Linux box and re=
ad the
> data from the working environment first.
>
> So you can be sure, that the bitrate settings and terminations are co=
rrect.
>
> Regards,
> Oliver
>
>
> On 07.03.2013 10:55, Michael Th=E9nault wrote:
>
>> hello,
>>
>> I'm working on a arm system with the 2.6.38.8 kernel.
>> When I try to send can frames (with cansend, cangen or sockets) the =
tx
>> queue is getting full and then i get this error :
>>
>> write: No buffer space available
>>
>> I've been monitoring the CAN bus with an oscilloscope and nothing
>> seems to happen.
>> I saw a thread with the similar problem, and there was some problem
>> with the one-shot mode. This mode doesn't work with me :
>>
>> # ip link set can0 up type can one-shot on
>> RTNETLINK answers: Operation not supported
>>
>> here are some details :
>>
>> # ip -details -statistics link show can0
>> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKN=
OWN qlen 10
>>     link/can
>>     can state ERROR-PASSIVE restart-ms 0
>>     bitrate 125000 sample-point 0.875
>>     tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>>     clock 8000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          4          4          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     0          0        0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     0          0        3       3       0       0
>>
>> what am i doing wrong ?
>> Thank you in advance for your help
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
