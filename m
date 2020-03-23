From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: PCI/PCIe cards and MSI support
Date: Mon, 23 Mar 2020 10:35:59 +0100
Message-ID: <45fe5f0a-9b74-a673-40e9-c3e361c625d5@pengutronix.de>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <20200319140127.GD2538@x1.vandijck-laurijssen.be>
 <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
 <DB6PR03MB3093D18BB366D78BA9D384D1D6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53947 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgCWJgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Mar 2020 05:36:05 -0400
In-Reply-To: <DB6PR03MB3093D18BB366D78BA9D384D1D6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 3/23/20 10:25 AM, Stéphane Grosjean wrote:
> When switching in MSI mode, we've noticed that once CAN0 is closed
> (i.e., once its own interrupt is freed), all other CANs on the same card no longer receive interrupts (i.e., the handler is never called again).

Is it the free_irq() or the other code called on ifdown? Comment out the
free_irq() and check what happens.

> This issue doesn't exist when any other CANx then CAN0 is closed.
> 
> The reason of this is not clear. What we know is that this issue doesn't
>  exist under Windows for any of our (CAN 2.0 as well as CAN FD) cards. On the contrary, the issue is the same for all of our CAN 2.0 / CAN FD cards under Linux.
> 
> Up to now, the only workaround we have to run in MSI mode is to
> request_irq() when probing the devices (starting from CAN0) *AND*
> free_irq() in the opposite order (ending with CAN0)  when removing the module.
> 
> Obvioulsy, enabling/disabling hw interrupts is always done when the can interface is put to up/down.
> 
> The "only" side effect is that all MSI interupt levels allocated by the
> driver are requested, even if their corresponding interfaces are not UP.

Which drivers have this problem?

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
