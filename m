From: Casper Mogensen <casper.mogensen@gmail.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 17:32:43 +0100
Message-ID: <CABgkGoGYGpefppHUCnBZQQRX8Nn5_AnVdDPQ-gHs4H7vyVOVXQ@mail.gmail.com>
References: <loom.20121114T160521-534@post.gmane.org>
	<50A4972A.9070707@hartkopp.net>
	<50A4EA87.9020206@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52645 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768379Ab2KOQcp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 11:32:45 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so705501eaa.19
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 08:32:43 -0800 (PST)
In-Reply-To: <50A4EA87.9020206@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org, tomoya.rohm@gmail.com, Bhupesh SHARMA <bhupesh.sharma@st.com>, Alexander Stein <alexander.stein@systec-electronic.com>, federico.vaga@gmail.com, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Hi all

I have been working with the eg20t chipset and the pch_can driver a
lot up until January this year, where the project i was working on
unfortunately was shut down. There is a bug in the implementation,
which causes the transmit buffers to fill up and all become
unavailable. It happens randomly, but is easily triggered with a high
load. I experienced the same problems as Michael.

I have not been working on it for a long time, so i don't recall the
problem precisely, but as i remember there is two memory areas which
is used for communication between the processor and the can core. One
is used for receive, and one is used for transmit in the pch_can
driver. When initiating a transmit, a flag is indicating that an
interrupt must be generated upon transmit receive, if a transmit
interrupt is handled during an ongoing transmit, then problems can
occur.

From pch_xmit in pch_can
on line 940 in pch_can.c: can_put_echo_skb is called, which occupies
the skb(which to my best knowledge, is the reason that you get a
buffer overflow)
on line 943 in pch_can.c: The transmit complete interrupt flag is
written to the internal register (but not writing to the can core yet)
on line 946 in pch_can.c: pch_can_rw_msg_obj is issued, which writes
the internal registers to can core.

If the transmit completed handler has been running between lines 943
or 946, the pch_tx_complete routine will clear the transmit interupt
enable flag in priv->regs->ifregs[1] (same register is used in both),
then you end up writing something the message to the core without
transmit completed interrupt enabled, and with an occupied skb, then
you eventually runs out of transmit buffers, as the skb's are free'd
in pch_tx_complete, which is triggered by a transmit completed
interrupt

I am a little rusty in this issue, as it is quite a long time ago i
was working with it, but i hope the description is understandable :-)

Regards

Casper Mogensen

On Thu, Nov 15, 2012 at 2:13 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 11/15/2012 08:18 AM, Oliver Hartkopp wrote:
>> On 14.11.2012 16:39, Michael Pellegrini wrote:
>>
>>
>>> I am trying to use the pch_can driver to interface with a CANopen system.
>>> I am encountering a serious issue where, at random intervals, the CAN interface
>>> will lock up and stop transmitting data.  Data reception continues normally.
>>> The only way I've found to resolve the issue so far is to issue an
>>> "ifconfig canx down" command followed by an "ifconfig canx up" command.
>>> After the interface is reset through these commands, the TX packet dropped count
>>> and the TX packet carrier count increment by 1.
>>>
>>> I am running Ubuntu 12.04 with kernel version 3.2.0-23.
>>>
>>> Has anyone else seen this problem or have a fix for it?
>>
>>
>> Hello Mike,
>>
>> i put the relevant people into CC that probably know better than me.
>>
>> Btw. using the pch_can driver:
>>
>> 1. Can you please provide the output of
>>
>>       ip -details link show can0
>>
>> (if can0 is your device with the problem)
>> at start time and when the problem happened?
>>
>> 2. Can you send the output of
>>
>>       candump can0,0~0,#FFFFFFFF -e
>>
>> from start time until the problem happens?
>>
>> 3. It turned out that the pch_can controller is created upon the C_CAN
>> CAN controller IP-core. Therefore Wolfgang posted an idea to replace the
>> pch_can driver with a PCI-attached C_CAN driver:
>>
>> http://thread.gmane.org/gmane.linux.can/815
>>
>> I don't know the current state of the tests/replacement.
>
> As you can see from this thread, the replacement patch did not yet
> succesfully run on such a platform. But I definitively would like to get
> rid of the obsolete pch_can driver. Testers are welcome! Michael, would
> you be able/willing to test a patch, even with a recent kernel version?
>
>> But a general C_CAN PCI driver has been contributed by Frederico Vaga which
>> became a mainline driver in June
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=5b92da0443c2585e31b64e86c2e1b8e22845d4bb
>>
>> Don't know if this driver can be used out of the box, when the PCI IDs of the
>> PCH_CAN board are added ...
>>
>> But maybe the guys in CC know ;-)
>
> You need a PCI driver first.
>
> Wolfgang.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards / Med venlig hilsen

Casper Mogensen
