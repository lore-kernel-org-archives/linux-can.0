From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CAN messages being lost on i.MX25 with flexcan
Date: Thu, 19 Apr 2012 22:17:54 +0200
Message-ID: <4F9072F2.7040101@grandegger.com>
References: <jmonvu$nu8$1@dough.gmane.org> <4F8FEF02.7040503@grandegger.com> <jmoses$rmu$1@dough.gmane.org> <4F8FFAB3.1040906@grandegger.com> <jmouls$dcl$1@dough.gmane.org> <66F75347783FFB4C9FE794C540A5BFE85D28F4FB7F@I-SERVER02.inntrasys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48026 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360Ab2DSUR6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 16:17:58 -0400
In-Reply-To: <66F75347783FFB4C9FE794C540A5BFE85D28F4FB7F@I-SERVER02.inntrasys.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jesper Pedersen <jp@inntrasys.com>
Cc: Martin Kozusky <mkozusky@kkmicro.cz>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 04/19/2012 10:00 PM, Jesper Pedersen wrote:
>>> What kernel version do you use? Do you use the flexcan driver from 
>>> that kernel? The problem is bus errors coming at high rate.
>>
>> I'm using 2.6.35.9 Preempt, the flexcan.c driver is original.
> 
> We use flexcan on an iMX25 device. The vanilla flexcan driver (we use kernel 3.0, but same issue also seen on 2.6.37) has some serious bugs that occasionally caused high CPU utilization or even total crashes on our platform.
> If I remember correctly, I found some IRQs which were not serviced correctly, causing the ISR to be triggered continuously.
> 
> We fixed it by pulling the flexcan.c driver from Wolfgangs linux-can-next tree. I don't recall, if you could just replace the original flexcan.c directly, or if some integration were required.

This confirms that the patch http://patchwork.ozlabs.org/patch/130761/
is need for the i.MX25 as well. I already told Martin to give it a try.

Wolfgang.
