From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Mon, 30 Mar 2015 14:55:07 -0700
Message-ID: <CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34797 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbbC3VzH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Mar 2015 17:55:07 -0400
Received: by obbgh1 with SMTP id gh1so77828784obb.1
        for <linux-can@vger.kernel.org>; Mon, 30 Mar 2015 14:55:07 -0700 (PDT)
In-Reply-To: <55187FF1.7020701@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: linux-can@vger.kernel.org

Hi Tom,

Thanks for that pointer regarding ENOBUFS.  I will look into it for my
application.

Regarding, the qdisc reference, that does look like an interesting
whitepaper -- I had mentioned it in my original post in this thread as
well.

If anyone has pointers regarding querying the number of available
buffers on the TX side, that would be much appreciated.

Best regards,
Paarvai


On Sun, Mar 29, 2015 at 3:42 PM, Tom Evans <tom_usenet@optusnet.com.au> wrote:
> On 29/03/15 07:26, Paarvai Naai wrote:
>>
>> Hi,
>>
>> I have been looking into how to query the SocketCAN interface for its
>> current tx_queue usage.
>
>
> Just letting you know of a (what was for me) unexpected behaviour of the
> queue.
>
> Sockets can block or return ENOBUFS. Ethernet blocks before it returns
> ENOBUFS like you'd expect. With CAN it does the opposite "out of the box"
> and needs to be fixed.
>
> http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html
>
>     With Ethernet, the transmit queue length is 1000 (which would
>     return ENOBUF) but before that happens it hits SO_SNDBUF,
>     which may be 108544, which is the total Data plus SKB, and
>     with an SKB size of about 200 that means it blocks at about
>     500 before it ENOBUFs at 1000.
>
>     With CAN, it would block at 500, but it ENOBUFs at 10 first with
>     the default queue depth!
>
> I do the following to get a 256-deep queue that blocks before it overflows:
>
>     /bin/echo 256 > /sys/class/net/can0/tx_queue_len
>     /bin/echo 256 > /sys/class/net/can1/tx_queue_len
>
>     int sndbuf = (250 + 8) * 256;
>     socklen_t socklen = sizeof(sndbuf);
>     /* Minimum socket buffer to try and get it blocking */
>     rc = setsockopt(pSkt->skt, SOL_SOCKET, SO_SNDBUF,
>                     &sndbuf, sizeof(sndbuf));
>
> You might also like to read:
>
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>
>     SocketCAN and queueing disciplines:
>     Final Report
>     M. Sojka, R. Lisov y, P. P   sa
>     Czech Technical University in Prague
>     July 20, 2012
>     Version 1.2
>
> Tom
>
