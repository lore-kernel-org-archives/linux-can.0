From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: mcp25xxfd: missing cerrif
Date: Tue, 11 Feb 2020 13:53:56 +0100
Message-ID: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBKMx7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2020 07:53:59 -0500
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Kopp <thomas.kopp@microchip.com>, linux-can <linux-can@vger.kernel.org>

Hello Thomas,

according to the mcp2518fd datasheet:

> 10.5.3 CAN BUS ERROR INTERRUPT - CERRIF
>
> The CiTREC register will count the errors during transmit and receive
> according to the ISO 11898-1:2015. The CERRIF flag will be set based
> on the error counter values. The flag must be cleared by the
> application.
> 
> CERRIF will be set each time a threshold in the TEC/REC counter is
> crossed by the following conditions:
>
> - TEC or REC exceeds the Error Warning state threshold
> - The transmitter or receiver transitions to Error Passive state
> - The transmitter transitions to Bus Off state
> - The transmitter or receiver transitions from Error Passive to Error
>   Active state

I don't see this interrupt, neither on the mcp2517fd nor on the
mcp2518fd rev0.0.

> - The module transitions from Bus Off to Error Active state, after
>   the bus off recovery sequence
>
> When the user clears CERRIF, it will remain clear until a new counter
> crossing occurs.

The workaround in the driver is next to trivial and doesn't cause much
overhead, but can you try to confirm the error and try to get it fixed
in the next chip revision?

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
