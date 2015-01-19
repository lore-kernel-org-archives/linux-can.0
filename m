From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH 3.19-rc3] c_can: SIE disabled when berr-reporting is off
 to reduce irq flood
Date: Tue, 20 Jan 2015 09:35:56 +1100
Message-ID: <54BD86CC.70302@optusnet.com.au>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login> <54BBFCAF.2090603@pengutronix.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60058 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596AbbASWgC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Jan 2015 17:36:02 -0500
In-Reply-To: <54BBFCAF.2090603@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Viktor Babrian <babrian.viktor@renyi.mta.hu>, Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org

On 19/01/15 05:34, Marc Kleine-Budde wrote:
> On 01/18/2015 07:30 PM, Viktor Babrian wrote:
>>
>> Status interrupt is to be disabled if bus error reporting is off in order
>> to reduce interrupt flood when e.g. a frame is not acked. Side effect is
>> that when berr-reporting off, warn->pass and pass-warn state transitions
>> may be reported later (upon a successful rx/tx event) or even go
>> undetected. With proper implementation, these transitions could always be
>> detected (but still later). It is considered better to have a non-accurate
>> report of these transitions than having a non-responding system in
>> possible scenarios.
>>
>> Signed-off-by: Viktor Babrian <babrian.viktor@renyi.mta.hu>
>
> NACK. The transitions are important for some applications. I've an not
> yet mainlined series that limits the bus errors. I'm going to port them
> to the current kernel tomorrow. Can you test it?

Those "some applications" can enable "CAN_CTRLMODE_BERR_REPORTING" and get 
error reporting and prompt (and complete) state reporting.

Doesn't that answer your concern?

That approach was implemented in flexcan.c as per this patch:

 > Author: Wolfgang Grandegger <wg@grandegger.com>  2012-10-11 06:10:42
 > Committer: Marc Kleine-Budde <mkl@pengutronix.de>  2012-10-24 03:43:17

     can: flexcan: disable bus error interrupts for the i.MX6q

     This patch adds some Flexcan version info and removes the feature flag
     FLEXCAN_HAS_BROKEN_ERR_STATE for the i.MX6Q. It also has the line
     [TR]WRN_INT properly connected.

You approved this approach then (although possibly not knowing that that was 
what the patch was doing then).

Tom Evans


