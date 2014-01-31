From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 17:14:50 +0100
Message-ID: <52EBCBFA.2090205@pengutronix.de>
References: <52EBCACD.9080906@iit.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="79IFX5hVob6Ai29pgC4HE5rNO6LEX4sig"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57983 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbaAaQOz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 11:14:55 -0500
In-Reply-To: <52EBCACD.9080906@iit.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--79IFX5hVob6Ai29pgC4HE5rNO6LEX4sig
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2014 05:09 PM, Francesco Giovannini wrote:
> Hi guys!
>=20
> I am running OpenSuse 12.2, kernel 3.4.63-2.44-desktop. I downloaded an=
d
> installed libsocketcan v0.0.9 and canutils v4.0.6. I then compiled the
> esd_can2 module and modprobed it correctly. When i plug in my CAN-USB/2=

> device i get the following from dmesg:
>=20
>    [186823.262021] usb 1-10: new high-speed USB device number 22 using
>    ehci_hcd
>    [186823.826031] usb 1-10: device not accepting address 22, error -71=

>    [186823.877025] hub 1-0:1.0: unable to enumerate USB device on port =
10
>    [186827.879018] usb 1-10: new high-speed USB device number 24 using
>    ehci_hcd
>    [186827.995429] usb 1-10: New USB device found, idVendor=3D0ab4,
>    idProduct=3D0010
>    [186827.995432] usb 1-10: New USB device strings: Mfr=3D1, Product=3D=
2,
>    SerialNumber=3D3
>    [186827.995435] usb 1-10: Product: USB2292
>    [186827.995438] usb 1-10: Manufacturer: esd electronic system design=

>    gmbh (www.esd-electronics.com)
>    [186827.995440] usb 1-10: SerialNumber: GM001950
>    [186827.997824] esd_usb2 1-10:1.0: can0: device can0 registered
>=20
> The device appears to be correctly recognised and the can0 interface is=

> ready to be used. I then set the bitrate and several other paramters wi=
th:
>=20
>    # canconfig can0 bittiming  prop-seg 2 phase-seg1 12 phase-seg2 5
>    sjw 1 brp 3 tq 50
>=20
>    can0 bittiming:
>         tq: 50, prop-seq: 2 phase-seq1: 12 phase-seq2: 5 sjw: 1, brp: 3=

>    can0 bitrate: 1000000, sample-point: 0.750

Try to set the bittiming with this command:

    canconfig can0 bitrate 1000000

Does this work?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--79IFX5hVob6Ai29pgC4HE5rNO6LEX4sig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLry/oACgkQjTAFq1RaXHPprACdHy0c4AbSJIoaVltdXQ0sSrFP
/gYAn1m85gB02MVDhxauAGHzmzUiV7ji
=v2o7
-----END PGP SIGNATURE-----

--79IFX5hVob6Ai29pgC4HE5rNO6LEX4sig--
