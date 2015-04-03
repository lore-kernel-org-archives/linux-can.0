From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 2 Apr 2015 23:45:46 -0700
Message-ID: <CAE+ymrv6PeLU9EbJcC8mfwQSXQyGjMVG6fSkY-NZAUmCW+U2tw@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
	<5519E5A9.7080104@optusnet.com.au>
	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
	<551A0FF3.4070400@optusnet.com.au>
	<CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
	<551C7D79.50906@optusnet.com.au>
	<loom.20150402T022922-646@post.gmane.org>
	<551CE5C9.6020600@pengutronix.de>
	<CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com>
	<551DEE7C.6040202@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33382 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbDCGpq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2015 02:45:46 -0400
Received: by obvd1 with SMTP id d1so161453409obv.0
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2015 23:45:46 -0700 (PDT)
In-Reply-To: <551DEE7C.6040202@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

Hi Tom,

> Didn't I already answer that question a few days ago?

Yes, somewhat, but I was hoping for something more concrete from Marc
(or someone else), which is why I posed the question again.  (Also,
I'm not a huge fan of programmatically interfacing with the
system-level control/status via the /sys filesystem....)

> I found something in /proc or /sys (details in my mailbox at work) That
> looked like the interface to qdisc to allow inspection of the queue depths.
>
> Thanks to google that's:
>
>   cat /sys/class/net/can0/queues/tx-0/byte_queue_limits/inflight
>   drivers/net/core/net-sysfs.c
>   /lib/dynamic_queue_limits.c
>
> Did you investigate that at all, or are you waiting for someone else to do
> this for you?

While I am reasonably capable of spelunking through Linux source code,
and have done so successfully in the past, I have not gotten to that
yet (been unfortunately busy with my other tasks at work!).  I was
hoping that someone who is far more familiar with this infrastructure
to speak to the support for this feature.  Apologies if I'm being too
presumptuous.

> Can anyone else comment on that apparent interface? Is "dql" part of "qdisc"
> or something else? How is it enabled?

Yes please!  Would be much appreciated!

>     http://dir.gmane.org/gmane.linux.can
>
> It is now spitting "fopen()", "feof()" and "fgets()" PHP errors at me, so it
> looks like gmane is broken for Easter.

Oh, I've had this problem for the last several days since I got active
on the linux-can mailing list.  But you are able to find individual
messages via Google search.  For example, try searching for
    linux-can "Querying current tx_queue usage of a SocketCAN interface"
and you will find our thread.  The particular message you had in mind
will not be there directly because I believe you accidentally only
replied to me rather than to the mailing list as well.  However, my
response to that email includes your original message quoted below.
See:
http://permalink.gmane.org/gmane.linux.can/7918

Thanks for your continued interest in this thread, and Happy Easter,
Paarvai
