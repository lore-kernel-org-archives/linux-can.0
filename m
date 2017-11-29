From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: CAN-USB adapter unplug (was: Re: [PATCH v2 1/2] can: mcba_usb: fix
 typo)
Date: Wed, 29 Nov 2017 13:20:47 +0100
Message-ID: <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
References: <20171127234916.25865-1-mkelly@xevo.com>
 <31e3532f-5899-5d0a-f27a-378fe2ee5124@pengutronix.de>
 <1c246910-a55b-f16c-bff7-b93f3310ce7b@xevo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hcnHShcsq9CP6Cqlp1NW1Cv5ncvxlre57"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46307 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752659AbdK2MUz (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Wed, 29 Nov 2017 07:20:55 -0500
In-Reply-To: <1c246910-a55b-f16c-bff7-b93f3310ce7b@xevo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kelly <mkelly@xevo.com>, linux-can@vger.kernel.org
Cc: =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcnHShcsq9CP6Cqlp1NW1Cv5ncvxlre57
Content-Type: multipart/mixed; boundary="2hjKMXp9KIQSrsMBBj1KfNdD456Rq2xBi";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Kelly <mkelly@xevo.com>, linux-can@vger.kernel.org
Cc: =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
Subject: CAN-USB adapter unplug (was: Re: [PATCH v2 1/2] can: mcba_usb: fix
 typo)
References: <20171127234916.25865-1-mkelly@xevo.com>
 <31e3532f-5899-5d0a-f27a-378fe2ee5124@pengutronix.de>
 <1c246910-a55b-f16c-bff7-b93f3310ce7b@xevo.com>
In-Reply-To: <1c246910-a55b-f16c-bff7-b93f3310ce7b@xevo.com>

--2hjKMXp9KIQSrsMBBj1KfNdD456Rq2xBi
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/28/2017 10:09 PM, Martin Kelly wrote:
>> Both applied to can.
>=20
> Thanks! By the way as far as I can tell from code inspection, it appear=
s=20
> that most of the other drivers in net/can/usb should have the same=20
> disconnect bug. gs_usb appears to be clear, as it returns in its defaul=
t=20
> case. Unfortunately mcba_usb is the only device I have to test with, bu=
t=20
> those with other devices may want to check for this.

Can you create patches for the affected drivers and send them to the
list and the maintainers of the driver on Cc?

I don't have access to every USB adapter neither.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2hjKMXp9KIQSrsMBBj1KfNdD456Rq2xBi--

--hcnHShcsq9CP6Cqlp1NW1Cv5ncvxlre57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloepiAACgkQHv7KIOw4
HPasEwgAqOmrfnxsyjfmq39RZAEFsheWxIc3GJsUB8DZIyDVwc5eKMMNMIFPgTks
hAoK/Jth5+P4iyiyvO32dP+MTqkYYVl9nN3Y1ywM3flV6ItWE8ISLRojmYD56Drc
mOMYmx13AwNhCvn+ggv/QoAOGQQWi7yg+K49GHCimspVichSgiVPkZwDTT7q+s3R
3I8QfCmFFgKnP56HMro7YIMzmM7jVIDl8Xwz8rgPyHEj3Dkhh8V7Ek7U/gVHQwMl
imERvwIwLExr96SLpWAFyCAm4rpOla2XFsOhz2O9kMQ/IBYyIWpb9PpG1C3pZua3
gDAiJQNLzH3MPWMs3zr7MLC+U6uOHQ==
=NMRE
-----END PGP SIGNATURE-----

--hcnHShcsq9CP6Cqlp1NW1Cv5ncvxlre57--
