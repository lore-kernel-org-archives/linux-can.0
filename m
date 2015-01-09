From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 4/4] can: kvaser_usb: Add support for the Usbcan-II
 family
Date: Fri, 09 Jan 2015 17:23:19 +0100
Message-ID: <54B00077.8060704@hartkopp.net>
References: <20141223154654.GB6460@vivalin-002> <20150105174910.GA6304@linux> <20150105175206.GB6304@linux> <20150105175713.GC6304@linux> <20150105183131.GD6304@linux> <54AE6FC1.6050007@pengutronix.de> <20150109030657.GA1791@vivalin-002> <54AFE03D.5040509@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:27727 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417AbbAIQXb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Jan 2015 11:23:31 -0500
In-Reply-To: <54AFE03D.5040509@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Olivier Sobrie <olivier@sobrie.be>, Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

On 09.01.2015 15:05, Marc Kleine-Budde wrote:
> On 01/09/2015 04:06 AM, Ahmed S. Darwish wrote:

>>>> 		stats->rx_over_errors++;
>>>> 		stats->rx_errors++;
>>>>
>>>> 		netif_rx(skb);
>>>>
>>>> 		stats->rx_packets++;
>>>> 		stats->rx_bytes += cf->can_dlc;

> A quick look shows that almost no ethernet or wireless drivers take care
> about the return value. In case of a RX_DROPPED some increase a drop
> counter, though.

As there IS a return value it makes sense to check it and to increase either 
the packet OR the drop counter accordingly.

This is definitely better than increasing just the packet counter in every 
case. Maybe something for the 3.21 merge window ...

Regards,
Oliver

ps. removed the heavy cross-posting on LKML and netdev and others. Posting on 
linux-can is the right place for this kind of CAN driver discussions.



