From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] can: only rename enabled led triggers when changing
 the netdev name
Date: Tue, 27 May 2014 15:00:18 +0200
Message-ID: <20140527130018.GD437@vandijck-laurijssen.be>
References: <1401190256-2963-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:4103 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529AbaE0NAX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 May 2014 09:00:23 -0400
Content-Disposition: inline
In-Reply-To: <1401190256-2963-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, fabio.baltieri@gmail.com

Hey Oliver,

nice clean patch.

Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On Tue, May 27, 2014 at 01:30:56PM +0200, Oliver Hartkopp wrote:
> Commit a1ef7bd9fce8 ("can: rename LED trigger name on netdev renames") renames
> the led trigger names according to the changed netdevice name.
> 
> As not every CAN driver supports and initializes the led triggers, checking for
> the CAN private datastructure with safe_candev_priv() in the notifier chain is
> not enough.
> 
> This patch adds a check when CONFIG_CAN_LEDS is enabled and the driver does not
> support led triggers.
> 
> For stable 3.9+
> 
> CC: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> CC: Fabio Baltieri <fabio.baltieri@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/led.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
> index a3d99a8..ab7f1b0 100644
> --- a/drivers/net/can/led.c
> +++ b/drivers/net/can/led.c
> @@ -97,6 +97,9 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
>  	if (!priv)
>  		return NOTIFY_DONE;
>  
> +	if (!priv->tx_led_trig || !priv->rx_led_trig)
> +		return NOTIFY_DONE;
> +
>  	if (msg == NETDEV_CHANGENAME) {
>  		snprintf(name, sizeof(name), "%s-tx", netdev->name);
>  		led_trigger_rename_static(name, priv->tx_led_trig);
> -- 
> 2.0.0.rc4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
