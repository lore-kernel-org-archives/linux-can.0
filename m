From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Troubleshooting bus errors, bus turns off during canplayer
 playback
Date: Thu, 22 Dec 2016 19:03:17 +0100
Message-ID: <0a91af86-8bfb-400d-e37d-080caae667fe@hartkopp.net>
References: <CAFoRp-PSPtdenVSihp+Ar-1xfsOQd1M6rrUN6kgMOGd2egCcoA@mail.gmail.com>
 <7f223f19-7e27-50f4-85c2-3c6785deae91@optusnet.com.au>
 <CAFoRp-P4Arepyya2PyzLVzNLdn60FR1dzVzUCSQx5CJTxLt=qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:33437 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965654AbcLVSD0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2016 13:03:26 -0500
In-Reply-To: <CAFoRp-P4Arepyya2PyzLVzNLdn60FR1dzVzUCSQx5CJTxLt=qQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hans L <thehans@gmail.com>, linux-can@vger.kernel.org

Hello Hans,

On 12/21/2016 07:08 PM, Hans L wrote:
> I'm reading some of these links talking about the issue of dealing
> with multiple programs acessing the socket, but in the case I'm
> dealing with, there's only one program connecting to the can socket on
> this device.  That program is canplayer.  So I would need to patch
> canplayer with that setsockopt code you are suggesting?

the problem may arise when the time gap of CAN frames to be sent is too 
short in the recorded timestamps of the logfile.

When you want to send data at a higher rate than the bandwidth of the 
CAN bus is able to carry, the tx queue will overflow.

When you have a real CAN dump created from a real CAN interface with the 
same bitrate there can be a pile up of CAN frames in the tx queue.

Did you try to increase the tx queue length to create some extra buffer 
to handle these pile ups?

To increase the available tx queue length in the CAN driver, e.g.:

     echo 100 > /sys/class/net/can0/tx_queue_len

   or with the 'ip' tool from the iproute2 package

     ip link set can0 txqueuelen 100

The default is 10 - so you might experiment yourself what is sufficient 
for your use case.

Regards,
Oliver


>
> On Mon, Dec 19, 2016 at 11:01 PM, Tom Evans <tom_usenet@optusnet.com.au> wrote:
>> On 20/12/16 15:53, Hans L wrote:
>>>
>>> I'm a developer writing firmware for a J1939 device and I have some
>>> logs recorded from vehicles that I want to use as test data, playing
>>> these on a "bench" setup.
>>>
>>> I am using a Beaglebone black running debian, with a PEAK PCAN-USB
>>> adapter to play these logs on my test bus.
>>>
>>> When I attempt to play a log that has pretty high bus utilization, it
>>> just quits after sending few frames with "No buffer space available".
>>
>>
>> That's an old problem that everyone runs into eventually.
>>
>> It has come up before on this list.
>>
>> Here's something I posted in March 2015:
>>
>> ====
>>
>> Sockets can block or return ENOBUFS. Ethernet blocks before it returns
>> ENOBUFS like you'd expect. With CAN it does the opposite "out of the box"
>> and needs to be fixed.
>>
>> http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html
>>
>>     With Ethernet, the transmit queue length is 1000 (which would
>>     return ENOBUF) but before that happens it hits SO_SNDBUF,
>>     which may be 108544, which is the total Data plus SKB, and
>>     with an SKB size of about 200 that means it blocks at about
>>     500 before it ENOBUFs at 1000.
>>
>>     With CAN, it would block at 500, but it ENOBUFs at 10 first with
>>     the default queue depth!
>>
>> I do the following to get a 256-deep queue that blocks before it overflows:
>>
>>     /bin/echo 256 > /sys/class/net/can0/tx_queue_len
>>     /bin/echo 256 > /sys/class/net/can1/tx_queue_len
>>
>>     int sndbuf = (250 + 8) * 256;
>>     socklen_t socklen = sizeof(sndbuf);
>>     /* Minimum socket buffer to try and get it blocking */
>>     rc = setsockopt(pSkt->skt, SOL_SOCKET, SO_SNDBUF,
>>                     &sndbuf, sizeof(sndbuf));
>>
>> You might also like to read:
>>
>> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>>
>>     SocketCAN and queueing disciplines:
>>     Final Report
>>     M. Sojka, R. Lisov y, P. P   sa
>>     Czech Technical University in Prague
>>     July 20, 2012
>>     Version 1.2
>>
>> Tom
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
