From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] Fwd:  sja1000 BasicCAN mode
Date: Thu, 17 Nov 2011 17:24:17 +0100
Message-ID: <4EC53531.8050707@hartkopp.net>
References: <CAF8b2jKKnpUeq_x8O6V4RfdAK741HuPKTqc=3fNRU6C2SDAJ4A@mail.gmail.com>	<20111115082136.GB331@e-circ.dyndns.org>	<B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDC5@SBSPORT.portnet.local>	<CAF8b2j+8co5T-P0CgPPeq7ViJ4DO4JrTLGj-4Y9bSpKHT7SWyQ@mail.gmail.com>	<CAF8b2jJ+eqUMEPekbPy9jwRk=5cMtmF0T3TUrj7qex=LT=LoZg@mail.gmail.com> <20111117161120.GE366@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:57034 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757933Ab1KQQYX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Nov 2011 11:24:23 -0500
In-Reply-To: <20111117161120.GE366@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yuriy Kiselev <kiselev.yuriy@gmail.com>
Cc: socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 17.11.2011 17:11, Kurt Van Dijck wrote:

> On Thu, Nov 17, 2011 at 07:58:09PM +0400, Yuriy Kiselev wrote:
>> 2011/11/15 Heinz-J=C3=BCrgen Oertel <oe@port.de>
>>
>>>
>>>> -----Original Message-----
>>>> From: socketcan-users-bounces@lists.berlios.de [mailto:socketcan-u=
sers-
>>>> bounces@lists.berlios.de] On Behalf Of Kurt Van Dijck
>>>> Sent: Tuesday, November 15, 2011 9:22 AM
>>>> To: Yuriy Kiselev
>>>> Cc: socketcan-users@lists.berlios.de; linux-can@vger.kernel.org
>>>> Subject: Re: [Socketcan-users] sja1000 BasicCAN mode
>>>>
>>>> On Mon, Nov 14, 2011 at 09:08:29PM +0400, Yuriy Kiselev wrote:
>>>>> Hello!
>>>>> Implementation of BasicCAN mode for SJA1000 is in attachment.
>>>>> Now SJA1000_PELICAN_MODE macros in sja1000.h is used for definiti=
on
>>>> PeliCAN
>>>>> or BasicCAN mode. It would be nice to create some menuconfig-wrap=
per, I
>>>>> think.
>>>>> I use this code for a few weeks and it looks stable.
>>>> I see no reason to use BasicCAN mode instead of PeliCAN mode.
>>>> Instead, I do see reasons to use PeliCAN mode:
>>>>
>>>> * no problems when 29bit frames appear on the bus
>>>> * rx queue of 64 byte.
>>>>
>>>> What is your motivation not to use PeliCAN mode?
>>>>
>>>> Kurt
>>>
>>> Kurt is correct. For my understanding, the so-called basic CAN mode=
 of the
>>> SJA1000 is a compatibility mode for the 82c200. It makes no sense t=
o
>>> support it any more with SJA1000 devices.
>>>
>>>  Heinz
>>>
>>
>> Yes, BasicCAN mode is for specific designed devices. My device has o=
nly
>> 5-bits address bus and I can't use PeliCAN mode.
> Still, properly attached SJA1000 is better used in PELICAN mode. I'm =
sure
> you agree.
>=20
> But I see your point.
> Must your hardware be supported by SJA1000?
> Or by a completely seperate 82c200 driver?
> You probably can start from the SJA1000.


AFAIK the SJA1000 driver only uses 32 byte of address space - so 5 bit =
are ok!

Even if the address space of the SJA1000 can be 128 bytes in PeliCAN mo=
de,
these addresses beyond register 31 are usually not in use.
Registers 32 - 127 only contain a view into the internal registers and =
=46IFOs
nobody is using, as the FIFO is also implemented in the standard RX/TX =
frame
registers.

Please check the SJA1000 spec, page 21/22 (PeliCAN address space layout=
)

Regards,
Oliver
