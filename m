From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Receiving messages issue
Date: Tue, 25 Jun 2013 09:43:19 +0200
Message-ID: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:47995 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab3FYHnW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2013 03:43:22 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Luka_Rahne?= <luka.rahne@gmail.com>, =?utf-8?Q?Marc_Kleine-Budde?= <mkl@pengutronix.de>
Cc: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>

Hello Marc, hello Luca,=20

what I can confirm is that I've seen the message lost issue some weeks =
ago on a Raspberry Pi with MCP2515.

The solution for me was to use the async MCP2515 driver from Andre B. O=
liveira mentoned by Marc below and furthermore to optimize the SPI inte=
rface to get less latency here.
This modifications for the Raspberry Pi are documented here:
http://www.elinux.org/RPi_CANBus

Whith these modifications I didn't see any message lost at busload abov=
e 50%@500kbit/s!

Currently I'm fighting with the same MCP251x driver on my BeagleBone Bl=
ack where I've seen the same message lost problem yesterday. Now, I'm c=
ompiling a new kernel with the async MCP2515 driver and hopefully I can=
 get the same good results to get my 3rd/4th CAN-Interface working on t=
he BeagleBone Black.

Regards
Mike

-----Urspr=C3=BCngliche Nachricht-----
Von:	Marc Kleine-Budde <mkl@pengutronix.de>
Gesendet:	Mo 24.06.2013 15:42
Betreff:	Re: Receiving messages issue
Anlage:	signature.asc
An:	Luka Rahne <luka.rahne@gmail.com>;=20
CC:	linux-can@vger.kernel.org;=20
> On 06/24/2013 02:26 PM, Luka Rahne wrote:
> > I am using MCP2515 with  i.MX27
>=20
> MCP2515 is the second worst CAN hardware I know. Only MCP2510 is wors=
e.
>=20
> You can try Andre B. Oliveira's async mcp2515 driver. It's here:
>=20
> http://git.pengutronix.de/?p=3Dmkl/linux.git;a=3Dshortlog;h=3Drefs/he=
ads/can/mcp2515-a
> sync
>=20
> regards,
> Marc
> --=20
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>=20
>
