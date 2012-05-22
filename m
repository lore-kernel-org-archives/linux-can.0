From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Tue, 22 May 2012 21:01:06 +0200
Message-ID: <4FBBE272.5020807@grandegger.com>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39635 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab2EVTBJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 May 2012 15:01:09 -0400
In-Reply-To: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: bruce bushby <bruce.bushby@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Hello,

I switched the discussion to the new Linux-CAN mailing list.

On 05/22/2012 05:50 PM, bruce bushby wrote:
> Greetings
> 
> I'm hoping a list member would be so kind as to offer some basic
> explanations of how one would use the CAN bus provided by AM335x. I
> understand Linux, but struggle with electronics.
> 
> I have read this discussion: http://comments.gmane.org/gmane.linux.can/1142
> What is the difference between C_CAN and D_CAN?

As I see it, the D_CAN is a more advanced variant of the C_CAN
controller. See also:

http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/c_can/c_can.asp
http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/d_can/d_can.asp

Patches to add D_CAN support to the Linux-CAN C_CAN driver have been
posted recently for mainline inclusion and are currently reviewed.

> http://www.spinics.net/lists/linux-omap/msg67538.html
> Does D_CAN have anything to do with mcp2515?

No, nothing apart from the fact that both are CAN controllers. The
mcp2515 is connected via SPI bus and from another company.

> In order to connect the am335x CAN line to a CAN bus, would I need to
> add a CAN transceiver?

Hardware-wise, yes.

> Is the am335x an "in memory CAN" ... ie I wouldn't need to worry about
> SPI bus performance?

Right. On the AM335x, the D_CAN controller is integrated into the SOC.
There is no SPI involved.

> Any explanations and help much appreciated!

Hope it's useful.

Wolfgang.
