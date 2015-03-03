From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Bug on configure ... where to report?
Date: Tue, 03 Mar 2015 08:29:18 +0100
Message-ID: <54F562CE.6030009@pengutronix.de>
References: <54EE63C5.3040307@allcaps.org> <54EEDD2F.5080501@pengutronix.de> <54F4EAE3.5090406@allcaps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tcIgJw0dnCi7vxaRJrNftLM4GL0W5eD3a"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44597 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbbCCH33 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Mar 2015 02:29:29 -0500
In-Reply-To: <54F4EAE3.5090406@allcaps.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Lentvorski <bsder@allcaps.org>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tcIgJw0dnCi7vxaRJrNftLM4GL0W5eD3a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2015 11:57 PM, Andrew Lentvorski wrote:
>> Which versions of autoconf, automake and libtool are you using?
>=20
> root@beaglebone:~/can-utils# autoconf --version
> autoconf (GNU Autoconf) 2.69
>=20
> root@beaglebone:~/can-utils# automake --version
> Useless use of /d modifier in transliteration operator at
> /usr/share/automake-1.9/Automake/Wrap.pm line 60.
> automake (GNU automake) 1.9.6

Can you upgrade to wheezy's latest automake, that's 1.11.6.

I've tested on a wheezy system with automake-1.11.6 and it works, even
without the patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tcIgJw0dnCi7vxaRJrNftLM4GL0W5eD3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9WLSAAoJECte4hHFiupUth4QAJdvGPF6U2tZzo+Xqe6ETosD
ZXClV8ZduWlk471bR+5TJcShKoCd3bSJ5+RYSNoIriaFUiIYfUZUknJ3pHoxU4Qc
uRXXZBVyDuTyQ8zFjTMbgQE1xsiorGhd4smkLDnLOniKAOt90x2G0yF3id/bAB+5
mIPmyCckX6WQT5dojwvTQchtAZrL98V9emSQdaPhuY3c/qvULz6zvZ20kPaYsTZu
5JnBnpbR7LvVcTddsD9nzmLYoXbCfsT2lrM6UqBLpyslDN4+uSD9eAJXeGdo18wO
WuZS5AL9GRC7sWFfffuAJHt52cBFMkRa0s1ZcK3/ZcP98bo43GRSKtgb/s9h0Fi7
wPWwqLxw3EsY0CcmBvY8zFeyrZGERzN6hU3pElARasptWb1mC42ISv6fbjJ3JhlZ
qwylhya3cDxabY35f2N5QwqH6/frwP7cPJ8MVMBU1kS92Yu8fGJkxLnNrwVjTPCs
E60GesB17yGmHt4xBgaOxbEmybrNgQ9SUxvNbe0ZeCxAvOQeGODSCxdxx0sL4mGw
fTy0oQ++7Ynzy1gPySw/GInRODV9SBdPbrcwF+bO4msE/+iWBPhyv0q2tEXbb4mG
DHufZkBcmbKqBmDfMBK3BlkPyFThU8TlkOFJKEaxl0Z7mN0p/eZS93TlakqnU4Rc
QbO7e7HSi5POGQqMc7cW
=1pZn
-----END PGP SIGNATURE-----

--tcIgJw0dnCi7vxaRJrNftLM4GL0W5eD3a--
