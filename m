From: Daniel Egnor <dan.egnor@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Wed, 1 Apr 2015 19:33:46 -0700
Message-ID: <CAECC7w=_zcYtt=k7wjb8Pz6ibamPYKERiKU-CkKzyExtpS2Ljg@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
	<5519E5A9.7080104@optusnet.com.au>
	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
	<551A0FF3.4070400@optusnet.com.au>
	<CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
	<loom.20150401T225437-75@post.gmane.org>
	<551CA77C.2080706@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35897 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbbDBCdr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2015 22:33:47 -0400
Received: by igbud6 with SMTP id ud6so65500214igb.1
        for <linux-can@vger.kernel.org>; Wed, 01 Apr 2015 19:33:46 -0700 (PDT)
In-Reply-To: <551CA77C.2080706@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: linux-can@vger.kernel.org

On Wed, Apr 1, 2015 at 7:20 PM, Tom Evans <tom_usenet@optusnet.com.au> wrote:
> If your system requires the priority system to work for some reason, ...

Yeah, when you get to 80% nominal utilization on some of your buses
with occasional low priority "background" transfers pushing it to
100%, you really start to care about prioritization :-/.

We are indeed fighting the battle on many fronts to make sure that all
the nodes either send at a single priority, or don't mind lots of
delay, or have good CAN transmit buffering. It's just something of a
setback to realize that the Linux nodes have to be put in one of the
first two buckets.

Or maybe QDISC will save us -- we are indeed looking into that.

-- egnor
