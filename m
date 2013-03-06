From: Sako Youssouf <youssouf.sako@renault-trucks.com>
Subject: RE: Informations About CAN API of the Linux Kernel
Date: Wed, 6 Mar 2013 16:25:46 +0000
Message-ID: <2B7D120CFC15DC438D721B998AD9D9E909710649@SEGOTNC5180-N2.vcn.ds.volvo.net>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
 <2B7D120CFC15DC438D721B998AD9D9E90971062B@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <51376C4E.3020105@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gw3.it.volvo.com ([192.138.110.232]:23667 "EHLO
	mail-gw3.it.volvo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3CFQZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Mar 2013 11:25:49 -0500
In-Reply-To: <51376C4E.3020105@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

Ok! And do you know the way to know how many frames are in the Queue?=20

Youssouf

_________________________________________________










Youssouf SAKO
System engineer
S +33 1 73 19 07 45
+ youssouf.sako@renault-trucks.com
www.renault-trucks-defense.com

15 bis All=E9e des Marronniers
SAT TER 1 15
SATORY - CS 30502
78 008 VERSAILLES Cedex
=46rance



-----Original Message-----
=46rom: Marc Kleine-Budde [mailto:mkl@pengutronix.de]=20
Sent: mercredi 6 mars 2013 17:18
To: Sako Youssouf
Cc: linux-can@vger.kernel.org; Kurt Van Dijck
Subject: Re: Informations About CAN API of the Linux Kernel

On 03/06/2013 05:03 PM, Sako Youssouf wrote:
> What's your usecae? What do you want to do with that information?
>=20
> Actually I'm in a multithreaded application and my goal is to lose no
> frame. If I had direct access to the hardware, I would go  get the
> new frame after hardware interrupt. But I think it's not possible. So
> I want to find the better way to get all frames in a multithreaded
> application.

The driver takes care of loosing no frame. In you application you just
have to read() or recv() from the socket. It doesn't matter if you app
is multithreaded or not.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

