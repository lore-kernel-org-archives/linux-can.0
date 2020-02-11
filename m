From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp25xxfd: minor register definition fixes
Date: Tue, 11 Feb 2020 13:46:33 +0100
Message-ID: <a931e996-cb91-7672-5add-2b705b2d79c2@pengutronix.de>
References: <20200211120446.1390-1-thomas.kopp@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43761 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgBKMqg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2020 07:46:36 -0500
In-Reply-To: <20200211120446.1390-1-thomas.kopp@microchip.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Kopp <thomas.kopp@microchip.com>, linux-can@vger.kernel.org

On 2/11/20 1:04 PM, Thomas Kopp wrote:
> I started testing your driver

yeay!

> at 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/drivers/net/can/spi/mcp25xxfd?h=v5.4/mcp25xxfd

For testing use the lastest 5.4/mcp25xxfd-YYYYMMDD-X, they will not be
rebased.

> and noticed two small things in the register definitions.

tnx, applied

> Overall TX seems to be working fine - one thing I noticed when
> testing with cangen can0 -b -g 0 and another external node
                           ^^

I've not tested CAN-FD, yet.

> periodically sending frames on the bus (with 2ms gaps) I'm eventually
> getting stuffing errors from which the driver never really recovers.

Con you describe the complete setup?
- which mcp25xxfd?
- exact "ip" command line to configure the mcp
- exact command line on the mcp
- which controller on the other side
- command line on the other side to generate frames

> As soon as the external node then stops sending messages, the
> MCP2518FD node stops sending as well and gets unresponsive (ssh isn't
> possible anymore etc.).

Do you see anything in the kernel logs?

> When resuming the external CAN traffic the node becomes responsive
> again. The driver was compiled with Additional Debugging output and
> Logging enabled. Ifconfig doesn't show any RX/TX errors and shows
> plausible numbers for packets transmitted/received. Am I chasing
> ghosts here or have you encountered similar behaviour?

With two mcp2518fd on the same machine connected to each other, CAN-2.0
mode, but no third station and a specific test I see errors as well. The
controller finally not sending anymore, however the system keeps
responsive. I've to debug this further.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
