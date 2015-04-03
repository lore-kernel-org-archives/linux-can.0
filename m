From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Fri, 03 Apr 2015 12:35:56 +1100
Message-ID: <551DEE7C.6040202@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au>	<CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>	<551C7D79.50906@optusnet.com.au>	<loom.20150402T022922-646@post.gmane.org>	<551CE5C9.6020600@pengutronix.de> <CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:57694 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007AbbDCBgE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 21:36:04 -0400
In-Reply-To: <CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

On 3/04/2015 5:28 AM, Paarvai Naai wrote:
> Ironically, that brings us full-circle back to my original reason for
> this thread, but we went off on a tangent in the meantime (partly my
> fault!).  Querying the tx_queue usage has multiple benefits.  Is there
> some way we can address that easier issue first?

Didn't I already answer that question a few days ago?

I found something in /proc or /sys (details in my mailbox at work) That 
looked like the interface to qdisc to allow inspection of the queue depths.

Thanks to google that's:

   cat /sys/class/net/can0/queues/tx-0/byte_queue_limits/inflight
   drivers/net/core/net-sysfs.c
   /lib/dynamic_queue_limits.c

Did you investigate that at all, or are you waiting for someone else to 
do this for you?

Can anyone else comment on that apparent interface? Is "dql" part of 
"qdisc" or something else? How is it enabled?

---

Before using google I just spent 30 minutes trying to quote my previous 
reply from:

     http://dir.gmane.org/gmane.linux.can

Can anyone else get to the above URL today? It crashes Firefox every 
time I go there, locks up IE solidly, and I gave up on lynx after it 
started running GZIP and pulling down about 10 MEGS of data without 
displaying anything.

It is now spitting "fopen()", "feof()" and "fgets()" PHP errors at me, 
so it looks like gmane is broken for Easter.

Tom

