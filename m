From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 24/29] can: ti_hecc: add fifo underflow error reporting
Date: Thu, 10 Oct 2019 22:29:12 +0200
Message-ID: <0c58e9a7-4cb8-dc75-14b8-9b33290916da@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
 <20191010121750.27237-25-mkl@pengutronix.de>
 <dfdbefb3-48c4-0830-9627-146da062a01a@pengutronix.de>
 <694ef4e8-166b-7eeb-4d6e-39a0ecacc93f@victronenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="peiOrQAva8kwdDkS179PcizzSElKs5aYS"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <694ef4e8-166b-7eeb-4d6e-39a0ecacc93f@victronenergy.com>
Sender: netdev-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-can <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, "davem@davemloft.net" <davem@davemloft.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--peiOrQAva8kwdDkS179PcizzSElKs5aYS
Content-Type: multipart/mixed; boundary="UWw7XaTsCkn5srHEdZoUGzuAL6HSnmXvZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jeroen Hofstee <jhofstee@victronenergy.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-can <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Message-ID: <0c58e9a7-4cb8-dc75-14b8-9b33290916da@pengutronix.de>
Subject: Re: [PATCH 24/29] can: ti_hecc: add fifo underflow error reporting
References: <20191010121750.27237-1-mkl@pengutronix.de>
 <20191010121750.27237-25-mkl@pengutronix.de>
 <dfdbefb3-48c4-0830-9627-146da062a01a@pengutronix.de>
 <694ef4e8-166b-7eeb-4d6e-39a0ecacc93f@victronenergy.com>
In-Reply-To: <694ef4e8-166b-7eeb-4d6e-39a0ecacc93f@victronenergy.com>

--UWw7XaTsCkn5srHEdZoUGzuAL6HSnmXvZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/10/19 7:51 PM, Jeroen Hofstee wrote:
>>> When the rx fifo overflows the ti_hecc would silently drop them since=

>>> the overwrite protection is enabled for all mailboxes. So disable it
>>> for the lowest priority mailbox and increment the rx_fifo_errors when=

>>> receive message lost is set. Drop the message itself in that case,
>>> since it might be partially updated.
>> Is that your observation or does the data sheet say anything to this
>> situation?
>=20
> I couldn't find in the data sheet, so I simply tested it, by allowing
> the highest mailbox to be overwritten and send a stream alternating
> with messages will all bits set and all cleared. That does end with
> canids from one message combined with data from another.

I see. This is why the register is called overwrite _protection_ control.=


