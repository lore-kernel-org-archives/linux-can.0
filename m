From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: PCI/PCIe cards and MSI support
Date: Mon, 23 Mar 2020 09:38:20 +0100
Message-ID: <375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <20200319140127.GD2538@x1.vandijck-laurijssen.be>
 <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWIi2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Mar 2020 04:38:28 -0400
In-Reply-To: <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 3/23/20 9:33 AM, Stéphane Grosjean wrote:
>> This seems a bad idea. Loading the module should not allocate resources.
>> A reasonable point IMHO is the probe of a device.
> 
> That's what I was thinking, sorry for the approximation and
> misunderstanding. So, you confirm that I can modify the driver to
> request_irq() when probing the CAN channels one after the other
> rather than when these are opened?

Why exactly do you need to do this?

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
