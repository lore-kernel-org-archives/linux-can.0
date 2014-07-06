From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: skbuff panic
Date: Sun, 06 Jul 2014 14:12:53 +0200
Message-ID: <53B93D45.5090505@hartkopp.net>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com> <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com> <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:30609 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaGFMM4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 6 Jul 2014 08:12:56 -0400
In-Reply-To: <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org

On 06.07.2014 07:07, Austin Schuh wrote:

> What makes you think that someone opened a PF_PACKET socket?  I'm
> curious, since that observation may help me produce a more reliable
> test case and debug it some more myself.

If you look in your call trace is says:

skb_push+0x38/0x39          (-->> which panics)
packet_rcv_spkt+0x98/0xdf
__netif_receive_skb_core+0x459/0x4dc
get_parent_ip+0xe/0x3e
__netif_receive_skb+0x53/0x65

As packet_rcv_spkt() is located in net/packet/af_packet.c there must be some
user at this early stage of system boot to make PF_PACKET process the CAN frame.

In https://gitorious.org/linux-can/can-tests there's a tst-packet.c program
which uses the PF_PACKET socket to send/receive CAN frames.

I was using tst-packet.c about four years ago for a test - without any
problems. But maybe something in the network layer changed, so that CAN frame
skbs need to be created with a different setup now.

I'll try ASAP if tst-packet.c still works as expected on my machine.

> 
> I'm going to work on reproducing the panic more reliable, and then
> I'll give your patch a whirl.  Currently, only PCs that are on the
> other end of cell modems out in the field seem to be triggering the
> panic.  I'm hesitant to do excessive experimentation on something that
> takes a plane trip to fix.  That just means that this will take longer
> to debug that I'd like...

Indeed this should not be the plan ...
Let's save the world by saving carbon dioxide ;-)

Best regards,
Oliver

