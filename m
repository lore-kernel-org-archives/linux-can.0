From: cedric koch-hofer <cedric.koch-hofer@snowsat.com>
Subject: Re: Configuration CAN sja1000_isa
Date: Thu, 26 Apr 2012 10:17:57 +0200
Message-ID: <CALptkFSUrfcktNof43BL9anBb0SuJCye4ELd9qAWNA-F9T_svQ@mail.gmail.com>
References: <CALptkFSikmR9wix-fvuD9ckxt1-PWSFQUYP3ekrZ7kL4WJ54iQ@mail.gmail.com>
	<4F99015A.2050606@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54679 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab2DZIR6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Apr 2012 04:17:58 -0400
Received: by iadi9 with SMTP id i9so1255551iad.19
        for <linux-can@vger.kernel.org>; Thu, 26 Apr 2012 01:17:58 -0700 (PDT)
In-Reply-To: <4F99015A.2050606@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

It is wired and you can see the trace that I forget to include in my
previous mail 8-)

-- TRACE BEGIN --

09:08 root@snowsat-945GS/root
[1002] > modprobe sja1000_isa "mem=0xda000,0xda200"  "irq=1,2"
09:08 root@snowsat-945GS/root
[1003] > dmesg
[  651.408826] CAN device driver interface
[  651.411377] sja1000 CAN netdevice driver
[  651.421680] sja1000_isa sja1000_isa.0: sja1000_isa device
registered (reg_base=0xc00da000, irq=1)
[  651.427146] sja1000_isa sja1000_isa.1: sja1000_isa device
registered (reg_base=0xc00da200, irq=2)
[  651.428286] Legacy sja1000_isa driver for max. 8 devices registered
09:08 root@snowsat-945GS/root
[1004] > ip link set can0 type can bitrate 125000
09:12 root@snowsat-945GS/root
[1005] > dmesg
[  651.408826] CAN device driver interface
[  651.411377] sja1000 CAN netdevice driver
[  651.421680] sja1000_isa sja1000_isa.0: sja1000_isa device
registered (reg_base=0xc00da000, irq=1)
[  651.427146] sja1000_isa sja1000_isa.1: sja1000_isa device
registered (reg_base=0xc00da200, irq=2)
[  651.428286] Legacy sja1000_isa driver for max. 8 devices registered
[  863.738418] sja1000_isa sja1000_isa.0: setting BTR0=0x03 BTR1=0x1c
09:12 root@snowsat-945GS/root
[1006] >  ip -details link show can0
5: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
   link/can
   can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
   bitrate 125000 sample-point 0.875
   tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
   sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
   clock 8000000
09:13 root@snowsat-945GS/root
[1007] > ip link set can0 up type can
09:13 root@snowsat-945GS/root
[1008] >  ip -details link show can0
5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
   link/can
   can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
   bitrate 125000 sample-point 0.875
   tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
   sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
   clock 8000000
09:13 root@snowsat-945GS/root
[1009] > dmesg
[  651.408826] CAN device driver interface
[  651.411377] sja1000 CAN netdevice driver
[  651.421680] sja1000_isa sja1000_isa.0: sja1000_isa device
registered (reg_base=0xc00da000, irq=1)
[  651.427146] sja1000_isa sja1000_isa.1: sja1000_isa device
registered (reg_base=0xc00da200, irq=2)
[  651.428286] Legacy sja1000_isa driver for max. 8 devices registered
[  863.738418] sja1000_isa sja1000_isa.0: setting BTR0=0x03 BTR1=0x1c

-- TRACE END --

On Thu, Apr 26, 2012 at 10:03 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 04/26/2012 09:35 AM, cedric koch-hofer wrote:
>> Hello all,
>>
>> I am currently trying to use the CAN output of an Aaeon embedded
>> system using sja1000 CAN chipset controler.
>> I am using an Ubuntu with a kernel 3.0 and I do not succeed to change
>> the state of my can device from down to up.
>> As you can see in the following trace, all seems to work untill I try
>> to activate my CAN network interface.
>> After that, the interface is in state "UNKNOWN" and I can not use it
>> with the socketcan tools: cansend, candump, cansniffer...
>>
>> Any idea will be welcome,
>
> That's wired. Does it work with "ifconfig can0 up"?
>
> Wolfgang.
>
>
