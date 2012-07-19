From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Thu, 19 Jul 2012 12:14:08 +0200
Message-ID: <5007DDF0.6060505@pengutronix.de>
References: <4FFFE3AF.4020907@pengutronix.de> <1342192830-31538-1-git-send-email-iws@ovro.caltech.edu> <5005F0C5.7010109@pengutronix.de> <20120718174754.GA25905@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig77545CF2B8982F4876DDAACA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33190 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2GSKOM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 06:14:12 -0400
In-Reply-To: <20120718174754.GA25905@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77545CF2B8982F4876DDAACA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/18/2012 07:47 PM, Ira W. Snyder wrote:
> On Wed, Jul 18, 2012 at 01:09:57AM +0200, Marc Kleine-Budde wrote:
>> On 07/13/2012 05:20 PM, Ira W. Snyder wrote:
>>> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>>>
>>> The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
>>> notification or interrupt. The driver previously used the hardware
>>> loopback to attempt to work around this deficiency, but this caused a=
ll
>>> sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off=
=2E
>>>
>>> Using the new function ican3_cmp_echo_skb(), we can drop the loopback=

>>> messages and return the original skbs. This fixes the issues with
>>> CAN_RAW_RECV_OWN_MSGS.
>>>
>>> A private skb queue is used to store the echo skbs. This avoids the n=
eed
>>> for any index management.
>>>
>>> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
>>> ---
>>>
>>> This is a squashed together version of the first two patches in the s=
eries.
>>>
>>>  drivers/net/can/janz-ican3.c |  156 ++++++++++++++++++++++++++++++++=
+++-------
>>>  1 files changed, 130 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican=
3.c
>>> index 08c893c..5fff829 100644
>>> --- a/drivers/net/can/janz-ican3.c
>>> +++ b/drivers/net/can/janz-ican3.c
>>> @@ -220,6 +220,9 @@ struct ican3_dev {
>>>  	/* old and new style host interface */
>>>  	unsigned int iftype;
>>> =20
>>> +	/* queue for echo packets */
>>> +	struct sk_buff_head echoq;
>>> +
>>>  	/*
>>>  	 * Any function which changes the current DPM page must hold this
>>>  	 * lock while it is performing data accesses. This ensures that the=

>>> @@ -235,7 +238,6 @@ struct ican3_dev {
>>> =20
>>>  	/* fast host interface */
>>>  	unsigned int fastrx_start;
>>> -	unsigned int fastrx_int;
>>>  	unsigned int fastrx_num;
>>>  	unsigned int fasttx_start;
>>>  	unsigned int fasttx_num;
>>> @@ -454,7 +456,6 @@ static void __devinit ican3_init_fast_host_interf=
ace(struct ican3_dev *mod)
>>>  	/* save the start recv page */
>>>  	mod->fastrx_start =3D mod->free_page;
>>>  	mod->fastrx_num =3D 0;
>>> -	mod->fastrx_int =3D 0;
>>> =20
>>>  	/* build a single fast tohost queue descriptor */
>>>  	memset(&desc, 0, sizeof(desc));
>>> @@ -1091,6 +1092,87 @@ static void ican3_handle_message(struct ican3_=
dev *mod, struct ican3_msg *msg)
>>>  }
>>> =20
>>>  /*
>>> + * The ican3 needs to store all echo skbs, and therefore cannot
>>> + * use the generic infrastructure for this.
>>> + */
>>> +static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff=
 *skb)
