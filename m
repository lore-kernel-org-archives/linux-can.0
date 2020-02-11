From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mcp25xxfd: missing cerrif
Date: Tue, 11 Feb 2020 14:51:34 +0100
Message-ID: <532b4fed-a984-0875-d933-43c6a90fcc1a@pengutronix.de>
References: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
 <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41469 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgBKNvi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2020 08:51:38 -0500
In-Reply-To: <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas.Kopp@microchip.com, linux-can@vger.kernel.org

On 2/11/20 2:31 PM, Thomas.Kopp@microchip.com wrote:
>>> - The transmitter or receiver transitions from Error Passive to Error
>>>   Active state

>> I don't see this interrupt, neither on the mcp2517fd nor on the
>> mcp2518fd rev0.0.
> 
> What do you mean you don't see the interrupt?

If the chip transitions from Error Passive to Error Active state the
CERRIF is not set.

> I just did a quick test (non linux environment but with our test
> board and I do see CERRIF being set and it's possible to clear via
> SPI). What exactly are you checking?
Below code is from the driver and illustrates the problem:

> 		/* On the MCP2527FD and MCP2518FD, we don't get a
> 		 * CERRIF IRQ on the transition TX ERROR_WARNING -> TX
> 		 * ERROR_ACTIVE.
> 		 */
> 		if (intf_pending & MCP25XXFD_CAN_INT_CERRIF ||
> 		    priv->can.state > CAN_STATE_ERROR_ACTIVE) {
> 			err = mcp25xxfd_handle(priv, cerrif);
> 			if (err)
> 				goto out_fail;
> 		}

On the transition from "TX ERROR_WARNING -> TX ERROR_ACTIVE" the CERRIF
is not set.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
