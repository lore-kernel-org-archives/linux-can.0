From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: rx_packets/bytes stats for error frames (was: Re: [PATCH v2 1/1] can:
 ucan: add driver for Theobroma Systems UCAN devices)
Date: Wed, 14 Mar 2018 10:36:57 +0100
Message-ID: <4c957d42-2b03-9416-75a4-e331f2ded8cf@pengutronix.de>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
 <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="u6zmgLP6d4ZUuIx0g08s7VOP0FWxzbdON"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6zmgLP6d4ZUuIx0g08s7VOP0FWxzbdON
Content-Type: multipart/mixed; boundary="VunDYGtMXAdOGPEKAROIkeauQDhjaA1oK";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <4c957d42-2b03-9416-75a4-e331f2ded8cf@pengutronix.de>
Subject: rx_packets/bytes stats for error frames (was: Re: [PATCH v2 1/1] can:
 ucan: add driver for Theobroma Systems UCAN devices)
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
 <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
In-Reply-To: <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>

--VunDYGtMXAdOGPEKAROIkeauQDhjaA1oK
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 03/14/2018 10:09 AM, Jakob Unterwurzacher wrote:
> On 14.03.18 08:51, Marc Kleine-Budde wrote:
>>> +		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
>>> +
>>> +	/* don't count error frames as real packets */
>>> +	if (!(canid & CAN_ERR_FLAG)) {
>>> +		stats->rx_packets++;
>>> +		stats->rx_bytes +=3D cf->can_dlc;
>>> +	}
>> Please count them, too.
>=20
> We do count them, as errors!
>=20
> This is what happens when you transmit a single CAN frame with nothing =

> connected: "TX errors" shoots up but "RX packets" stays zero.

This is handled not consistent in the existing CAN drivers. In flexcan
all and c_can (all but rx overflow) are counted as rx_packets and
rx_bytes. (I haven't looked at the other drivers.)

I tend to count the error frames as ordinary frames.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VunDYGtMXAdOGPEKAROIkeauQDhjaA1oK--

--u6zmgLP6d4ZUuIx0g08s7VOP0FWxzbdON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqo7TkACgkQk9IU1zQo
ZfGsqwf/WkJISU3LQLqNxOs/QOsZpSFlBSKOgi6409dak6xVntye+4Z2J0caQPOW
DEoty0MU5FecUI2uYANaU+xIHncbU8VkopQ9XyQl4pDSDMFt9Vgn/vI3opIviFJV
G+CgygcN9iaX+VZmDuhJQFvjba+8a+PXxv4BvvYKBWdZQ88j34JWmBjrnIMWz8Zx
K4IYRQ4g4Zf0Xonzm4QvVKm6V82vkacMWBl2Lauy1KGFny1xavjUv8yBP3Sl/WpW
g6+4QBxosHEtZMAIdsLAbY+VpuKbn3WpawGoyTCYN443sinGIk3xcDSWAdIDsPE6
Go2MYF9bs880lkscCAJaPogvJVIkLw==
=ouAB
-----END PGP SIGNATURE-----

--u6zmgLP6d4ZUuIx0g08s7VOP0FWxzbdON--
