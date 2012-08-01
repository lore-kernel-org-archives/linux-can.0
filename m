From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v6] can: add tx/rx LED trigger support
Date: Wed, 1 Aug 2012 23:05:28 +0200 (CEST)
Message-ID: <1175619568.117607.1343855128267.JavaMail.open-xchange@webmail.strato.de>
References: <50191EA5.1040303@pengutronix.de> <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:21199 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab2HAVFc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 17:05:32 -0400
In-Reply-To: <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Fabio Baltieri <fabio.baltieri@gmail.com> hat am 1. August 2012 um 20:21
geschrieben:

> so, v6, change trigger names for fixed size allocation capped to (IFNAMSIZ +
> 4)
> and removed kasprintf as suggested by Oliver (thanks!).
>
> This also has the side effect of reducing the error path to just one check to
> devres_alloc return value... nice!
>
> I've put CAN_LED_NAME_SZ definition with the active function declaration,
> but used sizeof(priv->tx_led_trig_name) as snprintf length argument in the
> code, as it looks cleaner to me.

Yes. Nice improvement.

Thanks Fabio!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
