From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/5] can: xilinx_can: only report warning and passive
 states on state changes
Date: Mon, 29 Jan 2018 11:02:34 +0100
Message-ID: <89673f1a-32f7-71d5-6636-1dc59e3e2038@pengutronix.de>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
 <20180126142723.3212-5-anssi.hannula@bitwise.fi>
 <87c7662b-0a49-cf90-10cc-b7aaee44a543@pengutronix.de>
 <b2ae0a20-984c-956b-072b-64921719e41d@bitwise.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2FhKjVsvsVz2ALPZMffnrAYeZkNEJwhq7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56011 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeA2KDK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Jan 2018 05:03:10 -0500
In-Reply-To: <b2ae0a20-984c-956b-072b-64921719e41d@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2FhKjVsvsVz2ALPZMffnrAYeZkNEJwhq7
Content-Type: multipart/mixed; boundary="3tr6vAJ42n10EwecBqANgN923VVpt1ZST";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>
Message-ID: <89673f1a-32f7-71d5-6636-1dc59e3e2038@pengutronix.de>
Subject: Re: [PATCH 4/5] can: xilinx_can: only report warning and passive
 states on state changes
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
 <20180126142723.3212-5-anssi.hannula@bitwise.fi>
 <87c7662b-0a49-cf90-10cc-b7aaee44a543@pengutronix.de>
 <b2ae0a20-984c-956b-072b-64921719e41d@bitwise.fi>
In-Reply-To: <b2ae0a20-984c-956b-072b-64921719e41d@bitwise.fi>

--3tr6vAJ42n10EwecBqANgN923VVpt1ZST
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/29/2018 10:45 AM, Anssi Hannula wrote:
> On 29.1.2018 10:35, Marc Kleine-Budde wrote:
>> On 01/26/2018 03:27 PM, Anssi Hannula wrote:
>>> The xilinx_can driver currently increments error-warning and
>>> error-passive statistics on every error interrupt regardless of wheth=
er
>>> the interface was already in the same state. Similarly, the error fra=
me
>>> sent on error interrupts is always sent with
>>> CAN_ERR_CRTL_(RX|TX)_(PASSIVE|WARNING) bit set.
>>>
>>> To make the error-warning and error-passive statistics more useful, a=
dd
>>> a check to only set the error state when the state has actually been
>>> changed.
>>>
>>> Tested with the integrated CAN on Zynq-7000 SoC.
>>>
>>> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
>>> ---
>>>  drivers/net/can/xilinx_can.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_ca=
n.c
>>> index 763408a..862c12bb 100644
>>> --- a/drivers/net/can/xilinx_can.c
>>> +++ b/drivers/net/can/xilinx_can.c
>>> @@ -680,7 +680,8 @@ static void xcan_err_interrupt(struct net_device =
*ndev, u32 isr)
>>>  	} else {
>>>  		enum can_state new_state =3D xcan_current_error_state(ndev);
>>> =20
>>> -		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
>>> +		if (new_state !=3D priv->can.state)
>>> +			xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
>>>  	}
>> Are you changing a piece of code, that you've introduced in patch 3? I=
f
>> so, I'm going to squash these two patches together.
>=20
> Yes, patch 3 keeps the state change reporting behavior (always vs. on
> state change) like it was before, only introducing reporting recovery
> from error states.

OK I see - then better leave it as two separate patches.

> But I'm OK with squashing, as long as the commit message is updated to
> say it changes that behavior, too.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3tr6vAJ42n10EwecBqANgN923VVpt1ZST--

--2FhKjVsvsVz2ALPZMffnrAYeZkNEJwhq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlpu8ToACgkQk9IU1zQo
ZfE5Rgf9HQsyIK+3pbt5mes2VjX7prLN5ofpLtFf+Dv15EnfGK17Cukz8TPToj+i
2huEg9THvzkKaod6oOg3Z1uZrNVx8BJRvXCAxYUXQXsL493l7tJZP/7rNUguFB01
fNOZOO+AAhTJ/hpSrfIqkBBz7yXSFmZNfkObx7DQgCHYDpPJ66RUw+r7UIYQ5rcu
CuzHUbECkqQjKAE8Tse5vSmEaxnDzPu8PoCEUIxu+14RKx/sJ4J6OqjCz3Ai4lyq
vKnKtgQvGlUnOFjA1ygjdMAnpXfLFTS30MZuCapMBsCW07psMAf/xHEVmS7AEr7d
dXJydeGIUA6aWpHv8lbHqYjkbiFEdQ==
=2R8l
-----END PGP SIGNATURE-----

--2FhKjVsvsVz2ALPZMffnrAYeZkNEJwhq7--
