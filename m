From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH] can: xilinx_can: use can_change_state()
Date: Mon, 29 Jan 2018 17:50:06 +0000
Message-ID: <151724820628.13021.14620062197722880179@maxwell>
References: <151722269077.27204.8452699005718607415@maxwell>
 <20180129164953.6596-1-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:7025
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751438AbeA2RuN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 29 Jan 2018 12:50:13 -0500
In-Reply-To: <20180129164953.6596-1-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>

Hi Anssi

I wasn't sure you knew about can_change_state(). I didn't mean to say that =
you
_should_ use it, just that you could.

Quoting Anssi Hannula (2018-01-29 16:49:53)
> Replace some custom code with a call to can_change_state().
> =

> This subtly changes the error reporting behavior in some cases.
> =

> Previously, if both RX and TX error counters indicated the same state,
> and the status register agreed:
> - if overall state is PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE
> - if overall state is WARNING, report CAN_ERR_CRTL_TX_WARNING or
>   CAN_ERR_CRTL_RX_WARNING depending on which counter is higher.
If you look at sja1000.c, you'll see that it does this:
tx_state =3D txerr >=3D rxerr ? state : 0
rx_state =3D txerr <=3D rxerr ? state : 0;
can_change_state(dev, cf, tx_state, rx_state);

Maybe something similar could work for this?
> =

> Previously, if status registers indicated a different state than the
> worst state indicated by the RX/TX error counters (I have not observed
> this to happen, though):
> - if status register says PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE if
>   RX error counter indicates PASSIVE as well, otherwise report
>   CAN_ERR_CRTL_TX_PASSIVE
> - if status register says WARNING, report CAN_ERR_CRTL_TX_WARNING
>   or CAN_ERR_CRTL_RX_WARNING depending on which counter is higher.
> =

> After this commit, in both of the above scenarios:
> - if overall state is PASSIVE, report
>   CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE
> - if overall state is WARNING, report
>   CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING.
> =

> Tested with the integrated CAN on Zynq-7000 SoC.
> =


Anyway, the use of this API function is a somewhat superfluous issue, so I =
think
we shouldn't worry too much about it.

Best regards,
Andri
