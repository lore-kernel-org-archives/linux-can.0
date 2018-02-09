From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Associate physical device with device name
Date: Fri, 9 Feb 2018 11:47:45 +0100
Message-ID: <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="y8DYLC7puEHZMMdMvRbboVlZjyGpVTsMV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38261 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBIKs1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Feb 2018 05:48:27 -0500
In-Reply-To: <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y8DYLC7puEHZMMdMvRbboVlZjyGpVTsMV
Content-Type: multipart/mixed; boundary="g9cWccQawR5qxzx8SkDuJOMaCYriPKxM5";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <464f89e6-82c8-a2fd-25e2-f847508b41a3@pengutronix.de>
Subject: Re: Associate physical device with device name
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
 <87ddf56f-c829-6aad-5b86-474359d282d4@pengutronix.de>
 <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>
In-Reply-To: <f1dbf319-eda5-6901-c5e4-d08651e2c1fe@kvaser.com>

--g9cWccQawR5qxzx8SkDuJOMaCYriPKxM5
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/08/2018 02:04 PM, Jimmy Assarsson wrote:
> No, they are not identical. The EAN and serial number is stored on the
> device.

How to read them?

> Which makes a single device unique. It is possible to fetch these
> from the device. And same applies to all Kvaser CAN interfaces,=20
> regardless if they are connected via USB, PCI-express or ethernet.
What's the output of the udev when using the proper path to your device?

"udevadm info --path=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2/ -a"

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--g9cWccQawR5qxzx8SkDuJOMaCYriPKxM5--

--y8DYLC7puEHZMMdMvRbboVlZjyGpVTsMV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp9fFEACgkQk9IU1zQo
ZfFjqQf+MdINMUtlPME/OihfbwVa06jlM1cnDzLgBcEYctjplJkJPrXoVwbq1DWe
NPaQKfqoNxev+JHktwdisiFeN/QmbGMneKKRAfoRPxtwMjf0+Z6wsWOZqbIEZN/D
aIy+spN6nLM49u42wTXG7FzsrtGXKgk2nJi/eQSrgKMmobfLB9ggljEfTzvZqwgg
DPvY5gWH1518S1vi6sNBkW0fFb1ByE/r79qh0Csdq5tV3EMj+wdVe4F8kppfbN2j
txfJtOFj+XA3PtDbtLMdbgi+xl8wqBXVvG2MO6cwFVXpcncgYkSniH6ltN6c5LrS
6TstQn6GC326lSvY4YL+/XXAUFFvoQ==
=gD5S
-----END PGP SIGNATURE-----

--y8DYLC7puEHZMMdMvRbboVlZjyGpVTsMV--
