From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 19 Nov 2015 09:38:17 +0100
Message-ID: <564D8A79.7090605@peak-system.com>
References: <20151118145121.32487.38169@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:55055 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758058AbbKSIrY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2015 03:47:24 -0500
In-Reply-To: <20151118145121.32487.38169@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de

Hi Andri,

Could you first give me the result of sudo lspci -d 1c: -vvv please?

Regards,

St=C3=A9phane

Le 18/11/2015 15:51, Andri Yngvason a =C3=A9crit :
> Hi all,
>
> We've been experiencing frame loss on transmission in the peak_pci ne=
tdev
> driver.
>
> The frames are not reported as "dumped" by the netlink interface.
>
> We are running CANopen and this manifests sporadically as nodes dropp=
ing off the
> network due to failure to answer node guarding RTR and as SDO request=
 timeouts.
>
> Example with can0 and can1 on the same bus where the CANopen master i=
s on can0
> and can1 is set up to listen only:
> (1446688151.783844)  can0  701  [1] remote request <- node guarding r=
equest on can0
> (1446688151.784296)  can0  70A  [1] remote request <- another node gu=
arding request
> (1446688151.784304)  can1  70A  [1] remote request <- only the latter=
 is seen by can1
> (1446688151.784751)  can0  720  [1] remote request
> (1446688151.784763)  can1  720  [1] remote request
> (1446688151.785793)  can1  283  [8] 00 00 00 00 00 00 00 00
> (1446688151.785792)  can0  283  [8] 00 00 00 00 00 00 00 00
> (1446688151.786164)  can0  70A  [1] 85 <-- node guarding response
> (1446688151.786163)  can1  70A  [1] 85
> (1446688151.786641)  can1  720  [1] 85
> (1446688151.786641)  can0  720  [1] 85 <-- node guarding response
> (1446688151.787057)  can0  721  [1] remote request
> (1446688151.787063)  can1  721  [1] remote request
> (1446688151.787728)  can0  721  [1] 05
> (1446688151.787733)  can1  721  [1] 05
>
> Node 1 never responded because it never received the request.
>
> The node guarding requests are sent in bursts where lower ids appear =
before
> higher ids. A curious observation is that it's always the lowest id t=
hat drops
> out first. I.e. the first frame in a burst of frames is the one that'=
s lost.
>
> Another interesting thing that we've found out is that if we turn off=
 SMP on the
> system, the problem disappears. But obviously we don't want to disabl=
e SMP in a
> production system. ;)
> It helps to set the cpy affinity of all threads and processes that to=
uch the CAN
> bus to a single core but sadly it doesn't eliminate the problem.
>
> Our systems are running on kernel version 3.14.3 with the rt patch. I=
 tried
> running 4.1.12-rt13 but that did not eliminate the problem. We also t=
ried
> running with the pcan netdev driver from peak which does in fact run =
without
> frame loss. Thus, this is probably an issue with either peak_pci or s=
ja1000.
>
> I tried poking around in sja1000.c. I noticed that sja1000_start_xmit=
() is not
> guarded against trying to transmit when the tx buffer is occupied, so=
 I added a
> check and a print-out:
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1=
000/sja1000.c
> index 32bd7f4..adc49db 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -292,6 +292,11 @@ static netdev_tx_t sja1000_start_xmit(struct sk_=
buff *skb,
>  =20
>          netif_stop_queue(dev);
>  =20
> +       if (!(priv->read_reg(priv, SJA1000_SR) & SR_TBS)) {
> +               netdev_err(dev, "BUG!, TX FIFO full when queue awake!=
\n");
> +               return NETDEV_TX_BUSY;
> +       }
> +
>          fi =3D dlc =3D cf->can_dlc;
>          id =3D cf->can_id;
>
> There was no error message in dmesg after frame loss, so that's not t=
he problem.
>
> The CPU is an Intel i7-4700EQ and the CAN interface is a Peak PCIe du=
al channel.
>
> Does anyone have an idea what might be wrong? :)
>
> Best regards,
> Andri

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
