From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/2] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Sun, 08 Jul 2012 20:59:45 +0200
Message-ID: <4FF9D8A1.7070904@hartkopp.net>
References: <1341521908-11454-1-git-send-email-iws@ovro.caltech.edu> <1341521908-11454-3-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:13900 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab2GHS7k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Jul 2012 14:59:40 -0400
In-Reply-To: <1341521908-11454-3-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

On 05.07.2012 22:58, Ira W. Snyder wrote:

> The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
> notification or interrupt. The driver previously used the hardware
> loopback to attempt to work around this deficiency, but this caused all
> sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.
> 
> Using the new function can_cmp_echo_skb(), we can drop the loopback
> messages and return the original skbs. This fixes the issues with
> CAN_RAW_RECV_OWN_MSGS, but leaves the driver vulnerable to a condition
> where it will overwrite the echo skb stack.
> 
> NOT EVEN CLOSE TO Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> WARNING: BROKEN CODE!
> 
> If a user uses non-loopback mode and sends packets very quickly, the driver
> will stop accepting packets until the bus is re-started.
> 
> I've managed to trigger the BUG printk() in can_put_echo_skb(), since the
> receive queue can fall behind the transmit queue, and I don't know how to
> detect that situation.
> 
> In short, the patch "works", but I'm not happy with it. See my next posting
> for a working patch that takes a different approach.
> 


Hello Ira,

i tried to get behind your driver this weekend.

The first thing:

ICAN3_TX_BUFFERS is 512 !! (whow)

Usually we use the netdev tx queue to pick one or two CAN frames (when there's
a shadow tx register available) but not 512 ...

Please try one or two tx buffers to take advantage of Linux CAN frame
handling. This should also make the things easier in your napi function that
handles the interrupts and incoming DPM messages.

If you only need to check the received CAN frames against 1-2 echo_skbs this
should be easy and fast to do in the napi function.

ndev = alloc_candev(sizeof(*mod), ICAN3_TX_BUFFERS);

is nice with ICAN3_TX_BUFFERS = 1 or 2 ... (preferably 1 for the moment)

E.g. when you detect a CAN frame in the napi function, that is in the
echo_skbs and you consume/"get" these echo_skbs, you may restart the queue
with netif_start_queue(dev) at that point.

Of course this means that there must not be any implementation problem with
the echo mode in the Janz card: If you don't get the frames back the echo_skbs
are not cleared and the tx-queue is not re-started again.

If you get any problems with the Janz card according this topic we might fix
that by adding a timestamp to the echo_skbs to detect timeouts (e.g. to
automatically clear echo_skbs after 200ms/500ms).

Btw. you have an interesting problem to solve :-)

Best regards,
Oliver

