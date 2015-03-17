From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH V5 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 09:26:39 +0200
Message-ID: <20150317072639.GA2802@Darwish.PC>
References: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
 <20150316124621.14895.31220@shannon>
 <8CE1D0B9BFD2404DA079DDE1814A6F2E03294EFD39B3@esd-s3.esd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36943 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbCQH0o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 03:26:44 -0400
Received: by wixw10 with SMTP id w10so3258622wix.0
        for <linux-can@vger.kernel.org>; Tue, 17 Mar 2015 00:26:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8CE1D0B9BFD2404DA079DDE1814A6F2E03294EFD39B3@esd-s3.esd.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas =?iso-8859-1?Q?K=F6rper?= <Thomas.Koerper@esd.eu>
Cc: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Thomas,

On Tue, Mar 17, 2015 at 07:30:02AM +0100, Thomas K=F6rper wrote:
> Hi Andri,
>=20
> I've looked at the sources you mentioned, but I'm a little bit unsure=
 now /
> the handling seems not perfectly consistent to me. (flexcan calls
> can_change_state() with tx/rx_state of 0 in the bus off path.
>

There're discrpeancies indeed on the BUSOFF path:

1) flexcan calls can_change_state(dev, cf, 0, 0). kvaser and others
   do can_change_state(dev, cf, tx, rx) where either tx or rx =3D
   CAN_STATE_BUS_OFF. In this case, kvaser and the other drivers
   are the _correct_ behavior. This is validated by can-dev
   can_chage_state() code:

	if (unlikely(new_state =3D=3D CAN_STATE_BUS_OFF)) {
		cf->can_id |=3D CAN_ERR_BUSOFF;
		return;
	}

2) flexcan calls can_bus_off(dev), while kvaser goes a layer deeper
   and directly calls netif_carrier_off(netdev). In this case,
   flexcan is the more correct behavior.


Thanks,
Darwish
