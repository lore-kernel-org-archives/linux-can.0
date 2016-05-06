From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: flexcan: patch
Date: Fri, 6 May 2016 17:56:22 +0200
Message-ID: <572CBEA6.2030607@pengutronix.de>
References: <14855451462460611@web29h.yandex.ru>
 <572C7149.6040307@pengutronix.de> <629131462542452@web29o.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="E6RwlOcpSh3Julvcsh47alF6TgrRlXFW9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49068 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758073AbcEFP4a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 May 2016 11:56:30 -0400
In-Reply-To: <629131462542452@web29o.yandex.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mikhail Kofanov <c5r@yandex.ru>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E6RwlOcpSh3Julvcsh47alF6TgrRlXFW9
Content-Type: multipart/mixed; boundary="3spC6kcRxlUUp39UDPIgTWWINKxHpllxl"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mikhail Kofanov <c5r@yandex.ru>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <572CBEA6.2030607@pengutronix.de>
Subject: Re: can: flexcan: patch
References: <14855451462460611@web29h.yandex.ru>
 <572C7149.6040307@pengutronix.de> <629131462542452@web29o.yandex.ru>
In-Reply-To: <629131462542452@web29o.yandex.ru>

--3spC6kcRxlUUp39UDPIgTWWINKxHpllxl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2016 03:47 PM, Mikhail Kofanov wrote:
> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tre=
e/?id=3Dffd461f80d536336811d573f197f3e6d9872d054

The patch does not apply, as your mailer converted all tabs to spaces
and capped long lines....See below:

>>>          /* schedule NAPI in case of:
>>>           * - rx IRQ
>>>  - * - state change IRQ
>>>  + * - tx/rx warning or bus-off
>>>  + * - any state change
>>>           * - bus error IRQ and bus error reporting is activated
>>>           */
>>>          if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
>>>              (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>>>  + ((reg_esr & FLEXCAN_ESR_FLT_CONF_MASK) !=3D (priv->reg_esr & FLEXC=
AN_ESR_FLT_CONF_MAS

There seems to be a problem with this mail, the rest of this line is
missing.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3spC6kcRxlUUp39UDPIgTWWINKxHpllxl--

--E6RwlOcpSh3Julvcsh47alF6TgrRlXFW9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXLL6mAAoJED07qiWsqSVqp9AIALGDAVki5a8dsqL/mf4ITPv4
S019PS1eSXNdmTGls8o9kZJaEkLO6Sxix94HlA7LGTNBMWQ39JebAO9/7T7c5fd5
d+qJ+bLtZY4mCSHFR16t/7riMNfvpFATMoi4aUdPwevq3QmXyu0uxNF0ZlJhEXwK
k8GXVcONFn2ZAGuPr0Q1FD7SOZQBiN/wMh/0k571BpDwkaAecikiA+lBu9P9jDlC
tLaii/34jVpkLTPHxqW47BkHK2NIvGipfAzsutXHt9t97ZFvgCQiNp7FT2BJpgho
MsS+zIOwsxKmdi03RNpquRPE9hD9x+E2DFmVgqNp+6Yd5AxJqIW4tGzRiBWMmkQ=
=nWmW
-----END PGP SIGNATURE-----

--E6RwlOcpSh3Julvcsh47alF6TgrRlXFW9--
