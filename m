From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] can fd: Add separate bittiming infrastructure
Date: Sat, 18 Jan 2014 18:34:32 +0100
Message-ID: <52DABB28.4070608@hartkopp.net>
References: <52D6CB48.9010206@hartkopp.net> <52D8DF40.7050405@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:53343 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaARRei (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jan 2014 12:34:38 -0500
In-Reply-To: <52D8DF40.7050405@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Stephane,

On 17.01.2014 08:44, Stephane Grosjean wrote:

>> +#define CAN_CTRLMODE_FD            0x20    /* CAN FD mode */
> 
> - What is exactly the goal of this new CAN_CTRLMODE_FD please? Did you define
> it to allow user to enable the CANFD function into the hardware, for example?
> If yes, isn't it redundant with setting the MTU to 72 bytes?
> 
> - Moreover, how a CANFD -able driver has to handle a CANFD frame read from the
> CANFD controller, when its network device MTU *ISNOT* == 72 ??? Should it
> discard the CANFD frame?

The stuff in linux/net/can/ takes care that only applications that know (and
enable) CAN FD get CAN frames with a length > 8 byte.

E.g. today a CAN FD frame with only 8 bytes (aka CANFD8) can be passed to
applications that are not CAN FD capable. In this case the size (MTU)
is reduced from CANFD_MTU to CAN_MTU, see:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/net/can/raw.c?id=e2d265d3b587f5f6f8febc0222aace93302ff0be

and 

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/raw.c#n753

This leads IMO to two questions:

1. Is it a good idea to provide CANFD8 frames to legacy applications?
2. If yes, should the CAN FD controller driver be able to make legacy frames
   CANDF8 frames to support the higher data bitrate for legacy applications?

Maybe even the first question has to be denied (and the adaption in can/raw.c
should be removed then) ?!?

My idea behind CAN_CTRLMODE_FD is to enable/disable the CAN FD mode in the
CAN FD capable controller chip.

Depending on this CAN_CTRLMODE_FD the CAN FD functionality is enabled when
this feature is supported(!) by the driver, see priv->ctrlmode_supported:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/dev.c#n669

Depending on CAN_CTRLMODE_FD the MTU is then set to CAN_MTU or CANFD_MTU
(note that the interface has to be 'down' when configuring this feature -
that's just the same as with configuring the bitrate).

When CAN_CTRLMODE_FD was set but the second bitrate was *not* set before the
interface is requested to be set to 'up' this leads to the same error as if
the (single and only) bitrate is missing today.

I hope this would be a reasonable solution and I was able to describe it well.

Comming back to question 2 from above, we would then need an additional
controlmode:

#define CAN_CTRLMODE_TX_FD8 0x40    /* send legacy CAN frames in FD mode */

But I'm not really sure if these two 'compatibility' tweaks for legacy
applications to use CAN FD8 is a wanted/needed feature.

Any thoughts?

> 
>>     /*
>>    * CAN device statistics
>> @@ -122,6 +123,9 @@ enum {
>>       IFLA_CAN_RESTART_MS,
>>       IFLA_CAN_RESTART,
>>       IFLA_CAN_BERR_COUNTER,
>> +    IFLA_CAN_DATA_BITTIMING,
>> +    IFLA_CAN_DATA_BITTIMING_CONST,
>> +    IFLA_CAN_DATA_CLOCK,
>>       __IFLA_CAN_MAX
>>   };
> 
> - by defining another clock for the data bitrate, do you suppose that some
> hardwares could use different clocks for both arbitration and data bitrates?

Yes. But this is probably not necessary. I just looked into the M_CAN
specification. They have *one* CAN clock and two different baud rate
prescalers. So I would tend to remove IFLA_CAN_DATA_CLOCK in the next RFC
until a real requirement emerges from some real hardware.

Best regards,
Oliver

