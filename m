From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ offloading
Date: Thu, 3 Sep 2015 09:58:58 +1000
Message-ID: <55E78D42.1060109@optusnet.com.au>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:35444 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897AbbIBX7D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Sep 2015 19:59:03 -0400
In-Reply-To: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl

On 01/09/15 20:31, Marc Kleine-Budde wrote:
> Hello,
>
> this series adds a software FIFO implementation and switches
 > the flecan and at91 driver to it. It's intended for CAN cores
 > with a higher number of mailboxes.

It is a bit difficult to understand the changed by looking at 20 patches, so 
I'm assuming this is the change where what the i.MX6 manuals calls the 
"Reception Queue" mode is enabled.

I see "[PATCH 1/8]" renaming "FLEXCAN_MCR_BCC" to "FLEXCAN_MCR_IRMQ" and 
"[PATCH 2/8]" adding it to the MCR setting.

Use of the "Reception Queue" is documented in the i.MX6DQ manual in section 
"26.6.5 Matching Process" as:

     By programming more than one MB with the same ID, received
     messages will be queued into the MBs. ARM can examine the
     Time Stamp field of the MBs to determine the order in which
     the messages arrived.

Is the new code sorting the messages by using the timestamp, or have you found 
another way to guarantee reception order?

Tom

