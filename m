From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ offloading
Date: Thu, 3 Sep 2015 18:17:53 +1000
Message-ID: <55E80231.30808@optusnet.com.au>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
 <55E78D42.1060109@optusnet.com.au> <20150903083208.29333e01@archvile>
 <55E7EF8D.306@pengutronix.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:50922 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751256AbbICIRz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 04:17:55 -0400
In-Reply-To: <55E7EF8D.306@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

On 03/09/15 16:58, Marc Kleine-Budde wrote:
> On 09/03/2015 08:32 AM, David Jander wrote:
>>>> this series adds a software FIFO implementation and switches

Thank you both for explaining that.

It seems fairly bulletproof as long as it doesn't overflow. There are 64 
buffers, so 32 in the first half, so that handles a 1.5ms interrupt latency.

A shame Freescale didn't think of that method instead of requiring the driver 
run quicksort somewhere.

 > In an atomic operation, the MB's that have been served are
 > now disabled.

That's the sort of tricky operation that exposes nasty silicon bugs. I'd 
suggest that this mode be made easy to turn off in case some chip variant has 
a problem like htis.

This feature looks to be enabled as a "QUIRK" of the CPU.

In an old generation kernel this might be optionally enabled in the .config 
file, as NAPI is in the 2.6.35 FEC drivers I'm stuck with using at the moment 
on the i.MX53. In the current kernel, could this mode of operation (and/or 
hardware FIFO using NAPI) be made configurable in the Device Tree instead?

Tom

