From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Error Active
Date: Mon, 14 Apr 2014 11:05:08 +0000
Message-ID: <a60984530bb93305b1c3dfac1b3403d4@grandegger.com>
References: <15704970.EHNVEi1RO0@lisa>
 <945463a5ffbafb3300795ee2636584f9@grandegger.com> <11552477.qsHBqKfRM3@lisa>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:35644 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbaDNLFK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Apr 2014 07:05:10 -0400
In-Reply-To: <11552477.qsHBqKfRM3@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org

Hi Stefan,

On Mon, 14 Apr 2014 11:56:54 +0200, Steffen Rose <ro@emtas.de> wrote:
> Hello Wolfgang,
> 
>> > What is the standard way to get the state change from Error Passive
to
>> > Error Active?
>> 
>> Historically we only supported "increasing" state changes
>> "active->warning->passive->bus-off". A few recent drivers do
>> also support "passive->warning->active" but most don't (yet).
> 
> Historically:
> What was the correct error handling in state error passive? Did you
ignore
> it 
> in the application? My concrete question is, how did you "define" an
error
> free 
> system after this state change in earlier time?

Well, as I said. The state was never decreased from error passive, which
is wrong, I agree. So far nobody cared.

>> > This will work with the Systec USB interface, but do not work with
>> > Peak,
>> > Beagle bone, EMS CPC.
>> 
>> Some time ago I have posted an RFC for providing "decreasing" state
>> changes
>> as well including proper bus-off recovery for the SJA1000. If would dig
>> it
>> out in case you are interested.
> 
> I'm afraid, I do not write / change my supported socketcan drivers. But
> I'm 
> interested to read the RFC.

Check 

https://gitorious.org/linux-can/wg-linux-can-next/commits/eec921ac28fde243456078a557768808d93d94a3

Especially the commits for "can: sja1000: consolidate error state
handling" and
"can: sja1000: consolidate bus-off handling", which can be regarded as the
reference. The commit messages also shows traces. That's how they should
look
like.

>> > I have seen the implementation in the can utils.
>> > I know, the libsocketcan implements a different way. But I cannot 
>> > extract 
>> > the relevant parts.

libsocketcan, like ip uses a netlink socket to get the configuration and
statistics of the CAN device. This includes the "state" property.

>> > And I think a have to poll the current state with it and I search an 
>> > event 
>> > based mechanism.

That's a bad idea. Looking to the state changes via error messages is far
more elegant.

>> It's not a matter of libsocketcan or ip/iproute2.
> 
> I have seen a difference of the can state between
> candump -e can0,0~0,#FFFFFFFF
> (increase errors - last was error passive)
> 
> and
> ip -det -stat link show can0
> (show error warning state)
> 
> This difference was during transmission on an open can bus with Ack
error
> and 
> state error passive.
> ip got the correct state error passive after receiving a message later,
as
> I 
> did check the error active state change.
> 
> Do socketcan have different ways to get the current state? Is it a low
> level 
> driver part to read and hold the current state?

No. Both get the infos via netlink socket from the kernel.

> (I'm sorry. I'm unsure about the driver I tested in this situation. I
> think, 
> it was the EMS CPC driver and kernel 3.2.0-60-generic. )

This device uses a SJA1000.

Wolfgang.



