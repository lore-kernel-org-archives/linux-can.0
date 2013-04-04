From: "Boris Baskevitch" <boris.baskevitch@annecy-elec.fr>
Subject: RE: BCM periodic send
Date: Thu, 4 Apr 2013 14:24:33 +0200
Message-ID: <000601ce312f$5d07f6b0$1717e410$@annecy-elec.fr>
References: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr> <5154B38F.5080404@hartkopp.net> <000501ce3050$1a5fb580$4f1f2080$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from riga.magic.fr ([188.130.33.24]:51768 "HELO riga.magic.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759628Ab3DDMYj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 4 Apr 2013 08:24:39 -0400
In-Reply-To: <000501ce3050$1a5fb580$4f1f2080$@annecy-elec.fr>
Content-Language: fr
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Oliver Hartkopp' <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

> Now I have a new issue, the BCM report a RX_TIMEOUT for all periodic
> messages, even if the message is present on the bus with a shorter period
> than the one I configured in the BCM.
> The message is correctly received as I can get the RX_CHANGED message for
> the corresponding IDs.
> If I use RX_FILTER_ID option, I get a RX_CHANGED and RX_TIMEOUT for each
> message seen the bus (which is correct for RX_CHANGED, but not for
> RX_TIMEOUT).
> By the way, for a periodic RX message, which parameter is the period,
ival1 or
> ival2 ? (I had both set for the tests)

I finally found out in a German documentation the actual meaning of ival1,
ival2 and data (mask) fields in RX_SETUP.
I didn't see it in English, is there a reference documentation that I
missed?
I also have to note for other users the fact that when you get a RX_TIMEOUT
you have to check msg_head.can_id to find out the offending message ID and
not frame[0].can_id which is not updated.
So now the timeout feature works in my application but I still have the
issue with both RX_TIMEOUT and RX_CHANGED flags always set together.
This issue is masked when I use the following structure:
if (msg.msg_head.opcode & RX_CHANGED) {
// extract data from frame and send to process
} else if (msg.msg_head.opcode & RX_TIMEOUT) {
// tell process that the frame is absent
}
But if I replace the "else if" by a simple "if" I have wrong timeout
signaling for each frame received.
Is it a normal behavior?

I'm still working on my timer inaccuracy issue. It's not linked to
CLOCK_TICK_RATE which is OK. It's probably not directly linked to the BCM,
but still if anybody has any hints, I'm taking.
Boris.


