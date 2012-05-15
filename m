From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v4] CAN FD support
Date: Tue, 15 May 2012 15:54:29 +0200
Message-ID: <20120515135429.GB1414@vandijck-laurijssen.be>
References: <4FB25A39.7090608@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:63635 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab2EONyc (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 May 2012 09:54:32 -0400
Content-Disposition: inline
In-Reply-To: <4FB25A39.7090608@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Oliver,

A few nitpicks, and 1 change of behaviour, as announced in my last reply
on v3.

On Tue, May 15, 2012 at 03:29:29PM +0200, Oliver Hartkopp wrote:
> Hi all,
> 
> changes since v3:
> 
> https://gitorious.org/linux-can/hartkopps-linux-can-next/commit/9d51e1e6e40be9a36210a9ac7a9f8d6067ba94a5/diffs/b24b9fa7d9720224541e7b5742ac41f792896d74
> 
>     can: bump version date (simultaneous support)
> --> can_raw: allow simultaneous access of legacy apps and CANFD aware apps to CAN(FD) devices
>     af_can: remove pointless initializer in packet_type definition
>     can: add notifier handling when changing the CAN device MTU
> 
> I generated this diff by 'git diff fb7944b' on the repository
> 
> https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next
> 
> Regards,
> Oliver
> 
> 
>  drivers/net/can/dev.c    |   35 ++++++++++++++
>  drivers/net/can/vcan.c   |   30 +++++++++---
>  include/linux/can.h      |   51 ++++++++++++++++++++-
>  include/linux/can/core.h |    4 -
>  include/linux/can/dev.h  |   33 ++++++++++----
>  include/linux/can/raw.h  |    3 -
>  include/linux/if_ether.h |    3 -
>  net/can/af_can.c         |  110 +++++++++++++++++++++++++++++++++++------------
>  net/can/bcm.c            |    7 ++
>  net/can/gw.c             |    2 
>  net/can/raw.c            |   63 +++++++++++++++++++++++++-
>  11 files changed, 287 insertions(+), 54 deletions(-)
> 
> ---
> 
[...]
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 151b773..98b5604 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1357,6 +1357,13 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
>  
>  	switch (msg) {
>  
> +	case NETDEV_CHANGEMTU:
> +		/*
> +		 * Changing the MTU breaks the frame size that was formerly
> +		 * registered. The change can only be done when the interface
> +		 * ist down. Btw. make sure to get no trash from the device and
'ist' sound german.
You have this in several places :-)
> +		 * drop this device from the open sockets perspective.
> +		 */
>  	case NETDEV_UNREGISTER:
>  		lock_sock(sk);
>  
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cde1b4a..a20ee8e 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
[...]
> @@ -119,6 +120,14 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>  	if (!ro->recv_own_msgs && oskb->sk == sk)
>  		return;
>  
> +	/* do not pass frames with DLC > 8 to a legacy socket */
> +	if (!ro->fd_frames) {
> +		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
> +
> +		if (unlikely(cfd->len > CAN_MAX_DLEN))
idea:
			cfd->len = CAN_MAX_LEN;

but this modification must then be done _after_ the skb_clone below.
> +			/* return; */
> +	}
> +
>  	/* clone the given skb to be able to enqueue it into the rcv queue */
>  	skb = skb_clone(oskb, GFP_ATOMIC);
>  	if (!skb)
> @@ -246,6 +255,13 @@ static int raw_notifier(struct notifier_block *nb,
>  
>  	switch (msg) {
>  
> +	case NETDEV_CHANGEMTU:
> +		/*
> +		 * Changing the MTU breaks the frame size that was formerly
> +		 * registered. The change can only be done when the interface
> +		 * ist down. Btw. make sure to get no trash from the device and
> +		 * drop this device from the open sockets perspective.
> +		 */

why exactly?

>  	case NETDEV_UNREGISTER:
>  		lock_sock(sk);
>  		/* remove current filters & unregister */
