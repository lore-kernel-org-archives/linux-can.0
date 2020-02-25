From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: af_can: can_rcv() canfd_rcv(): Fix access of
 uninitialized memory or out of bounds
Date: Tue, 25 Feb 2020 21:34:37 +0100
Message-ID: <c280d2e0-30a2-eb67-90ee-4b7cef7c746b@pengutronix.de>
References: <20200224094100.2431262-1-mkl@pengutronix.de>
 <b3ef9c62-2436-749a-4cf2-1faf55d8b542@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42287 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbgBYUem (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 15:34:42 -0500
In-Reply-To: <b3ef9c62-2436-749a-4cf2-1faf55d8b542@hartkopp.net>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc: kuba@kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org

On 2/24/20 8:52 PM, Oliver Hartkopp wrote:
> Btw. do you take this patch via your tree too?
> https://marc.info/?l=linux-can&m=158039108004683

I've just given my Acked-by and ask for the preferred way of upstreaming.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
