From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH 1/9] can: add tx/rx LED trigger support
Date: Mon, 17 Dec 2012 08:28:48 +0100
Message-ID: <50CEC9B0.3040503@universalnet.at>
References: <1355656113-9562-1-git-send-email-fabio.baltieri@gmail.com> <1355656113-9562-2-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:43176 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813Ab2LQH31 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 17 Dec 2012 02:29:27 -0500
In-Reply-To: <1355656113-9562-2-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Kurt Van Dijck <kurt.van.dijck@eia.be>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org

Hello Fabio!

Am 2012-12-16 12:08, schrieb Fabio Baltieri:
> This patch implements the functions to add two LED triggers, named
> <ifname>-tx and <ifname>-rx, to a canbus device driver.
>
> Triggers are called from specific handlers by each CAN device driver and
> can be disabled altogether with a Kconfig option.
>
> The implementation keeps the LED on when the interface is UP and blinks
> the LED on network activity at a configurable rate.
>
> This only supports can-dev based drivers, as it uses some support field
> in the can_priv structure.
>
> Supported drivers should call devm_can_led_init() and can_led_event() as
> needed.
>
> Cleanup is handled automatically by devres, so no *_exit function is
> needed.
>
> Supported events are:
> - CAN_LED_EVENT_OPEN: turn on tx/rx LEDs
> - CAN_LED_EVENT_STOP: turn off tx/rx LEDs
> - CAN_LED_EVENT_TX: trigger tx LED blink
> - CAN_LED_EVENT_RX: trigger tx LED blink

Why there is no patch for any usb can device?

Can this be done in a more general way, except patching every driver?


regards,
Bernd

