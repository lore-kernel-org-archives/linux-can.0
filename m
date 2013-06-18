From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: 8devices problem on usb-3.0 host
Date: Tue, 18 Jun 2013 14:31:57 +0200
Message-ID: <51C0533D.5030502@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GOISJMVDLHULJVLICSSH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51623 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab3FRMcF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Jun 2013 08:32:05 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-15?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michael Olbrich <mol@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GOISJMVDLHULJVLICSSH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Bernd,

my college Michael is using the 8 devices usb dongle on an USB-3.0 host
and it fails with:

> [ 1686.609330] can: raw protocol (rev 20120528)
> [ 3347.787587] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.788319] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.789050] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.789794] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.790525] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.791259] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.791998] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.792727] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.793461] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.794192] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.794928] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.795655] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.796395] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.797134] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.797859] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.798594] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.799325] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.800061] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.800797] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.801524] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.802260] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.802990] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.803725] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.804461] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.805191] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.805927] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.806657] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.807393] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.808129] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.808861] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.809599] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.810326] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.811062] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.811798] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.812355] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.813096] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.813822] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.814558] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.815294] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.815851] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.816587] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.817316] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.818052] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.818613] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.819354] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.820090] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.820821] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.821557] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.822108] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.822838] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.823573] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.824304] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.824855] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.825589] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.826320] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.827056] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.827605] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.828530] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.829266] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.829996] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.830733] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.831461] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.832197] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.832935] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.833483] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.834218] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.834948] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.835684] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.836420] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.837344] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.838079] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.838810] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.839543] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.840278] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.841009] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.841744] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.842475] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.843210] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.843946] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.844677] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.845240] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.845970] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.846706] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.847441] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.848172] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.848909] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.849640] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.850564] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.851300] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.852031] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.852768] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.853497] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.854233] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.854968] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.855699] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.856435] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.856993] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.857730] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.858464] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.859195] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.859930] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.860491] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.861223] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.861959] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.862690] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.863426] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.864157] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.864893] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.865630] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.866367] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.867103] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.867833] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.868570] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.869306] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.869866] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.870601] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.871332] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.872068] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.872803] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.873534] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.874271] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.875003] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.875738] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.876473] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.877204] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.877940] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.878498] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.879234] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.879971] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.880701] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.881437] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.881995] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.882730] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.883466] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.884197] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.884749] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.885480] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.886216] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.886952] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.887498] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.888233] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.888963] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.889700] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.890252] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.890983] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.891719] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.892450] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.892994] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.893728] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.894459] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.895195] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.895752] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.896488] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.897224] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
> [ 3347.897725] usb 3-1.2: USB disconnect, device number 8
> [ 3347.898037] usb_8dev 3-1.2:1.0 can0: device disconnected
> [ 3347.898058] usb_8dev 3-1.2:1.0 can0: sending command message failed
> [ 3347.898062] usb_8dev 3-1.2:1.0 can0: couldn't stop device
> [ 3354.974145] usb 1-2: new full-speed USB device number 5 using xhci_h=
cd
> [ 3354.974366] usb 1-2: Device not responding to set address.
> [ 3355.184387] usb 1-2: Device not responding to set address.
> [ 3355.394243] usb 1-2: device not accepting address 5, error -71
> [ 3355.514288] usb 1-2: new full-speed USB device number 6 using xhci_h=
cd
> [ 3355.536209] usb 1-2: New USB device found, idVendor=3D0483, idProduc=
t=3D1234
> [ 3355.536216] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D3
> [ 3355.536220] usb 1-2: Product: USB2CAN converter
> [ 3355.536224] usb 1-2: Manufacturer: edevices
> [ 3355.536227] usb 1-2: SerialNumber: ED000210
> [ 3356.635802] usb_8dev 1-2:1.0 can0: no command message answer
> [ 3356.635811] usb_8dev 1-2:1.0 can0: can't get firmware version

Then the driver oopes; I already have a patch for the oops, I'll send it
around soon.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2GOISJMVDLHULJVLICSSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHAU0AACgkQjTAFq1RaXHNfuACfUur7MrHoUrueDxk5bNLHlrZ6
ei8AoJKJ6Y2Wjhc4zIfpkKgVUNRqFnO/
=1afW
-----END PGP SIGNATURE-----

------enig2GOISJMVDLHULJVLICSSH--
