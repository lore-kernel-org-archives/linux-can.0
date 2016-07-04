From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based irq
 offloading
Date: Mon, 4 Jul 2016 18:49:42 +0000
Message-ID: <146765818281.26740.6668128129784946822@maxwell>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:41536
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933149AbcGEQZS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 12:25:18 -0400
In-Reply-To: <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

Quoting Marc Kleine-Budde (2016-07-04 18:32:07)
> +static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
> +{
> +       const struct can_rx_offload_cb *cb_a, *cb_b;
> +
> +       cb_a = can_rx_offload_get_cb(a);
> +       cb_b = can_rx_offload_get_cb(b);
> +
> +       return cb_b->timestamp - cb_a->timestamp;
> +}

Hi Marc,

An int is not large enough to store the difference between two u32.

E.g. INT_MAX - (-1) = INT_MIN

They're unlikely to be very far apart, but you can never be too cautious. ;)

See
http://stackoverflow.com/questions/10996418/efficient-integer-compare-function

Best regards,
Andri
