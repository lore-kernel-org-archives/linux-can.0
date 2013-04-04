From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BCM periodic send
Date: Thu, 04 Apr 2013 20:44:46 +0200
Message-ID: <515DCA1E.7070502@hartkopp.net>
References: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr> <5154B38F.5080404@hartkopp.net> <000501ce3050$1a5fb580$4f1f2080$@annecy-elec.fr> <000601ce312f$5d07f6b0$1717e410$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:35486 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761136Ab3DDSot (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Apr 2013 14:44:49 -0400
In-Reply-To: <000601ce312f$5d07f6b0$1717e410$@annecy-elec.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Boris Baskevitch <boris.baskevitch@annecy-elec.fr>
Cc: linux-can@vger.kernel.org

On 04.04.2013 14:24, Boris Baskevitch wrote:

> I finally found out in a German documentation the actual meaning of ival1,
> ival2 and data (mask) fields in RX_SETUP.
> I didn't see it in English, is there a reference documentation that I
> missed?


Hm - no.

Daniele Venzano suggested to add some documentation for the BCM:

http://www.brownhat.org/docs/socketcan.html

And i started the documentation split in the old BerliOS SVN:

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/Documentation/networking/can/

But unfortunately this didn't go further ... 

> I also have to note for other users the fact that when you get a RX_TIMEOUT
> you have to check msg_head.can_id to find out the offending message ID and
> not frame[0].can_id which is not updated.


The RX_TIMEOUT message has no struct can_frame.

It only consists of a struct bcm_msg_head!

That's why frame[0].can_id is not updated at all in RX_TIMEOUT messages :-)

> So now the timeout feature works in my application but I still have the
> issue with both RX_TIMEOUT and RX_CHANGED flags always set together.


Flags?

RX_TIMEOUT and RX_CHANGED are two different messages (with different sizes).

> This issue is masked when I use the following structure:
> if (msg.msg_head.opcode & RX_CHANGED) {
> // extract data from frame and send to process
> } else if (msg.msg_head.opcode & RX_TIMEOUT) {
> // tell process that the frame is absent
> }
> But if I replace the "else if" by a simple "if" I have wrong timeout
> signaling for each frame received.
> Is it a normal behavior?


Your if statement is wrong.

Use
 
	if (msg.msg_head.opcode == RX_CHANGED)

instead of

	if (msg.msg_head.opcode & RX_CHANGED)

The opcode is a enum value and not a bit field.

> 
> I'm still working on my timer inaccuracy issue. It's not linked to
> CLOCK_TICK_RATE which is OK. It's probably not directly linked to the BCM,
> but still if anybody has any hints, I'm taking.


No idea so far.

Regards,
Oliver

