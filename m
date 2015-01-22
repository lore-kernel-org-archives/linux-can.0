From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6/7 v8] can/peak_usb: add peak_usb_netif_rx() new function
Date: Thu, 22 Jan 2015 16:31:08 +0100
Message-ID: <54C117BC.2080905@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dHDPIJrhpVOUP0ajQSAxS42Eth8AIKi95"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56939 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbbAVPbR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:31:17 -0500
In-Reply-To: <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dHDPIJrhpVOUP0ajQSAxS42Eth8AIKi95
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
> Add a common function that pushes the skb in the network queue with add=
ing
> timestamps information, converted from time values read from the
> PEAK USB adapters.

Why is this function in core.c, it's only used by pcan_usb_fd.c.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dHDPIJrhpVOUP0ajQSAxS42Eth8AIKi95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwRfCAAoJECte4hHFiupUwKEQAJ8hnrWKp4tisK5+WO+LwICs
yVGJzz3DOKCx5mRJexp68EK1UU3ta+XoIuVn9ltW7QMROA9x/icZS4oX8tg7dIbe
Phn6R14s/gtmXsWWxPJpAMzsJOMwSbAf5y6uoynrF99v6oR7e1Jd5L3B57bnX1xf
FK2nvy3+svoNlvXnS04w8OKclngJXe7nyxNNwiK7mwmh9KaavpofcSg2nAVGR2DY
HuPZIpcd8rURXjsE+7ZCkekPdCPDGpwWLyLauHbmVotxGeHlwNMseQ3wbbkFs5Ua
zR0Oi2HYNjGpGhTC3eAvGsnbeyaNZ22mCpkCS9L+B8XtGorrYH8Y6Mp0aWji+Psx
6Bw2oUGBBs/CdL9RmxjUIrZGKe5nrSLrlXK/qO1oARBhnK+XIpGNZfcpeVxSw17l
t2c5+C54s6e0ffN2jW/dlSd4lrwUQbbsG7KWhn692giFpdFcOB+zjZUgCsBsI/eE
QXsyHTBMWJxSb2cLCy2GX2rk/Rqjz2OH7W9uW2Hx78K8xv4hqBxw0ojDoZxo9RIR
swfraoCyxh46XNO+ulI4bM/EVFDxhA5uLROfpzzjkqkB4PoBWcUmfqdrcBuXYO0t
85mwg11H5UhzMhVVrfoD4HfFrlueQoCq7E/kC84kYvuO9/y8sqjdemGf0/LtIK7Q
4DOKcgTh7D7Ii1paMI92
=NQ1P
-----END PGP SIGNATURE-----

--dHDPIJrhpVOUP0ajQSAxS42Eth8AIKi95--
