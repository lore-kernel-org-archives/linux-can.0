From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 1/2] can: Decrease default size of CAN_RAW socket send
 queue
Date: Sat, 25 Jan 2014 17:31:53 +0100
Message-ID: <52E3E6F9.8030401@hartkopp.net>
References: <1390379257-9040-1-git-send-email-sojkam1@fel.cvut.cz> <20140123.124108.891860564230946746.davem@davemloft.net> <52E18331.6050607@pengutronix.de> <20140123.144243.998328685775607324.davem@davemloft.net> <87sisdbqky.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:8037 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbaAYQb5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 Jan 2014 11:31:57 -0500
In-Reply-To: <87sisdbqky.fsf@steelpick.2x.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org

(reduced the mail participants to CAN ML)

On 24.01.2014 11:51, Michal Sojka wrote:

> 
> What about the following?
> 
> ----8<--------8<-----
> Subject: [PATCH v3] can: Decrease default size of CAN_RAW socket send queue
> 

(..)

> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 1870c47..a0bce83 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -492,7 +492,7 @@ static void can_setup(struct net_device *dev)
>  	dev->mtu = CAN_MTU;
>  	dev->hard_header_len = 0;
>  	dev->addr_len = 0;
> -	dev->tx_queue_len = 10;
> +	dev->tx_queue_len = 100;
>  
>  	/* New-style flags. */
>  	dev->flags = IFF_NOARP;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index fdda5f6..4293197 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -291,6 +291,9 @@ static int raw_init(struct sock *sk)
>  {
>  	struct raw_sock *ro = raw_sk(sk);
>  
> +	/* This limits the number of queued CAN frames to approximately 11 */
> +	sk->sk_sndbuf = SOCK_MIN_SNDBUF;
> +
>  	ro->bound            = 0;
>  	ro->ifindex          = 0;
>  

Good thing: It works fine :-)

Having two interfaces with sja1000 in my Laptop I can run

	cangen -g 0 can0

without any -ENOBUFS issues.

The bad(?) thing:

	canbusload can0@500000 can1@500000

only leads to

 can0@500000  3166  343905 145968  68%
 can1@500000  3166  343905 145968  68%

When running

	cangen -g 0 can0
	cangen -g 0 can1

it shows up

 can0@500000  5111  553913 234584 110%
 can1@500000  5111  553913 234584 110%


With a mainline kernel I can get

 can0@500000  4109  445113 188416  89%
 can1@500000  4109  445113 188416  89%

with
	cangen -g 0 can0 -i
	                 ^^^

Of course this burns lots of CPU time and returns thousands of -ENOBUFS then.

Do you have an idea why we only get ~68% with the 'good' solution?
Could this be due to some scheduling behaviour?

Regards,
Oliver