>>> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>  drivers/net/can/ti_hecc.c | 21 +++++++++++++++++----
>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
>>> index 6ea29126c60b..c2d83ada203a 100644
>>> --- a/drivers/net/can/ti_hecc.c
>>> +++ b/drivers/net/can/ti_hecc.c
>>> @@ -82,7 +82,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
>>>  #define HECC_CANTA		0x10	/* Transmission acknowledge */
>>>  #define HECC_CANAA		0x14	/* Abort acknowledge */
>>>  #define HECC_CANRMP		0x18	/* Receive message pending */
>>> -#define HECC_CANRML		0x1C	/* Remote message lost */
>>> +#define HECC_CANRML		0x1C	/* Receive message lost */
>>>  #define HECC_CANRFP		0x20	/* Remote frame pending */
>>>  #define HECC_CANGAM		0x24	/* SECC only:Global acceptance mask */
>>>  #define HECC_CANMC		0x28	/* Master control */
>>> @@ -385,8 +385,17 @@ static void ti_hecc_start(struct net_device *nde=
v)
>>>  	/* Enable tx interrupts */
>>>  	hecc_set_bit(priv, HECC_CANMIM, BIT(HECC_MAX_TX_MBOX) - 1);
>>> =20
>>> -	/* Prevent message over-write & Enable interrupts */
>>> -	hecc_write(priv, HECC_CANOPC, HECC_SET_REG);
>>> +	/* Prevent message over-write to create a rx fifo, but not for
>>> +	 * the lowest priority mailbox, since that allows detecting
>>> +	 * overflows instead of the hardware silently dropping the
>>> +	 * messages. The lowest rx mailbox is one above the tx ones,
>>> +	 * hence its mbxno is the number of tx mailboxes.
>>> +	 */
>>> +	mbxno =3D HECC_MAX_TX_MBOX;
>>> +	mbx_mask =3D ~BIT(mbxno);
>>> +	hecc_write(priv, HECC_CANOPC, mbx_mask);
>>> +
>>> +	/* Enable interrupts */
>>>  	if (priv->use_hecc1int) {
>>>  		hecc_write(priv, HECC_CANMIL, HECC_SET_REG);
>>>  		hecc_write(priv, HECC_CANGIM, HECC_CANGIM_DEF_MASK |
>>> @@ -531,6 +540,7 @@ static unsigned int ti_hecc_mailbox_read(struct c=
an_rx_offload *offload,
>>>  {
>>>  	struct ti_hecc_priv *priv =3D rx_offload_to_priv(offload);
>>>  	u32 data, mbx_mask;
>>> +	int lost;
>>> =20
>>>  	mbx_mask =3D BIT(mbxno);
>>>  	data =3D hecc_read_mbx(priv, mbxno, HECC_CANMID);
>>> @@ -552,9 +562,12 @@ static unsigned int ti_hecc_mailbox_read(struct =
can_rx_offload *offload,
>>>  	}
>>> =20
>>>  	*timestamp =3D hecc_read_stamp(priv, mbxno);
>>> +	lost =3D hecc_read(priv, HECC_CANRML) & mbx_mask;
>>> +	if (unlikely(lost))
>>> +		priv->offload.dev->stats.rx_fifo_errors++;
>> In the flexcan and at91_can driver we're incrementing the following er=
rors:
>> 			dev->stats.rx_over_errors++;
>> 			dev->stats.rx_errors++;
>=20
> I understood it as follows, see[1] e.g.:
>
> rx_errors -> link level errors, not really applicable to CAN
> (perhaps in single shot mode or if you want)

I increment this for CRC, bit stuffing and all the other bus errors. As
well as on HW FIFO overflows.

> rx_over_errors -> the hardware itself cannot keep up.
> Not applicable for CAN.

If the HW FIFO overflows for whatever reason, I increment this.

> rx_fifo_errors -> the software driver cannot keep up.
> So I picked that one.

If the rx-offload queue reaches it's limit I increment this.

> rx_dropped -> software is dropping on purpose based on limits etc.
>=20
> But I might be wrong.

rx-offload used this if the skb cannot be allocated.

Basically the kernel doc gives a general description of these values but
says: look at the driver for exact meaning :)

I wanted to keep it similar with the CAN drivers.

>> You can save the register access if you only check for overflows if
>> reading from the lowest prio mailbox.
>>
>> If you're discarding the data if the mailbox is marked as overflow
>> there's no need to read the data in the first place.
>>
>=20
> Mind it that you don't cause a race! The bit can become set
> during reading of the data, it should be check _after_ we
> have a copy of the mailbox.

Right. My understanding of the bit was wrong.

In the flexcan HW there is a similar bit. It says there was an overflow
in this mailbox. But a coherence mechanism guarantees that the mailbox
is not changed by the CAN core, while the ARM accesses it.

> You can do a double check, one
> before one after, but since there should be no fifo overflow
> anyway, there is no reason to optimize for that path. (@250k
> I cannot get more then 3 messages in the fifo...).
Thanks for the explanations,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UWw7XaTsCkn5srHEdZoUGzuAL6HSnmXvZ--

--peiOrQAva8kwdDkS179PcizzSElKs5aYS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2flJgACgkQWsYho5Hk
nSATiwf7B4n2aQwOaGGAmvyo0oepF77hTYtWMbhXScg5GPcLICNSsCtrkW4EYUy0
CxSh0F0pPCkBd6EvDWqLAdLmJ2ZrA5juNKP2bkKklNZtDyQ5i26wyS4XtS+vush1
oS1tMRvH8DQsKO5BTPeakI/2Ysq5+X0RRazxudJuXOyA/rciM9zcKJzzXIQPgkyT
7OhX2JhJ029Qxdn9qPjLB9I835I1Cfl+B0hu3x/FiCWkMSpCeauWGaat8j/rEb71
L2CHs5e7En1dxm/m7GuHFe+qNIf977eNtzMAiDF3pXyQ46T/i9Mk7rr0ix+73La5
BI6Rx2E2gpc58r2n4dJVEvKdWW0p2g==
=6/qO
-----END PGP SIGNATURE-----

--peiOrQAva8kwdDkS179PcizzSElKs5aYS--
