From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 18:43:48 +0100
Message-ID: <52EBE0D4.2060907@pengutronix.de>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="C0T50ae8446d65qnPh7GmTwXWdSEEjwXS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50387 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbaAaRoB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 12:44:01 -0500
In-Reply-To: <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <Francesco.Giovannini@iit.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C0T50ae8446d65qnPh7GmTwXWdSEEjwXS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2014 06:38 PM, Francesco Giovannini wrote:
> Here is the output:
>=20
> oSuseBox-IIT:/home/fgiovannini # dmesg -c > /dev/null
>=20
> oSuseBox-IIT:/home/fgiovannini # canconfig can0 bitrate 1000000
> can0 bitrate: 1000000, sample-point: 0.750
>=20
> oSuseBox-IIT:/home/fgiovannini # canconfig can0
> can0 bitrate: 0, sample-point: 0.000
> can0 bittiming:
> 	tq: 0, prop-seq: 0 phase-seq1: 0 phase-seq2: 0 sjw: 0, brp: 0
> can0 state: STOPPED
> can0 restart-ms: 0
> can0 ctrlmode: loopback[OFF], listen-only[OFF], tripple-sampling[OFF],o=
ne-shot[OFF], berr-reporting[OFF]
> can0 clock freq: 60000000
> can0 bittiming-constants: name esd_usb2,
> 	tseg1-min: 1, tseg1-max: 16, tseg2-min: 1, tseg2-max: 8,
> 	sjw-max 4, brp-min: 1, brp-max: 1024, brp-inc: 1,
>=20
> oSuseBox-IIT:/home/fgiovannini # dmesg
> [ 1189.194292] esd_usb2 1-10:1.0: can0: setting BTR=3D0x804d0002
> [ 1189.195338] usb 1-10: USB disconnect, device number 7
> [ 1189.432021] usb 1-10: new high-speed USB device number 8 using ehci_=
hcd
> [ 1189.547438] usb 1-10: New USB device found, idVendor=3D0ab4, idProdu=
ct=3D0010
> [ 1189.547442] usb 1-10: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
> [ 1189.547445] usb 1-10: Product: USB2292
> [ 1189.547447] usb 1-10: Manufacturer: esd electronic system design gmb=
h (www.esd-electronics.com)
> [ 1189.547450] usb 1-10: SerialNumber: GM001950
> [ 1189.549832] esd_usb2 1-10:1.0: can0: device can0 registered
>=20
>=20
> Weird. Looks like canconfig bitrate acts like it is unplugging and plug=
ging the device. Is this normal?

Correct analysis. This is not normal....From you original mail:

> I am running OpenSuse 12.2, kernel 3.4.63-2.44-desktop. I downloaded
> and installed libsocketcan v0.0.9 and canutils v4.0.6. I then
> compiled the esd_can2 module and modprobed it correctly. When i plug
> in my CAN-USB/2 device i get the following from dmesg:

Why do you have compiled the esc_can2 by yourself? It is part of the
kernel. Is it not activated on suse?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--C0T50ae8446d65qnPh7GmTwXWdSEEjwXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLr4NQACgkQjTAFq1RaXHN6agCfWzF83LISDCy11FjgWhLLCL/K
PcwAn1Qdq9aXIuK9R3qu0GFnCIqIfU6e
=8T4X
-----END PGP SIGNATURE-----

--C0T50ae8446d65qnPh7GmTwXWdSEEjwXS--
