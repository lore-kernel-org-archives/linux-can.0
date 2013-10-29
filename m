From: =?UTF-8?B?Ik1hcnRpbiBLb8W+dXNrw70gW0tLIG1pY3JvIHMuci5vLl0i?=
	<mkozusky@kkmicro.cz>
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued (was
 CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
Date: Tue, 29 Oct 2013 14:00:18 +0100
Message-ID: <526FB162.9000700@kkmicro.cz>
References: <l4b8eg$40b$1@ger.gmane.org> <526A6B28.4040800@kkmicro.cz> <526AB12C.7090900@grandegger.com> <526C0768.8040903@kkmicro.cz> <526C1A90.4050005@grandegger.com> <526F9216.6010506@kkmicro.cz> <526FA40D.8000202@grandegger.com> <526FA899.2070708@grandegger.com> <526FAEBE.20808@kkmicro.cz> <526FAFE9.2040607@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.aquastore.cz ([37.157.193.242]:53551 "EHLO
	server.aquastore.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab3J2NA2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Oct 2013 09:00:28 -0400
In-Reply-To: <526FAFE9.2040607@mlbassoc.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gary Thomas <gary@mlbassoc.com>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

-------- Original Message  --------
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued=
 (was CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
=46rom: Gary Thomas
To: Martin Kozusky, linux-can@vger.kernel.org
Date: 29. =C5=98=C3=ADjen 2013 13:54:01

> On 2013-10-29 06:49, Martin Kozusky wrote:
>> Dne 29.10.2013 13:22, Wolfgang Grandegger napsal(a):
>>> On 10/29/2013 01:03 PM, Wolfgang Grandegger wrote:
>>>> On 10/29/2013 11:46 AM, Martin Kozusky wrote:
>>>>> Dne 26.10.2013 21:40, Wolfgang Grandegger napsal(a):
>>>>>> On 10/26/2013 08:18 PM, Martin Kozusky wrote:
>>>>>>> Dne 25.10.2013 19:58, Wolfgang Grandegger napsal(a):
>>>>>>>> Hi Martin,
>>>>>>>>
>>>>>>>> On 10/25/2013 02:59 PM, Martin Kozusky wrote:
>>>>>>>>> Dne 24.10.2013 15:48, Martin Kozusky napsal(a):
>>>>>>>>>> Hello,
>>>>>>>>>> after more than year I'm back with CAN fifo overrun problems=
 on
>>>>>>>>>> i.MX25
>>>>>>>>>> board.
>>>>>>>>>> (it was good enough earlier, if some frames were lost, but n=
ot this
>>>>>>>>>> time)
>>>>>>>>>>
>>>>>>>>>> I have 2 flexcan interfaces, each receiving around 1100 msgs=
/s
>>>>>>>>>> (situation is a little better if I use just one iface, but I=
 need
>>>>>>>>>> both)
>>>>>>>>>> I just configure them and then run:
>>>>>>>>>>
>>>>>>>>>> I=3D0; while [ $I -le 20 ]; do dd if=3D/dev/zero of=3D/mnt/m=
mcblk0p1/test
>>>>>>>>>> bs=3D512 count=3D200; sync; sleep 1; I=3D$(($I+1)); done
>>>>>>>>>> (simulate writing to SDcard with 100KB blocks in 1 sec inter=
vals)
>>>>>>>>>>
>>>>>>>>>> and start sending data from another device.
>>>>>>>>>>
>>>>>>>>>> I am not running any other program (like candump etc) to rea=
d from
>>>>>>>>>> CAN.
>>>>>>>>>>
>>>>>>>>>> this is what is shown after I finish sending 35777 packets (=
both
>>>>>>>>>> interfaces now connected to same bus so they should receive =
same
>>>>>>>>>> data)
>>>>>>>>>> with ip -d -s link show can0/1
>>>>>>>>>>
>>>>>>>>>> 2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qle=
n 10
>>>>>>>>>>         link/can
>>>>>>>>>>         can <LISTEN-ONLY> state STOPPED (berr-counter tx 0 r=
x 0)
>>>>>>>>>> restart-ms 0
>>>>>>>>>>         bitrate 250000 sample-point 0.857
>>>>>>>>>>         tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>>>>>>>>>>         flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 =
brp-inc 1
>>>>>>>>>>         clock 66500000
>>>>>>>>>>         re-started bus-errors arbit-lost error-warn error-pa=
ss bus-off
>>>>>>>>>>         0          0          0          1          1       =
   0
>>>>>>>>
>>>>>>>> Do you have electrical problems on the bus? Or is reaching
>>>>>>>> error-passive
>>>>>>>> not related to this problem?
>>>>>>> It is not related to this problem - there is only RX pin connec=
ted on
>>>>>>> can0 (RX is connected in parallel with Coldfire V1 MCU CAN, whi=
ch is
>>>>>>> doing TX)
>>>>>>>
>>>>>>>
>>>>>>>>>>         RX: bytes  packets  errors  dropped overrun mcast
>>>>>>>>>>         151769     19000    1699    0       1699    0
>>>>>>>>>>         TX: bytes  packets  errors  dropped carrier collsns
>>>>>>>>>>         0          0        0       0       0       0
>>>>>>>>>> root@vmx25 /opt/waytracer$ /root/utils/ip -d -s link show ca=
n1
>>>>>>>>>> 3: can1: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qle=
n 10
>>>>>>>>>>         link/can
>>>>>>>>>>         can state STOPPED (berr-counter tx 0 rx 0) restart-m=
s 0
>>>>>>>>>>         bitrate 250000 sample-point 0.857
>>>>>>>>>>         tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>>>>>>>>>>         flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 =
brp-inc 1
>>>>>>>>>>         clock 66500000
>>>>>>>>>>         re-started bus-errors arbit-lost error-warn error-pa=
ss bus-off
>>>>>>>>>>         0          0          0          0          0       =
   0
>>>>>>>>>>         RX: bytes  packets  errors  dropped overrun mcast
>>>>>>>>>>         157377     19696    2664    0       2664    0
>>>>>>>>>>         TX: bytes  packets  errors  dropped carrier collsns
>>>>>>>>>>         0          0        0       0       0       0
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> With just one iface used:
>>>>>>>>>>
>>>>>>>>>> 2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qle=
n 10
>>>>>>>>>>         link/can
>>>>>>>>>>         can <LISTEN-ONLY> state STOPPED (berr-counter tx 0 r=
x 0)
>>>>>>>>>> restart-ms 0
>>>>>>>>>>         bitrate 250000 sample-point 0.857
>>>>>>>>>>         tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>>>>>>>>>>         flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 =
brp-inc 1
>>>>>>>>>>         clock 66500000
>>>>>>>>>>         re-started bus-errors arbit-lost error-warn error-pa=
ss bus-off
>>>>>>>>>>         0          0          0          1          1       =
   0
>>>>>>>>>>         RX: bytes  packets  errors  dropped overrun mcast
>>>>>>>>>>         233277     29201    1483    0       1483    0
>>>>>>>>>>         TX: bytes  packets  errors  dropped carrier collsns
>>>>>>>>>>         0          0        0       0       0       0
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Too many packets are lost.
>>>>>>>>>>
>>>>>>>>>> I tried to play with FLEXCAN_NAPI_WEIGHT (quota for napi) an=
d that
>>>>>>>>>> didn't hepl too much, if I put it too high then the system r=
esponse
>>>>>>>>>> was slow and packets still lost, also tried to change priori=
ty of CAN
>>>>>>>>>> interrupts with (don't know if correctly)
>>>>>>>>>>       // imx_irq_set_priority(43,14);
>>>>>>>>>>       // imx_irq_set_priority(44,14);
>>>>>>>>>>
>>>>>>>>>> But it didn't help either.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Does anybody have any idea how not to lose any packets? :)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>> I tried to disable
>>>>>>>>> //netif_receive_skb(skb); in  flexcan_read_frame() and other =
functions
>>>>>>>>> so that data is not processed further in system
>>>>>>>>
>>>>>>>> Well ...
>>>>>>>>
>>>>>>>>> It didn't help.
>>>>>>>>> So I tried to put time_start=3Dktime_get_real() at the begini=
ng of
>>>>>>>>> flexcan_read_frame(), then time_stop=3Dktime_get_real(); at t=
he end and
>>>>>>>>> add their difference to the global variable
>>>>>>>>> time_total+=3Dtime_stop-time_start;
>>>>>>>>> I divided this time_total by rx_packets count at flexcan_chip=
_stop and
>>>>>>>>> wrote with dev_info into log (variables were initialized in
>>>>>>>>> flexcan_chi_start, so I could just do ifconfig can0 up/down a=
nd reset
>>>>>>>>> those counters and write them to log), so now I had average t=
ime spent
>>>>>>>>> int flexcan_read_frame.
>>>>>>>>> This time it was around 100usec! just with one CAN used, if b=
oth were
>>>>>>>>> connected, it was more than twice. And many CAN frames were l=
ost.
>>>>>>>>>
>>>>>>>>> So I tried to disable
>>>>>>>>>        /*
>>>>>>>>>            skb =3D alloc_can_skb(dev, &cf);
>>>>>>>>>            if (unlikely(!skb)) {
>>>>>>>>>                    stats->rx_dropped++;
>>>>>>>>>                    return 0;
>>>>>>>>>            }
>>>>>>>>>         */
>>>>>>>>> and made "struct can_frame cf" (not pointer, so that I can us=
e it in
>>>>>>>>> flexcan_read_fifo call)
>>>>>>>>> And tried to send data again.
>>>>>>>>> Now - average time in flexcan_read_frame was not 100usec, but=
 just 2
>>>>>>>>> usec! 50x less ...  no CAN frame was lost, even if I was usin=
g both
>>>>>>>>> CAN
>>>>>>>>> interfaces, each getting over 1100 msgs/sec and writing 100KB=
 data
>>>>>>>>> to SD
>>>>>>>>> card.
>>>>>>>>
>>>>>>>> ... but the messages need to be allocated, queued, delivered t=
o and
>>>>>>>> even
>>>>>>>> processed by a user space task. What you messure it part of th=
e network
>>>>>>>> stack overhead but 100us just for alloc_can_skb() seems quite =
a lot to
>>>>>>>> me. At what frequency is your CPU running? Is the system low o=
f memory?
>>>>>>>> Maybe your system is simply not fast enough. To see what code =
is
>>>>>>>> involved just follow:
>>>>>>> CPU is i.MX25, should be running at 400MHz. There is 64MB RAM t=
otally
>>>>>>> and free enough :(
>>>>>>>
>>>>>>>>
>>>>>>>>      http://lxr.free-electrons.com/ident?i=3Dalloc_can_skb
>>>>>>>>> So I am asking - how to make this alloc_can_skb faster (or is=
 there
>>>>>>>>> any
>>>>>>>>> alternative)? Or if there is another way how to get data to u=
ser?
>>>>>>>>
>>>>>>>> Well, not with Linux-CAN. Anyway, messages arrive at a rate of
>>>>>>>> approx. 1
>>>>>>>> KHz. So there is 1ms per message. I think it's a latency probl=
em in the
>>>>>>>> first place. The Flexcan on the i.MX25 can queue up to 5 messa=
ges. If
>>>>>>>> the queue is full you loose messages. This obviously happens w=
hen the
>>>>>>>> SDcard is accessed.
>>>>>>>>
>>>>>>>> Could you take function traces on your system?
>>>>>>> Is there any special tool for this or should I use my start/sto=
p timers?
>>>>>>
>>>>>> Your start/stop timers will not show what other activity is dist=
urbing
>>>>>> the CAN messages reception. There is the Linux function tracer:
>>>>>>
>>>>>>     http://lxr.free-electrons.com/source/Documentation/trace/ftr=
ace.txt
>>>>>>
>>>>>> It need to be enabled in the kernel. Especially event and functi=
on
>>>>>> tracing could help to better understand your problems.
>>>>> Hello Wolfgang,
>>>>> it seems that my architecture (arm/mx25 on 2.6.35 kernel) is miss=
ing
>>>>> HAVE_FUNCTION_GRAPH_TRACER, HAVE_DYNAMIC_FTRACE options so it won=
't be
>>>>> that easy, will be?
>>>>> Timestamps that ftrace is showing me are in 10 miliseconds resolu=
tion,
>>>>> that won't help me much :(
>>>>
>>>> Probably that version is to old for proper ftrace support. The 100=
us you
>>>> measured for alloc_can_skb() is worst case, right? What is the mea=
n value?
>>>
>>> Flexcan support was added to the mainline kernel 2.6.36. Where did =
you
>>> get your flexcan driver from? Could you post it please here? Any ch=
ance
>>> to switch to a (more) recent version of the Linux kernel?
>>
>> It is 2.6.35.9 kernel, I think flexcan was backported from 2.6.36 by=
 board developer who made patch for this kernel. But I am keeping it "u=
pdated" with latest updates from 3.x
>> kernel, so I think there should be no errors in this driver.
>> I tried to switch to 2.6.39 but I think there were some errors with =
the kernel patch that adds support for this board so I gave up. May be =
I should try again.
>
> What board are you using?
>
> I've had good success with the mainline kernel 3.4 on i.MX25
> n.b. I haven't tried CAN with that board yet, but the flexcan
> driver is standard in that version.
>
This one: http://www.voipac.com/#X25-DMM-254
They don't have patch for 3.x yet, they are working on WinCE for this o=
ne now :) So may be later ...

Martin

