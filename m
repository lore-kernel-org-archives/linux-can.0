From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 net-next] dt-bindings: can: rcar_can: document r8a77965
 support
Date: Thu, 27 Sep 2018 12:46:28 +0200
Message-ID: <129e18fd-8161-0f79-d17a-9bb73c3ed717@pengutronix.de>
References: <20180820144910.13210-1-erosca@de.adit-jv.com>
 <50048177-96ad-cbda-6845-20ffc32d025a@pengutronix.de>
 <20180921194833.GA28500@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vejwY6kMxSSax3MYakY7MtDbDzeZymlzE"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180921194833.GA28500@vmlxhi-102.adit-jv.com>
Sender: netdev-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, linux-renesas-soc@vger.kernel.org, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vejwY6kMxSSax3MYakY7MtDbDzeZymlzE
Content-Type: multipart/mixed; boundary="ddrS4jMJFRRubP9HSO5wb4GKW9I50qh2d";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S . Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Magnus Damm <damm+renesas@opensource.se>, linux-renesas-soc@vger.kernel.org,
 Eugeniu Rosca <rosca.eugeniu@gmail.com>
Message-ID: <129e18fd-8161-0f79-d17a-9bb73c3ed717@pengutronix.de>
Subject: Re: [PATCH v3 net-next] dt-bindings: can: rcar_can: document r8a77965
 support
References: <20180820144910.13210-1-erosca@de.adit-jv.com>
 <50048177-96ad-cbda-6845-20ffc32d025a@pengutronix.de>
 <20180921194833.GA28500@vmlxhi-102.adit-jv.com>
In-Reply-To: <20180921194833.GA28500@vmlxhi-102.adit-jv.com>

--ddrS4jMJFRRubP9HSO5wb4GKW9I50qh2d
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 09/21/2018 09:48 PM, Eugeniu Rosca wrote:
> Hi Marc,
>=20
> On Mon, Aug 27, 2018 at 12:08:48PM +0200, Marc Kleine-Budde wrote:
>> On 08/20/2018 04:49 PM, Eugeniu Rosca wrote:
>>> From: Eugeniu Rosca <rosca.eugeniu@gmail.com>
>>>
>>> Document the support for rcar_can on R8A77965 SoC devices.
>>> Add R8A77965 to the list of SoCs which require the "assigned-clocks" =
and
>>> "assigned-clock-rates" properties (thanks, Sergei).
>>>
>>> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>>> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>=

>>
>> Added to linux-can.
>=20
> I can't find the patch in below repositories:
>  - https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
>  - https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.g=
it
>=20
> Could you please let me know what "linux-can" means?

I haven't pushed it yet, it will be in the testing branch of linux-can.gi=
t

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ddrS4jMJFRRubP9HSO5wb4GKW9I50qh2d--

--vejwY6kMxSSax3MYakY7MtDbDzeZymlzE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlustQQACgkQk9IU1zQo
ZfF0Cwf/WiJgT7kjKDkGGinIWCmidTQiO5yX26s30pAmfRNRgDIHNax0rtb9A6Lm
BQ2uv/AAHwXrEhTdM02qGLLEsrVbBIexnjb6ArtCYgFU5hOHzl1LXrPWcFA+2IKW
Scvum80ttnWW3KZNdsFn1YZ9yPyg213roe9l+FHJghced6YPQN18AVSHrTMjG81a
mGnzRkAL4qMnd3LqdA39Cm4unyJioY0JHEp1YApXeXsaYCo3thoAHTrvTI0YaIUt
uGTYlZx9UZ9n0A8QH6mJm/ceM4EEJrY9NTz8w+H5SJOalDE0wG4qNsE/yfxfeFET
vm3RItkfuquP6uGNY4IGyoIxF2remQ==
=TvQ0
-----END PGP SIGNATURE-----

--vejwY6kMxSSax3MYakY7MtDbDzeZymlzE--
