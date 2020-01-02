From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Thu, 2 Jan 2020 13:38:55 +0100
Message-ID: <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
References: <20191210163204.28225-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gZi7TfwV0CRbGkF9I4vj7UoxElcfrKbDR"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gZi7TfwV0CRbGkF9I4vj7UoxElcfrKbDR
Content-Type: multipart/mixed; boundary="coBL95FV6eyGNpCrrK4NMQqNOfZpzPW3X";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
References: <20191210163204.28225-1-dmurphy@ti.com>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>

--coBL95FV6eyGNpCrrK4NMQqNOfZpzPW3X
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/10/19 5:32 PM, Dan Murphy wrote:
> The parse config function now performs action on the device either
> reading or writing and a reset.  If the regulator is managed it needs
> to be turned on.  So turn on the regulator if available if the parsing
> fails then turn off the regulator.

Another BTW:
Consider converting the switching of the vsup to runtime_pm.

Yet another one:
Why do you disable the clocks in the error path of tcan4x5x_can_probe(),
but never enable them?

> out_clk:
> 	if (!IS_ERR(mcan_class->cclk)) {
> 		clk_disable_unprepare(mcan_class->cclk);
> 		clk_disable_unprepare(mcan_class->hclk);
> 	}

- please move the clock handling from the m_can.c to the individual
  driver
- please move the clock handling to runtime_pm in the individual driver
- remove the obsolete m_can_class_get_clocks()
- make runtime_pm mandatory

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--coBL95FV6eyGNpCrrK4NMQqNOfZpzPW3X--

--gZi7TfwV0CRbGkF9I4vj7UoxElcfrKbDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4N5F8ACgkQWsYho5Hk
nSDtHgf9Fuf8bub7UBmK2jcLUq6z/osEin6/bLXyIr4fp7ynFdmK8UMLrrCnmmhQ
JRcv0H+M4b8en91CE/9mBWOC+ZJ8+YVuZvAVyKd8EKzTM5zR87mo7BCDySZ07cFH
qH3aBrn2Sq8++79T9d/1UmA0rPQ43bLvnZg3w7BqOF1ZZzmQ/D81QkccYCXh91Kd
RFOmwWUtgY2C5KBOIcI0kiU+bwVvHablhfJKeZMw90v/bGdDbAFCXo7YakTfkyNF
BXQ5h8bkij7OEKv8esC+8VtIivy8hwLzabGMB/ewwN5xI2tGAvMX49TFiEM/t51H
DQH+BxTY9wB5TrnqdiXl0hBYdzr3pw==
=7WTX
-----END PGP SIGNATURE-----

--gZi7TfwV0CRbGkF9I4vj7UoxElcfrKbDR--
