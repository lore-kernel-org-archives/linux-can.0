From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v5 1/2] can: add tx/rx LED trigger support
Date: Wed, 1 Aug 2012 14:06:13 +0200 (CEST)
Message-ID: <1920193464.85058.1343822773242.JavaMail.open-xchange@webmail.strato.de>
References: <5018F8B3.6080404@pengutronix.de> <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:17216 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab2HAMGR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 08:06:17 -0400
In-Reply-To: <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Sorry for this potentially mangled mail from my webmail access ...

Fabio Baltieri <fabio.baltieri@gmail.com> hat am 1. August 2012 um 13:49
geschrieben:

> +void devm_can_led_init(struct net_device *netdev)
> +{
> +  struct can_priv *priv = netdev_priv(netdev);
> +  void *res;
> +
> +  res = devres_alloc(can_led_release, 0, GFP_KERNEL);
> +  if (!res)
> +          goto err_out;
> +
> +  priv->tx_led_trig_name = kasprintf(GFP_KERNEL, "%s-tx", netdev->name);

IMO putting a string with 8 or 9 bytes into a separate kmalloc memory sniplet is
pretty oversized.
Ok - these functions provide to hide the complexitiy for allocating and storing
strings, which is
definitely fine for path names and these kind of strings that are not known in
length and probably
more than 100 bytes long.

But in this case i would suggest to allocate a fixed space in can_priv, as we
know the string length
very good (IFNAMSZ + strlen("-tx")) and there's no reason to get all the
overhead from three kmallocs
instead of one for that small memory allocations.

So i would suggest:

> @@ -52,6 +53,13 @@ struct can_priv {
> 
>    unsigned int echo_skb_max;
>    struct sk_buff **echo_skb;
> +
> +#ifdef CONFIG_CAN_LEDS
> +  struct led_trigger *tx_led_trig;
> +  char *tx_led_trig_name;

char tx_led_trig_name[IFNAMSZ+4];

> +  struct led_trigger *rx_led_trig;
> +  char *rx_led_trig_name;

char rx_led_trig_name[IFNAMSZ+4];

> +#endif
>  };
> 

Just my two cents as i was in CC here :-)

Thanks for the cool LED support & best regards
Oliver
