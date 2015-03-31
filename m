From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Mon, 30 Mar 2015 17:26:24 -0700
Message-ID: <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
	<5519E5A9.7080104@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34608 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbbCaA0Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Mar 2015 20:26:25 -0400
Received: by obbgh1 with SMTP id gh1so2820959obb.1
        for <linux-can@vger.kernel.org>; Mon, 30 Mar 2015 17:26:24 -0700 (PDT)
In-Reply-To: <5519E5A9.7080104@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: linux-can@vger.kernel.org

Hi Tom,

Right, my understanding is that if there is only one client for the
SocketCAN interface, a simple wrapping of the SocketCAN tx_queue with
a qdisc might(?) work.  Need to understand the complexities of qdisc
first though.

If there are multiple clients, there is idneed the priority inversion
problem you mention.  Even if one has a single process designated to
read/write to the interface, managing priority is not fool proof.  A
low priority message could get submitted to the underlying SocketCAN
interface and be unable to go out onto the bus because of other
third-party nodes on the bus sending higher priority traffic at high
frequency.  This would block further messages from going out on the
SocketCAN interfaces, even though they have higher priority, no?

Paarvai


> The whitepaper is "promising". All you have to do is to implement it in your
> drivers to gain the functionality. I don't expect anyone else will any time
> soon.
>
> Otherwise, this looks "promising", but I can't get it to show anything other
> than zero:
>
>   # cat /sys/class/net/can0/queues/tx-0/byte_queue_limits/inflight
>   0
>
> Maybe I need to configure something else in the kernel or make some other
> configuration change to use it. I don't need this, but as you do I'd suggest
> you look at it.
>
> The code that allows access to "inflight" is in:
>
>     drivers/net/core/net-sysfs.c
>
> The definition of "inflight" in that file is:
>
> static ssize_t bql_show_inflight(struct netdev_queue *queue,
>                  struct netdev_queue_attribute *attr,
>                  char *buf)
> {
>     struct dql *dql = &queue->dql;
>
>     return sprintf(buf, "%u\n", dql->num_queued - dql->num_completed);
> }
>
> If you dig around enough through the linux source code you may be able to
> get the queueing to work and be able to use that sysfs variable. The code is
> in /lib/dynamic_queue_limits.c. It seems to be used by
> include/linux/netdevice.h.
>
> That still isn't going to solve your real problem, which (I'm assuming) is
> to try and get multiple senders through the CAN interface to "play nice"
> with each other in an attempt to establish normal ID-based transmission
> priority. That's what the whitepaper is all about.
>
> If you can read the queue depth I'm guessing all of your programs will have
> to queue internally and "promise" not to fill the queue if a higher priority
> ID message (from another thread/process) might need the slot. That's quite a
> change to the interface. If you're going to do that I'd suggest instead that
> you designate one process (or thread as appropriate) that is the only one
> allowed to open the CAN driver for transmission. It implements multiple
> internal priority queues. Have it provide a socket interface for the other
> programs that wish to send and have them all transmit via that process.
>
> Tom
>
