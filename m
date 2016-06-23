From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Clear transmit buffer (of pending queued tx-messages)
Date: Thu, 23 Jun 2016 11:26:17 +0200
Message-ID: <576BAB39.4080006@grandegger.com>
References: <loom.20160622T135857-352@post.gmane.org>
 <loom.20160623T104337-28@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.150]:59815 "EHLO
	mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcFWJ0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2016 05:26:21 -0400
In-Reply-To: <loom.20160623T104337-28@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org

Am 23.06.2016 um 10:45 schrieb ajneu:
> Oliver Hartkopp <socketcan <at> hartkopp.net> writes:
>
>>
>> The question is whether blocking write (and probably write outdated
>> content) is what you want for CAN.
>
> Oliver Hartkopp posted that on a different thread...
> Subject: Re: want blocking writes, but eventually get: errno 105 (No buffer
> space available)
> Date: 2016-06-22 15:52:04 GMT (15 hours and 32 minutes ago)
>
> OK ->
>
> I've tried non-blocking.
> Unfortunately non-blocking will not tell you if messages are delivered or not.
>
> Example:
> If I send out 2 messages (non-blocking) with no participant on the bus,
> those messages will remain queued.

Yes, in software but also hardware queues.

> If 5 minutes later a participant joins the bus, he'll get those 2 very old
> messages: outdated content.

Yep.

> What are my options to solve this?

The only method I know to flush the queue is restarting the device 
(down->up).

> (Can I find out if a message has actually been sent out onto the bus?)

If you really need to known, you could check for the looped back message 
on the same socket enabling CAN_RAW_RECV_OWN_MSGS. But it will slow down 
the message transfers.

> (I'm currently thinking about checking the CAN-Bus status: If NOT
> error-active (and high tx count), I know that tx-messages will not get
> delivered.

Well, the errors could also be caused by other issues. You could check 
for no-ack bus error messages but not all CAN controllers support that 
feature.

> But if I had a few messages in the queue, I still cannot tell which ones got
> delivered. Hmmmm...

See above.

Wolfgang.
