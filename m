From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 14:47:02 +0200
Message-ID: <5555EAC6.8010901@pengutronix.de>
References: <5555A6A3.7090206@orange.fr>
 <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
 <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr>
 <20150515102450.24212.89893@shannon> <5555E93A.7080507@orange.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pbUu8R8XW4HTFSQwxsncvHdkoHakHxqJR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51216 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030185AbbEOMrN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 08:47:13 -0400
in-reply-to: <5555E93A.7080507@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Fran=c3=a7ois_Beaulier?= <fbeaulier@orange.fr>, Andri Yngvason <andri.yngvason@marel.com>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pbUu8R8XW4HTFSQwxsncvHdkoHakHxqJR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2015 02:40 PM, Fran=C3=A7ois Beaulier wrote:
>> Have you considered FPGA?
>>
>> Andri
> I don't know much about FPGA, i can see in the kernel that there are=20
> c_can and m_can drivers, i guess i have to add something like a PCIe=20

c_can and m_can are IP cores by bosch, they are used in various SoCs.

> bridge to connect the CAN controllers with the SOC ?
> Is there a way to use FPGA that would not lead to driver development ?
> Do you have any link where i can learn more about Linux + FPGA + CAN ?

You have to use an IP core that is already supported by the kernel.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pbUu8R8XW4HTFSQwxsncvHdkoHakHxqJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVVerGAAoJEP5prqPJtc/HnGUH/ROE86QMma5QDDXj0jXgDTEu
yKNzBoweNMfkGLN6facqKcHsGN+RRBNxrI8AZegNz4kh34+PDpUb1CVs9wuQvK9z
zg4adZHrStLzwMn4tJKkY8se4iL4F4dW/ovgwjI5MXUy5NHicaJyhicsILjOMnoK
BqiVWI3DoryIn1W7f/22udbzqLdmjCU/KETYwIoaLZiTlZuXA5qiPwk3/7XeYPmU
GTMC6WBNJdEe3LI4uf/h4w77UJ4l8wlUEHJcbxNNWpZe7Zn/QuzoifcDKgg6rTvo
/trmBIGFOCYFHH/A4yZYJE/853RNEIyIlyIoX8NEoL2p7qpsHj/Sxnkc21QpO5Q=
=UfG4
-----END PGP SIGNATURE-----

--pbUu8R8XW4HTFSQwxsncvHdkoHakHxqJR--
