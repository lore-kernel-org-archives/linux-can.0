From: Hans L <thehans@gmail.com>
Subject: Re: Troubleshooting bus errors, bus turns off during canplayer playback
Date: Wed, 21 Dec 2016 12:08:45 -0600
Message-ID: <CAFoRp-P4Arepyya2PyzLVzNLdn60FR1dzVzUCSQx5CJTxLt=qQ@mail.gmail.com>
References: <CAFoRp-PSPtdenVSihp+Ar-1xfsOQd1M6rrUN6kgMOGd2egCcoA@mail.gmail.com>
 <7f223f19-7e27-50f4-85c2-3c6785deae91@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35196 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbcLUSJz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2016 13:09:55 -0500
Received: by mail-ua0-f175.google.com with SMTP id 2so85383860uax.2
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2016 10:09:26 -0800 (PST)
In-Reply-To: <7f223f19-7e27-50f4-85c2-3c6785deae91@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm reading some of these links talking about the issue of dealing
with multiple programs acessing the socket, but in the case I'm
dealing with, there's only one program connecting to the can socket on
this device.  That program is canplayer.  So I would need to patch
canplayer with that setsockopt code you are suggesting?

On Mon, Dec 19, 2016 at 11:01 PM, Tom Evans <tom_usenet@optusnet.com.au> wrote:
> On 20/12/16 15:53, Hans L wrote:
>>
>> I'm a developer writing firmware for a J1939 device and I have some
>> logs recorded from vehicles that I want to use as test data, playing
>> these on a "bench" setup.
>>
>> I am using a Beaglebone black running debian, with a PEAK PCAN-USB
>> adapter to play these logs on my test bus.
>>
>> When I attempt to play a log that has pretty high bus utilization, it
>> just quits after sending few frames with "No buffer space available".
>
>
> That's an old problem that everyone runs into eventually.
>
> It has come up before on this list.
>
> Here's something I posted in March 2015:
>
> ====
>
> Sockets can block or return ENOBUFS. Ethernet blocks before it returns
> ENOBUFS like you'd expect. With CAN it does the opposite "out of the box"
> and needs to be fixed.
>
> http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html
>
>     With Ethernet, the transmit queue length is 1000 (which would
>     return ENOBUF) but before that happens it hits SO_SNDBUF,
>     which may be 108544, which is the total Data plus SKB, and
>     with an SKB size of about 200 that means it blocks at about
>     500 before it ENOBUFs at 1000.
>
>     With CAN, it would block at 500, but it ENOBUFs at 10 first with
>     the default queue depth!
>
> I do the following to get a 256-deep queue that blocks before it overflows:
>
>     /bin/echo 256 > /sys/class/net/can0/tx_queue_len
>     /bin/echo 256 > /sys/class/net/can1/tx_queue_len
>
>     int sndbuf = (250 + 8) * 256;
>     socklen_t socklen = sizeof(sndbuf);
>     /* Minimum socket buffer to try and get it blocking */
>     rc = setsockopt(pSkt->skt, SOL_SOCKET, SO_SNDBUF,
>                     &sndbuf, sizeof(sndbuf));
>
> You might also like to read:
>
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>
>     SocketCAN and queueing disciplines:
>     Final Report
>     M. Sojka, R. Lisov y, P. P   sa
>     Czech Technical University in Prague
>     July 20, 2012
>     Version 1.2
>
> Tom
>
