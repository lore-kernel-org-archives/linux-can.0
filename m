From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH V5 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 10:10:18 +0000
Message-ID: <20150317101018.11690.58372@shannon>
References: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
 <20150316124621.14895.31220@shannon>
 <8CE1D0B9BFD2404DA079DDE1814A6F2E03294EFD39B3@esd-s3.esd.local>
 <20150317072639.GA2802@Darwish.PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0091.outbound.protection.outlook.com ([157.55.234.91]:62816
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753236AbbCQKKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 06:10:22 -0400
In-Reply-To: <20150317072639.GA2802@Darwish.PC>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S.Darwish" <darwish.07@gmail.com>, =?utf-8?b?IlRob21hcyBLw7ZycGVy?= <Thomas.Koerper@esd.eu>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Quoting Ahmed S. Darwish (2015-03-17 07:26:39)
> Hi Thomas,
>=20
> On Tue, Mar 17, 2015 at 07:30:02AM +0100, Thomas K=C3=B6rper wrote:
> > Hi Andri,
> >=20
> > I've looked at the sources you mentioned, but I'm a little bit unsu=
re now /
> > the handling seems not perfectly consistent to me. (flexcan calls
> > can_change_state() with tx/rx_state of 0 in the bus off path.
> >
>=20
> There're discrpeancies indeed on the BUSOFF path:
>=20
> 1) flexcan calls can_change_state(dev, cf, 0, 0). kvaser and others
>    do can_change_state(dev, cf, tx, rx) where either tx or rx =3D
>    CAN_STATE_BUS_OFF. In this case, kvaser and the other drivers
>    are the _correct_ behavior. This is validated by can-dev
>    can_chage_state() code:
>=20
>         if (unlikely(new_state =3D=3D CAN_STATE_BUS_OFF)) {
>                 cf->can_id |=3D CAN_ERR_BUSOFF;
>                 return;
>         }
Indeed, I'll have to fix that. Well spotted Thomas!
>=20
> 2) flexcan calls can_bus_off(dev), while kvaser goes a layer deeper
>    and directly calls netif_carrier_off(netdev). In this case,
>    flexcan is the more correct behavior.
>=20
IMO, that's fine as long as it doesn't add to inconsistency between out=
wards
behaviour of the system; which it doesn't.

Best regards,
Andri
