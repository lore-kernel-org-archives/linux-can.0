From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ISOTP-implementation
Date: Thu, 04 Oct 2012 20:33:58 +0200
Message-ID: <506DD696.5090906@hartkopp.net>
References: <trinity-e227a661-0fd3-43e4-80ac-b4854f33afba-1349166829591@3capp-webde-bs17>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:40978 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2JDSd4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 14:33:56 -0400
In-Reply-To: <trinity-e227a661-0fd3-43e4-80ac-b4854f33afba-1349166829591@3capp-webde-bs17>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mahesh Maharjan <mahesh.maharjan@web.de>
Cc: linux-can@vger.kernel.org

On 02.10.2012 10:33, Mahesh Maharjan wrote:

> 
> Thank you Oliver providing me some guideline to use  ISO-TP socketCan for multiple socket. 
> In my previous queries- I think, I could not able to describe my problem properly.
> While working with RAW socket in Imx6, I was having problem with frame lost during the Tx. So, I was thinking to use multiple socket to minimise the lost of can frame in ISOTP also. 


Can you be a bit more detailed please?

Frames usually do not get lost - unless the driver is faulty OR you did not
check the return values for the raw socket you've been using ??

> 
> Another important things about Point to Point(ISOTP), as you wrote me;
> One write() syscall -> one ISO-TP PDU is sent
> 
> One ISO-TP PDU is received -> one read() syscall get's the PDU
> 
> Would you please provide some further guide line on it, whether I can use some acknowledge between read Or writing frames. So I would prefer to know get inform with complete  tranmsmission Complete or  Received Complete...


ISO-TP is an unreliable datagramm protocol, like UDP/IP.

The PDU loss has therefore to be detected by a higher layer. E.g. the UDS
diagnosis service has it's own timeout for application message timeouts.

So send a ISO-TP PDU, assume it gone ok and wait for an application layer
answer (with timeout).

Did you follow this hint?
https://gitorious.org/linux-can/can-modules/blobs/master/README.isotp#line212

Regards,
Oliver
