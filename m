From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Wed, 01 Oct 2014 14:41:43 +0200
Message-ID: <542BF687.1000800@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tGD2mLwK9UtNj559BvjsSavHUPJncOWCj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbaJAMlt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 08:41:49 -0400
In-Reply-To: <542BF456.3030201@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tGD2mLwK9UtNj559BvjsSavHUPJncOWCj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/01/2014 02:32 PM, Florian Feldbauer wrote:
>> Do you get any interrupts?
> Seems not the case
> Sending doesn't work either...
> From a very quick look, it seems the GPIOs are not set...But to be sure=

> I have to build a small adapter in order to properly connect our digita=
l
> scope to it...

Let's see if there is actual output on the GPIO lines...

BTW: what's the use-case of the rpi, better buy a beagle bone black.
IIRC you need to attach the CAN phy, and you're ready to go. It comes
with two internal CAN cores, the first one is quite easy to setup, the
second one uses the same pins as one the the I2C busses, which has to be
disabled then... And you can use a proper mainline kernel.

>>> I'm working with the raspberry pi kernel
>>> (https://github.com/raspberrypi/linux)
>>> version 3.12.y commit c256eb9968c8997dce47350d2075e42f1b3991d3
>>>
>>> Source of my own kernel module is also on github
>>> https://github.com/ffeldbauer/epics_RPi_can/blob/ver3.0.0/CAN_interfa=
ce/driver/sja1000_raspi.c
>>>
>>>
>>>
>>> As written before, I could not find a documentation of socketCAN and
>>> simply tried
>>> to "copy" the sja1000_isa.c driver...naybe I did something completely=

>>> wrong or missed
>>> something?
>> Yes, making a copy of the driver is probably not the right thing....
>> BTW: where's are the original copyright notes?
> "Copy" in this case means: I looked into
> sja1000_isa.c/sja1000_platform.c to see what function have
> to be implemented and what parameters do they use.
> I copied the corresponding functions from my chardev driver and modifie=
d
> them
> accordingly....

IANAL, but it's best practice to state which parts of your driver is
based on the work of others.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tGD2mLwK9UtNj559BvjsSavHUPJncOWCj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQr9ocACgkQjTAFq1RaXHP8IACfaLmK2F3QeZRijkBZAmofRJt1
h8IAn0yLLl0Fo0le0409l85mvXPmsxMI
=6x3R
-----END PGP SIGNATURE-----

--tGD2mLwK9UtNj559BvjsSavHUPJncOWCj--
