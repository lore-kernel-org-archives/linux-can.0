From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH 1/9] can: add tx/rx LED trigger support
Date: Mon, 17 Dec 2012 22:42:23 +0100
Message-ID: <20121217214222.GA3539@balto.lan>
References: <1355656113-9562-1-git-send-email-fabio.baltieri@gmail.com>
 <1355656113-9562-2-git-send-email-fabio.baltieri@gmail.com>
 <50CEC9B0.3040503@universalnet.at>
 <20121217174121.GA16327@balto.lan>
 <86fd45485e2016d2c5ad27f28669195e.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33521 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2LQVme (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Dec 2012 16:42:34 -0500
Content-Disposition: inline
In-Reply-To: <86fd45485e2016d2c5ad27f28669195e.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Kurt Van Dijck <kurt.van.dijck@eia.be>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org

On Mon, Dec 17, 2012 at 09:20:57PM +0100, "Bernd Krumb=F6ck" wrote:
> > If you think it's useful for USB controller, just tell me or modify=
 the
> > driver by yourself!  As you see the patch is really easy.
>=20
> At least it is useful for the usb_8dev driver. I'll write a patch.
>=20
> Photo of the device:
> http://www.8devices.com/product/2/usb2can

Sure that it's needed?  That status LED is probably controlled directly
by the firmware itself.  Anyway I think it makes sense to support all
the mainline drivers and I'm really happy if you test the patch on
your hardware!

My only suggestion is to keep the LED support on a separate patch from
the "add driver" one.

Cheers,
=46abio

--=20
=46abio Baltieri
