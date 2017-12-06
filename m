From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: peak-usb: peak_usb_netif_rx() ts_high ununsed
Date: Wed, 6 Dec 2017 15:09:22 +0100
Message-ID: <ee2e4702-5d2d-b6fc-a90c-5fc9b0d3f362@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1460Bk3t867jImMnDg1rJ7xVuAtpOr7qu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36139 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751888AbdLFOJm (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Wed, 6 Dec 2017 09:09:42 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1460Bk3t867jImMnDg1rJ7xVuAtpOr7qu
Content-Type: multipart/mixed; boundary="rFMMSCbDmrtsmnsTxBAOGB3AtRMt4BFMa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>,
 Stephane Grosjean <s.grosjean@peak-system.com>
Message-ID: <ee2e4702-5d2d-b6fc-a90c-5fc9b0d3f362@pengutronix.de>
Subject: peak-usb: peak_usb_netif_rx() ts_high ununsed

--rFMMSCbDmrtsmnsTxBAOGB3AtRMt4BFMa
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello,

we just found out that ts_high is never used:

> /*
>  * post received skb after having set any hw timestamp
>  */
> int peak_usb_netif_rx(struct sk_buff *skb,
> 		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high)
> {
> 	struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
>=20
> 	peak_usb_get_ts_time(time_ref, ts_low, &hwts->hwtstamp);
>=20
> 	return netif_rx(skb);
> }

Is that expected? If yes, let's remove ts_high.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rFMMSCbDmrtsmnsTxBAOGB3AtRMt4BFMa--

--1460Bk3t867jImMnDg1rJ7xVuAtpOr7qu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlon+hIACgkQHv7KIOw4
HPYOfAgAiVk9IwZfeY1oDSQbPRXaKgC7ih4hJkN32FuRTs6vbQVHu5ygFjViQK1n
ui0cxBBXGRksM4Ct9C3MIUS2acE+e4gjhOupM0StN4i9KfDB8w38NWdZekft1x/M
lLRY1Kr4znatiVejuzjRGPUakg96XvbxTVrztZo6sYLU0CnMnU2NGhO2cBAJDAr8
cYqGB96gvChWLNhYzvo14Ch99l6HJkUH2ZNAnWhQQtqOtgzPAw5eJJCDyhgwkcpe
XHZ42rKxRelvALgfpqgUt/w0S7sUGJjc0wVYL4PinQ2a3OsFSk1TS9F468qgrpjj
4eRq+LYrdrcU9R6eF1Mjxp199kXdUQ==
=8B2U
-----END PGP SIGNATURE-----

--1460Bk3t867jImMnDg1rJ7xVuAtpOr7qu--
