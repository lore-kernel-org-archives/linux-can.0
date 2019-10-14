From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH] can: m_can: add support for one shot mode
Date: Mon, 14 Oct 2019 17:00:40 +0530
Message-ID: <001b01d58282$d0a03fa0$71e0bee0$@samsung.com>
References: <CGME20190925114609epcas5p305e259619c7fe8cdc75d9fd27f34e758@epcas5p3.samsung.com>
        <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>
        <79c10dd5-0c44-ce70-9cb9-bb61e12362d4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <79c10dd5-0c44-ce70-9cb9-bb61e12362d4@pengutronix.de>
Content-Language: en-us
Sender: netdev-owner@vger.kernel.org
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, 'Sriram Dash' <sriram.dash@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

> From: Marc Kleine-Budde <mkl=40pengutronix.de>
> Subject: Re: =5BPATCH=5D can: m_can: add support for one shot mode
>=20
> On 9/25/19 1:45 PM, Pankaj Sharma wrote:
> > According to the CAN Specification (see ISO 11898-1:2015, 8.3.4
> > Recovery Management), the M_CAN provides means for automatic
> > retransmission of frames that have lost arbitration or that have been
> > disturbed by errors during transmission. By default automatic
> > retransmission is enabled.
> >
> > The Bosch MCAN controller has support for disabling automatic
> > retransmission.
> >
> > To support time-triggered communication as described in ISO
> > 11898-1:2015, chapter 9.2, the automatic retransmission may be
> > disabled via CCCR.DAR.
> >
> > CAN_CTRLMODE_ONE_SHOT is used for disabling automatic retransmission.
> >
> > Signed-off-by: Pankaj Sharma <pankj.sharma=40samsung.com>
> > Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
>=20
> The patch does not apply to net-next/master. Please use net-next/master a=
s a
> base for patches introducing new features.
>=20

Thank you for the information.

> I've ported the patch and applied it.
>=20

We are not able to get the patch in the net-next/master branch.
Sent patch v2 after rebasing to net-next/master
https://lore.kernel.org/patchwork/patch/1139214/

> tnx,
> Marc
>=20
> --
> Pengutronix e.K.                  =7C Marc Kleine-Budde           =7C
> Industrial Linux Solutions        =7C Phone: +49-231-2826-924     =7C
> Vertretung West/Dortmund          =7C Fax:   +49-5121-206917-5555 =7C
> Amtsgericht Hildesheim, HRA 2686  =7C http://www.pengutronix.de   =7C