>>> +{
>>> +	struct sock *srcsk =3D skb->sk;
>>> +
>>> +	if (atomic_read(&skb->users) !=3D 1) {
>>> +		struct sk_buff *old_skb =3D skb;
>>> +
>>> +		skb =3D skb_clone(old_skb, GFP_ATOMIC);
>>> +		kfree_skb(old_skb);
>>> +		if (!skb)
>>> +			return;
>>> +	} else
>>> +		skb_orphan(skb);
>>
>> Please use { } on else, too
>>
>=20
> Ok. FWIW, this is present in drivers/net/can/dev.c can_put_echo_skb().


>=20
>>> +
>>> +	skb->sk =3D srcsk;
>>> +
>>> +	/* save this skb for tx interrupt echo handling */
>>> +	skb_queue_tail(&mod->echoq, skb);
>>> +}
>>> +
>>> +static unsigned int ican3_get_echo_skb(struct ican3_dev *mod)
>>> +{
>>> +	struct sk_buff *skb =3D skb_dequeue(&mod->echoq);
>>> +	struct can_frame *cf;
>>> +	u8 dlc;
>>> +
>>> +	if (!skb)
>>> +		return 0;
>>> +
>>> +	/* check flag whether this packet has to be looped back */
>>> +	if (!(mod->ndev->flags & IFF_ECHO) || skb->pkt_type !=3D PACKET_LOO=
PBACK) {
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> Your flags have a IFF_ECHO, don't they?
>>
>=20
> I removed this check.
>=20
>>> +		kfree_skb(skb);
>>> +		return 0;
>>
>> please return here the dlc here, too.
>>
>=20
> Ok.
>=20
>>> +	}
>>> +
>>> +	/* make settings for echo to reduce code in irq context */
>>> +	skb->protocol =3D htons(ETH_P_CAN);
>>> +	skb->pkt_type =3D PACKET_BROADCAST;
>>> +	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>> +	skb->dev =3D mod->ndev;
>>> +
>>> +	cf =3D (struct can_frame *)skb->data;
>>> +	dlc =3D cf->can_dlc;
>>> +	netif_receive_skb(skb);
>>> +
>>> +	return dlc;
>>> +}
>>> +
>>> +/*
>>> + * Compare an skb with an existing echo skb
>>> + *
>>> + * This function will be used on devices which have a hardware loopb=
ack.
>>> + * On these devices, this function can be used to compare a received=
 skb
>>> + * with the saved echo skbs so that the hardware echo skb can be dro=
pped.
>>> + *
>>> + * Returns true if the skb's are identical, false otherwise.
>>> + */
>>> +static bool ican3_cmp_echo_skb(struct ican3_dev *mod, struct sk_buff=
 *skb)
