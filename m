From: Christian Bendele <Christian.Bendele@gmx.net>
Subject: =?utf-8?b?cGNoX2Nhbg==?= probable bug
Date: Tue, 11 Dec 2012 15:43:57 +0000 (UTC)
Message-ID: <loom.20121211T155025-697@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57226 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab2LKPtz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 11 Dec 2012 10:49:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TiS5s-0006lM-7o
	for linux-can@vger.kernel.org; Tue, 11 Dec 2012 16:50:04 +0100
Received: from 192.198.151.43 ([192.198.151.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 11 Dec 2012 16:50:04 +0100
Received: from Christian.Bendele by 192.198.151.43 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 11 Dec 2012 16:50:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I believe I have found a bug in the pch_can driver. It _might_ also be 
related to what was discussed recently in the thread at
http://thread.gmane.org/gmane.linux.can/2483/focus=2573
however, a problem with transmission was reported there and this bug is not
related to transmission but to receiving.

This is what I observed:

If very high load on the can bus coincides with very high load on the pc,
so that the 26 message fifo buffer configured in the can controller 
actually runs full, then receiving stops completely and the pc gets
very sluggish.

This is what I think is going on:

According to Sections 13.5.9 and 13.5.9.1 of the Intel PCH EG20T
Datasheet setting up a FIFO buffer on the pch can works like this:

"...The EOB bit of all message objects of a FIFO buffer except the last have
to be programmed to 0. The EOB bits of the last message object of a FIFO
buffer is set to 1, configuring it as the End of the Block...."
"When a message is stored into a message object [...] the NEWDAT bit of
that object is set. [...]the message object is locked for further write
accesses [...] until the CPU has written the NEWDAT bit back to 0."
"Messaged are stored into a FIFO buffer until the last message object [...]
is reached. If none of the preceding objects is released by writing NEWDAT
to 0, all further messages [...] are written into the last message object
[...] and therefore overwrite previous messages."

The pch_c_can defines a 26 messages deep FIFO buffer (from message object 1 
to message object 26) for receiving. 

However, In the pch_can_rx_normal() method of the pch_can.c driver, right at
the top of the main loop in which pending messages are read from the
controller, the loop is aborted if the EOB bit is send in the message object
currently considered:

		if (reg & PCH_IF_MCONT_EOB)
			break;

That means that the message(s) stored in this message object are never read
out, and the INTPND (interrupt pending, is set together with NEWDAT when a
message is stored into the object) bit in that message object's control
register is never cleared.
Thus a kind of "endless loop" happens where the same message object (26
= PCH_RX_OBJ_END) is considered again and again but never handled, until the
napi quota is consumed, and then immediately the device interrupt happens
again because the INTPND bit in the message object was never cleared.
The system is completely swamped.

Due to the way the FIFO buffer is handled by the driver (kind of like a 16
deep fifo with a 10 deep overflow, it doesn't matter, though), that
message object is only ever used if the FIFO actually runs completely
full. Thus the problem only manifests if very high loads on the canbus and
on the host happen at the same time. If that never happens the system will
work fine for a long time.

I'm still trying to fix this problem here, but this is the first time I
actually did anything using the napi and the whole driver looks slightly
confusing to me (half the time I don't understand why it does things the
way it does them). Just moving down the offending break towards the bottom
of the loop unfortunately doesn't work (The driver breaks completely). I
would appreciate it if somebody who knows more about this stuff could
try to fix this.

Just for reference, I am usually working with the latest 3.2.x kernel, but I
checked this today and it looks the same in the recent 3.7 kernel. 

Thanks a lot for your great work here,
Christian Bendele

