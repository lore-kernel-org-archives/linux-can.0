From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can probable bug
Date: Mon, 17 Dec 2012 15:50:55 +0100
Message-ID: <50CF314F.9040201@grandegger.com>
References: <loom.20121211T155025-697@post.gmane.org> <50C7AE44.4040603@grandegger.com> <loom.20121217T124707-860@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59945 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2LQOu5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Dec 2012 09:50:57 -0500
In-Reply-To: <loom.20121217T124707-860@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Christian Bendele <Christian.Bendele@gmx.net>
Cc: linux-can@vger.kernel.org

Hi Christian,

On 12/17/2012 02:21 PM, Christian Bendele wrote:
> Hi,
> 
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>> Yes, note that the PCH does use a C_CAN core (even the manual is identical).
> 
> Indeed.
> 
> 
>> Please do not invest time fixing the pch_can driver. We want to get rid
>> of it asap.
> 
> Okay, I have turned my efforts towards the c-can driver now. I've had some
> issues with some of the design decisions of the pch driver anyway. Some of those
> issues seem to be absent from the c-can driver after a first glance.
> 
> 
>>> That means that the message(s) stored in this message object are never read
>>> out, and the INTPND (interrupt pending, is set together with NEWDAT when a
>>> message is stored into the object) bit in that message object's control
>>> register is never cleared.
>>
>> Looking to c_can.c, I see this problem as well. The above check should
>> be done after reading out the message.
> 
> That's what I thought as well, but after a closer look at c_can_do_rx_poll()
> method of the c_can driver I disagree. I think the way this driver works the
> check for the EOB bit should not be necessary at all. Neither before nor after
> reading out the message. The loop will already be exited after that message
> object is read out due to "msg_obj <= C_CAN_MSG_OBJ_RX_LAST" in the loop header.

I also did not understand what this test is good for.

>> Could you please use my "RFC V3" c_can_pci driver patches I sent out an
>> hour ago. Anyway, avoiding out-of-order reception with a message FIFO is
>> tricky and we need to fix that part as well. Unfortunately, I do not
>> have a system for development and testing.
> 
> I tried your RFC V3 drivers now. As you sent them they work about as well as the
> pch driver. The generally seem to have similar bugs as the latter, too. 
> 
> I was quite surprised, however, that the c_can driver actually caused (very
> slightly) higher CPU load for a given CANBUS load than the pch driver.
> I had looked at the code before testing it, and some issues I had with design
> decisions of the pch driver (among other things it failed to make proper use of
> the message handling registers the c-can controller provides) seemed to be much
> better with the c_can driver. I had therefore expected it to cause _lower_ cpu
> load than the pch driver and was somewhat disappointed. I'll have to give this a
> closer look after the holidays, maybe I can find the reasons why this happens.
> 
> I then removed the two lines that check for the EOB bit. That seems to fix all
> hangs that I observed on the RX end. It seems to be quite stable now, even under
> high load. I'm not really sure if I consider the out-of-order reception problems
> important right now.

OK, we should avoid out-of-order reception, if possible. At least we can
do better.

> The TX side still seems to have hickups (hangs, as observed by others as well).

Hm, with these patches the others do not see TX problems any more. Could
you please be more precise.

> I'll try to look into that before the holidays, but I make no promises that I'll
> find the time.

Thanks,

Wolfgang.