>>> +{
>>> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
>>> +	struct sk_buff *echo_skb =3D skb_peek(&mod->echoq);
>>> +
>>> +	if (echo_skb) {
>>> +		struct can_frame *echo_cf =3D (struct can_frame *)echo_skb->data;
>>> +
>>> +		if (cf->can_id !=3D echo_cf->can_id)
>>> +			return false;
>>> +
>>> +		if (cf->can_dlc !=3D echo_cf->can_dlc)
>>> +			return false;
>>> +
>>> +		return memcmp(cf->data, echo_cf->data, cf->can_dlc) =3D=3D 0;
>>> +	}
>>
>> Please restructure like this (more common coding style):
>>
>> 	if (!echo_skb)
>> 		return false
>>
>> 	...
>=20
> Ok.
>=20
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>>   * Check that there is room in the TX ring to transmit another skb
>>>   *
>>>   * LOCKING: must hold mod->lock
>>> @@ -1100,6 +1182,10 @@ static bool ican3_txok(struct ican3_dev *mod)
>>>  	struct ican3_fast_desc __iomem *desc;
>>>  	u8 control;
>>> =20
>>> +	/* check that we have echo queue space */
>>> +	if (skb_queue_len(&mod->echoq) >=3D ICAN3_TX_BUFFERS)
>>> +		return false;
>>> +
>>>  	/* copy the control bits of the descriptor */
>>>  	ican3_set_page(mod, mod->fasttx_start + (mod->fasttx_num / 16));
>>>  	desc =3D mod->dpm + ((mod->fasttx_num % 16) * sizeof(*desc));
>>> @@ -1150,10 +1236,27 @@ static int ican3_recv_skb(struct ican3_dev *m=
od)
>>>  	/* convert the ICAN3 frame into Linux CAN format */
>>>  	ican3_to_can_frame(mod, &desc, cf);
>>> =20
>>> -	/* receive the skb, update statistics */
>>> -	netif_receive_skb(skb);
>>> +	/*
>>> +	 * If this is an ECHO frame received from the hardware loopback
>>> +	 * feature, use the skb saved in the ECHO stack instead. This allow=
s
>>> +	 * the Linux CAN core to support CAN_RAW_RECV_OWN_MSGS correctly.
>>> +	 *
>>> +	 * Since this is a confirmation of a successfully transmitted packe=
t
>>> +	 * sent from this host, update the transmit statistics.
>>> +	 *
>>> +	 * Also, the netdevice queue needs to be allowed to send packets ag=
ain.
>>> +	 */
>>> +	if (ican3_cmp_echo_skb(mod, skb)) {
>>> +		stats->tx_packets++;
>>> +		stats->tx_bytes +=3D ican3_get_echo_skb(mod);
>>> +		kfree_skb(skb);
>>> +		goto err_noalloc;
>>> +	}
>>> +
>>> +	/* update statistics, receive the skb */
>>>  	stats->rx_packets++;
>>>  	stats->rx_bytes +=3D cf->can_dlc;
>>> +	netif_receive_skb(skb);
>>> =20
>>>  err_noalloc:
>>>  	/* toggle the valid bit and return the descriptor to the ring */
>>> @@ -1176,13 +1279,13 @@ err_noalloc:
>>>  static int ican3_napi(struct napi_struct *napi, int budget)
>>>  {
>>>  	struct ican3_dev *mod =3D container_of(napi, struct ican3_dev, napi=
);
>>> -	struct ican3_msg msg;
>>>  	unsigned long flags;
>>>  	int received =3D 0;
>>>  	int ret;
>>> =20
>>>  	/* process all communication messages */
>>>  	while (true) {
>>> +		struct ican3_msg msg;
>>>  		ret =3D ican3_recv_msg(mod, &msg);
>>>  		if (ret)
>>>  			break;
>>> @@ -1199,11 +1302,6 @@ static int ican3_napi(struct napi_struct *napi=
, int budget)
>>>  		received++;
>>>  	}
>>> =20
>>> -	/* We have processed all packets that the adapter had, but it
>>> -	 * was less than our budget, stop polling */
>>> -	if (received < budget)
>>> -		napi_complete(napi);
>>> -
>>>  	spin_lock_irqsave(&mod->lock, flags);
>>> =20
>>>  	/* Wake up the transmit queue if necessary */
>>> @@ -1212,6 +1310,11 @@ static int ican3_napi(struct napi_struct *napi=
, int budget)
>>> =20
>>>  	spin_unlock_irqrestore(&mod->lock, flags);
>>> =20
>>> +	/* We have processed all packets that the adapter had, but it
>>> +	 * was less than our budget, stop polling */
>>
>> Nitpick: preferred multi line commenting style is:
>>
>> /*
>>  * comments...
>>  * ..more
>>  */
>=20
> Whoops. Fixed.
>=20
>>> +	if (received < budget)
>>> +		napi_complete(napi);
>>> +
>>
>> Why are you moving the napi_complete?
>>
>=20
> Should the TX queue be restarted before or after calling
> napi_complete()? Does it matter? I can leave the napi_complete() where
> it was if it doesn't matter.

It does matter.

In a scenario where you call tx queue start before napi_complete,
imagine the following:
- call tx_queue_start, but not napi_complete, yet
- network layer calls xmit, CAN frame gets transmitted
- irq because you received a frame
- call napi schedule from irq handler
- then you call napi_complete from napi handler

This results in napi is not scheduled.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig77545CF2B8982F4876DDAACA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAH3fAACgkQjTAFq1RaXHOmnwCbBClxOwnial5UZHbdb7t9+20b
AU8AoIRHZ0R5nKTqkEjCeiIka6NZPnak
=w7Bh
-----END PGP SIGNATURE-----

--------------enig77545CF2B8982F4876DDAACA--
