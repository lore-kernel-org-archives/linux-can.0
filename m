From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: skbuff panic
Date: Sat, 05 Jul 2014 12:40:59 +0200
Message-ID: <53B7D63B.2060108@hartkopp.net>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:34889 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbaGEKlE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Jul 2014 06:41:04 -0400
In-Reply-To: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org

On 04.07.2014 01:03, Austin Schuh wrote:
> I'm seeing the following panic.  I've seen it on multiple kernel
> versions (3.10.24 patched, and 3.14.3).
> 
> uname -a
> Linux vpc5 3.14.3-rt4abs+ #16 SMP PREEMPT RT Tue Jul 1 16:28:26 PDT
> 2014 x86_64 GNU/Linux
> 
> Jul  3 12:18:28 vpc7 kernel: [   16.691928] skbuff: skb_under_panic:
> text:ffffffff814fb64d len:-65447 put:-65463 head:ffff880407415080
> data:ffff88030742507f tail:0x58 end:0x80 dev:can0
> Jul  3 12:18:28 vpc7 kernel: [   16.692207] ------------[ cut here ]------------
> Jul  3 12:18:28 vpc7 kernel: [   16.692209] kernel BUG at net/core/skbuff.c:100!
(..)
> Jul  3 12:18:28 vpc7 kernel: [   16.692330] Call Trace:
> Jul  3 12:18:28 vpc7 kernel: [   16.692340]  [<ffffffff8143e142>]
> skb_push+0x38/0x39
> Jul  3 12:18:28 vpc7 kernel: [   16.692348]  [<ffffffff814fb64d>]
> packet_rcv_spkt+0x98/0xdf
> Jul  3 12:18:28 vpc7 kernel: [   16.692357]  [<ffffffff8144b8f8>]
> __netif_receive_skb_core+0x459/0x4dc

> 
> Any ideas what is causing it?  The issue seems to be that the data
> pointer is less than the head pointer, from reading the code.  It only
> happens right at startup.

Hi Austin,

as you are using the PF_PACKET socket here - where packet_rcv_spkt() is using
skb_push() - the things are slightly different to the PF_CAN handling.

Are these kernel panics related to the reception of CAN frames - or do they
only show up when you send CAN frames (via PF_PACKET socket)??

Can you tell something more about how you send and receive CAN frames in your
setup?

Best regards,
Oliver

