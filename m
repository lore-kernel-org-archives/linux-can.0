From: "Gerhard Bertelsmann" <info@gerhard-bertelsmann.de>
Subject: Re: Standard CAN over IP
Date: Wed, 4 Feb 2015 23:42:00 +0100 (CET)
Message-ID: <63884.88.153.236.115.1423089720.squirrel@webmail.rdts.de>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
    <54D284B4.5050501@uni-bremen.de>
    <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
Reply-To: info@gerhard-bertelsmann.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:46034 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755382AbbBDWvi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 4 Feb 2015 17:51:38 -0500
In-Reply-To: <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org

Hi Mike,

I've already created IMHO the cheapest CAN2ETH ever:

http://lnxpps.de/openwrt/wr841/indexe.html

The red little board uses the cheapest CAN capable PIC micro.
It's firmware is highly optimized ASM code which outperforms
all know diy boards and even some commercial CAN interfaces.

The only drawback it's not doing fancy error reporting - it's
just ignoring errors and try to recover. As of today you need
to setup the baud rate into the source. This will be fixed in the
near future.

Regards

Gerd

Am Mi, 4.02.2015, 22:38, schrieb Mike Purvis:
> Armin=E2=80=94
>
> Fantastic, thanks for the pointer, this is just what I was looking
> for. I've given it a quick try, and the binary in Ubuntu 14.04's
> can-utils package appears to do what I want in terms of creating a ne=
t
> device.
>
> For future travellers, the protocol is documented in the slcan.c
> source file, from the kernel tree:
>
> https://github.com/torvalds/linux/blob/master/drivers/net/can/slcan.c=
#L103
>
> The slcand program is a very thin setup utility that ultimately just
> busy-waits, while the N_SLCAN line discipline on the TTY does all the
> work.
>
> Thanks again,
>
> Mike
>
> On 4 February 2015 at 15:44, Armin Burchardt <armin@uni-bremen.de> wr=
ote:
>> Hi Mike,
>>
>> On 04.02.2015 21:27, Mike Purvis wrote:
>>> system as a socketcan can0 device. Is there some standard component
>>> which already does this, or at least some tooling around serializin=
g
>>> CAN messages to a bytestream?
>>
>> there is slcand (UART to socketcan from the can-utils package) to us=
e
>> serial CAN adapters with socketcan. Implementing the (line based)
>> protocol in the mcu should not be too hard.
>>
>> Armin (switching back to read-only mode)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

