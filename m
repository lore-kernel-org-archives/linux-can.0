From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp25xxfd: add listen-only mode
Date: Mon, 22 Jun 2020 17:50:57 +0200
Message-ID: <7db88c3a-b126-99d3-a4fc-9fe0c19905d3@pengutronix.de>
References: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
 <24a81519-9628-6626-77e6-22dbd5253954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgFVPvD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 11:51:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F5C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 08:51:03 -0700 (PDT)
In-Reply-To: <24a81519-9628-6626-77e6-22dbd5253954@pengutronix.de>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org

On 6/22/20 3:38 PM, Marc Kleine-Budde wrote:
> On 6/22/20 2:20 PM, Kurt Van Dijck wrote:
>> This commit enables listen-only mode, which works internally like CANFD mode.
> 
> Does the controller distinguish between CAN-2.0 listen only and CAN-FD listen
> only mode?
> 
> If listen only means CAN-FD...should we add a check to open() if CAN_CTRLMODE_FD
> and CAN_CTRLMODE_LISTENONLY is both set (or unset).

Thinking a bit: Do we need this? As the device is passive it will not do
anything "bad" to the bus.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
