From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 10:45:16 +0200
Message-ID: <20120424084516.GC420@vandijck-laurijssen.be>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:12076 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab2DXIpS (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 24 Apr 2012 04:45:18 -0400
Content-Disposition: inline
In-Reply-To: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> This patch implements the functions to add two LED triggers, named
> <ifname>-tx and <ifname>-rx, to a canbus device driver.
> 

> +void can_led_event(struct net_device *netdev, enum can_led_event event)

> +	case CAN_LED_EVENT_TX:
> +		if (led_delay && likely(tx_led) &&
> +		    !timer_pending(&tx_led->timer))
> +			mod_timer(&tx_led->timer,
I think that the latter 2 statements need threadsafe protection
_OR_ strict serialization from the caller (much more likely).
I don't think the code needs change, but it might be worth mentioning
this serialization requirement in the header.

Kind regards,
Kurt
