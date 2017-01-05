From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
Date: Thu, 5 Jan 2017 15:06:36 +0100
Message-ID: <ed0777b9-6abd-3015-fd96-3cf79ed7d8d8@hartkopp.net>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
 <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
 <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
 <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:36500 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969362AbdAEOGr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 09:06:47 -0500
In-Reply-To: <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hello Stephane,

On 01/05/2017 02:52 PM, Stephane Grosjean wrote:

>>> +
>>> +    /* put skb in rx queue as echo */
>>> +    netif_rx(skb);
>> Please wait until you get a tx-complete interrupt until you echo the skb.
> No "tx-complete" IRQ is provided by the hw but an "LNK record
> encountered by the reader" interrupt only: this LNK record is put at the
> end of a 2K DMA page by the writer, to link this page to the next one. I
> don't imagine saving the N * CAN msgs the page might contain, in some
> temporary memory until getting (sometimes in the future) this kind of
> IRQ, for, finally echoing all of these ones in a row, do you?
>

The IFF_ECHO functionality providing the correct timestamp when the CAN 
frame is seen on the bus is a vital functionality.

When you use some reading instance on your host system (e.g. candump) 
the CAN frames should be in order and with the correct timestamps to 
represent the correct content on the CAN bus. No matter whether you are 
only reading from the bus or sending with another application.

Would it make sense to reduce the number of CAN frames that are pushed 
into the CAN controller at a time?

Regards,
Oliver
