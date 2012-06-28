From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC PATCH] can: dev: update rx state in the can_get_echo_skb()
Date: Thu, 28 Jun 2012 12:59:48 +0200
Message-ID: <20120628105948.GC418@vandijck-laurijssen.be>
References: <1340876540-27840-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:43833 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754346Ab2F1K7w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 06:59:52 -0400
Content-Disposition: inline
In-Reply-To: <1340876540-27840-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: mkl@pengutronix.de, shawn.guo@linaro.org, wg@grandegger.com, linux-can@vger.kernel.org

Hi,

A loopback packet enters the rx interface of the CAN subsystem,
but it had never entered the chip's receive path.
IMHO it's bad to alter the chip's statistics the way you propose.

Are you interested in the number of packets/bytes
that you were able to receive on your socket?
How about adding echo statistics in the CAN device stats,
as shown in
$ ip -d -s link show can0

Kind regards,
Kurt

On Thu, Jun 28, 2012 at 05:42:20PM +0800, Hui Wang wrote:
> After a loopback packet is routed to rx interface, we forget to update
> rx state both in the can_get_echo_skb() and in the controller specific
> drivers, as a result, after we sent a loopback packet and executed
> ifconfig, following state is outputed:
> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:0 (0.0 B)  TX bytes:4 (4.0 B)
> 
> We add rx state update in the can_get_echo_skb() to solve this
> problem.
> 
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
> I don't know if it is designed like that on purpose, please instruct
> me if i am wrong.
> 
> I use following commands to let flexcan to work in the loopback mode:
> %>ip link set can0 type can bitrate 125000
> %>ip link set can0 type can loopback on
> %>ip link set can0 up
> And send a packet:
> %>cantest can0 123#AABBCCDD
> When i check net device state, i found tx doesn't equal rx:
> %>ifconfig
> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:0 (0.0 B)  TX bytes:4 (4.0 B)
> 
> From my understanding, i suppose it should be:
> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:1 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10 
>           RX bytes:4 (4.0 B)  TX bytes:4 (4.0 B)
> 
>  drivers/net/can/dev.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index f03d7a4..6b62f6a 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -340,6 +340,9 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
>  		netif_rx(priv->echo_skb[idx]);
>  		priv->echo_skb[idx] = NULL;
>  
> +		dev->stats.rx_bytes += dlc;
> +		dev->stats.rx_packets++;
> +
>  		return dlc;
>  	}
>  
> -- 
> 1.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
