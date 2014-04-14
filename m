From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Error Active
Date: Mon, 14 Apr 2014 14:38:44 +0000
Message-ID: <81adc4d92d94ab4bcbd3cdadbd56853e@grandegger.com>
References: <15704970.EHNVEi1RO0@lisa> <11552477.qsHBqKfRM3@lisa>
 <a60984530bb93305b1c3dfac1b3403d4@grandegger.com> <2625052.FRqudkDGEA@lisa>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:56677 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbaDNOip (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Apr 2014 10:38:45 -0400
In-Reply-To: <2625052.FRqudkDGEA@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org

On Mon, 14 Apr 2014 14:13:33 +0200, Steffen Rose <ro@emtas.de> wrote:
> Hello Wolfgang,
> 
> thank you very much for your answers.
>  
>> libsocketcan, like ip uses a netlink socket to get the configuration
and
>> statistics of the CAN device. This includes the "state" property.
> 
> Do all implementation support the netlink socket, especially the CAN
state?

Yes.

> I think, state is UNKNOWN and don't mean the Can state, is it?

> $ ip -det -stat link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast *state*
UNKNOWN
> qlen 

This "state" is network related.

> 10000

It follows the CAN related settings and statistics.

>     link/can 
>     *can state* ERROR-ACTIVE restart-ms 0 
>     bitrate 250000 sample-point 0.875 
>     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>     ems_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          0          0          0         
>     RX: bytes  packets  errors  dropped overrun mcast   
>     0          0        0       0       0       0      
>     TX: bytes  packets  errors  dropped carrier collsns 
>     0          0        0       0       0       0      
> 
>  
>> > Do socketcan have different ways to get the current state? Is it a
low
>> > level
>> > driver part to read and hold the current state?
>> 
>> No. Both get the infos via netlink socket from the kernel.

This answer is wrong. It has nothing to do with the netlink socket.
Sorry for confusion. Yes, the low-level driver does handle the state
changes
reported by the CAN hardware.

> I'm not so familiar with the parts of the system and the correct naming
of
> it.
> 
> I understand, that socketcan has a common part for all (many) driver 
> adaptations  (can_bcm, can_raw) and a CAN controller specific part
(can).

There is CAN protocol, common CAN devices interface and specific device
drivers.

> As I understand, for the last point exists many different
implementations
> with 
> different feature implementation.

Ideally they do implement the same features but it depends on the hardware
to some extend, of course. The big goal is to provide a *common* interface
for CAN error state and error message handling.

>> > (I'm sorry. I'm unsure about the driver I tested in this situation. I
>> > think,
>> > it was the EMS CPC driver and kernel 3.2.0-60-generic. )
>> 
>> This device uses a SJA1000.
>> 
> 
> My mistake
> USB interface from EMS
> 
> vcan                   12686  0 
> can_bcm                22077  0 
> can_raw                17120  0 
> can                    36556  2 can_bcm,can_raw
> ems_usb                17510  0 
> can_dev                15321  1 ems_usb

OK.

Wolfgang.

