From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 19:32:02 +0200
Message-ID: <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LOX38i2VVHQcm9v635Gvh3Emub7r1xw9O"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48715 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753535AbcJDRcJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 13:32:09 -0400
In-Reply-To: <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LOX38i2VVHQcm9v635Gvh3Emub7r1xw9O
Content-Type: multipart/mixed; boundary="BVAgmC5WhejUR6kxRLPmBGk0psT3PB2k7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161004135701.GA25008@airbook.vandijck-laurijssen.be>

--BVAgmC5WhejUR6kxRLPmBGk0psT3PB2k7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 03:57 PM, Kurt Van Dijck wrote:
> Recently, someone on this list was confronted with an engine ECU that
> dropped TP that had the last packet not 8 bytes long.
> And I believe I've encountered an issue a long time ago where this
> happened on all PGNs.
> So I introduced this option, having 3 possibilities:
> * no padding
> * padding for TP
> * padding for all PGN.

How to switch between padding for TP only and padding for all PGN?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BVAgmC5WhejUR6kxRLPmBGk0psT3PB2k7--

--LOX38i2VVHQcm9v635Gvh3Emub7r1xw9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX8+eSAAoJED07qiWsqSVqC7cH/RmaGZE0eZK+SPU7SMErqhC2
FRXRCJB4HDPVDcBSHD1QFPZPsyvRia+v79euy1/7zQk+FoXIvO68gvIi/EwKr7fe
vQmQjmcIomFy4DxYjAIxh29uSOq5isvf4gLbUGNPnLpjQTyxf/7xEVdCWnqai+RN
yJmUE/RdcXLJV+RwGEDCgbKEN778ULKzCj+LaFWFY1g/PFp8E00dS2DuiVDdEk6S
F8nML/IVqQ6u7rY39zt4BoC0AQ0x2F62ut2ApR5GnI7EnDW59RTUFn0j4wCSYbZn
PpaT0VyHA/6kAr/OjA3svhhHPCd8hqnp+rmqhzY0p5NiP4AXwNhw9F+YSQZJs/k=
=muvp
-----END PGP SIGNATURE-----

--LOX38i2VVHQcm9v635Gvh3Emub7r1xw9O--
