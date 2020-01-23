From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] Add Support for MCAN in AM654x-idk
Date: Thu, 23 Jan 2020 12:54:27 +0100
Message-ID: <8316b645-72a8-7348-ad4c-1a84535b8b3f@pengutronix.de>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <e3025ab6-04b5-3eba-5e0d-70caabee26fb@pengutronix.de>
 <f6bf75f0-68ea-0b61-ed43-9ad894016cfd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3079353256574713158=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <f6bf75f0-68ea-0b61-ed43-9ad894016cfd@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, t-kristo@ti.com, robh+dt@kernel.org, dmurphy@ti.com, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3079353256574713158==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZekFneOlWau0d0DimzpZ8ix6vmezbf04K"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZekFneOlWau0d0DimzpZ8ix6vmezbf04K
Content-Type: multipart/mixed; boundary="dZh96g5yZPeAk3UDgD43pvfcj6xxa9jF3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
 davem@davemloft.net, wg@grandegger.com, sriram.dash@samsung.com,
 dmurphy@ti.com, nm@ti.com, t-kristo@ti.com
Message-ID: <8316b645-72a8-7348-ad4c-1a84535b8b3f@pengutronix.de>
Subject: Re: [PATCH 0/3] Add Support for MCAN in AM654x-idk
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <e3025ab6-04b5-3eba-5e0d-70caabee26fb@pengutronix.de>
 <f6bf75f0-68ea-0b61-ed43-9ad894016cfd@ti.com>
In-Reply-To: <f6bf75f0-68ea-0b61-ed43-9ad894016cfd@ti.com>

--dZh96g5yZPeAk3UDgD43pvfcj6xxa9jF3
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/23/20 12:46 PM, Faiz Abbas wrote:
> Marc,
>=20
> On 23/01/20 4:47 pm, Marc Kleine-Budde wrote:
>> On 1/22/20 9:03 AM, Faiz Abbas wrote:
>>> This series adds driver patches to support MCAN in TI's AM654x-idk.
>>>
>>> Faiz Abbas (3):
>>>   dt-bindings: net: can: m_can: Add Documentation for stb-gpios
>>>   can: m_can: m_can_platform: Add support for enabling transceiver
>>>     through the STB line
>>>   arm64: defconfig: Add Support for Bosch M_CAN controllers
>>>
>>>  Documentation/devicetree/bindings/net/can/m_can.txt |  2 ++
>>>  arch/arm64/configs/defconfig                        |  3 +++
>>>  drivers/net/can/m_can/m_can_platform.c              | 12 +++++++++++=
+
>>>  3 files changed, 17 insertions(+)
>>
>> What about adding support for xceiver-supply as done in several other
>> drivers (ti_hecc.c, flexcan.c, mcp251x.c)? And using this for the stb =
line?
>=20
> Looks like you had given this feedback a long time ago and I forgot
> about it. Sorry about that :-)
>=20
> https://lore.kernel.org/patchwork/patch/1006238/
>=20
> But now that I think about it, its kinda weird that we are modelling
> part of the transceiver as a separate child node
> (Documentation/devicetree/bindings/net/can/can-transceiver.txt) and the=

> other parts as a regulator.

We need a regulator, as there are dual phy chips with a single enable lin=
e.

> Anyone looking at the transceiver node would figure thats where the
> enable gpio/regulator node needs to go instead of the parent node.
> Shouldn't we have all transceiver properties under the same node?

Feel free to add support for the regulator to the transceiver node and
convert the existing drivers to accept both bindings.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--dZh96g5yZPeAk3UDgD43pvfcj6xxa9jF3--

--ZekFneOlWau0d0DimzpZ8ix6vmezbf04K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4piXMACgkQWsYho5Hk
nSDbYQf9FulmhfP1PMrOxVuC+lmRBuENjjVM3uSBabZp45CsDtFmdtNkuZzC49V5
UmJ+iQda6TF3lki1QR4qjPV2zsjh7Gu/b6YKGryqKsieWNoQ6fwmpltKSqHw4YA/
fSZzbIalXxRQ1M8hMhpR06IP0PR91Ge4f/ABv4To72wKAaEMeC0bVCWKUNPpisHT
rObprWj1W2gh/Bh5vMg6zPHY5+HQYzr8qcsbt1l5LbxQMN7kiwuDHp4/fWA7RemE
21nv/dd6B24RIJ3b0Urq4zXVvXguoZbQmH0Ay1T8xo4ck64RVDfP2rK6oK1lgIqq
TCfcyvxUxGE2tusFiMy/PV/ps7uvfQ==
=vRTh
-----END PGP SIGNATURE-----

--ZekFneOlWau0d0DimzpZ8ix6vmezbf04K--


--===============3079353256574713158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3079353256574713158==--
