From: Richard Andrysek <richard.andrysek@gomtec.de>
Subject: AW: AW: AW: c_can driver sometimes sends first two bytes filled
 with zeros
Date: Fri, 20 May 2016 12:01:42 +0000
Message-ID: <0120733A154AE74CA608A286CE7FFD2621D9CCBA@rg-contact.RG.local>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <573A0E08.4010008@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9C80F@rg-contact.RG.local>
 <573C8BAA.5040200@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9CB60@rg-contact.RG.local>
 <573E459A.1000300@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from apollon.gomtec.de ([80.153.46.48]:51677 "EHLO post.gomtec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbcETMBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2016 08:01:45 -0400
In-Reply-To: <573E459A.1000300@opensource.altera.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "tthayer@opensource.altera.com" <tthayer@opensource.altera.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>

Thanks for informing maintainers. If needed we can Skype or phone or ..=
=2E=20

Gateway devices can0 and can1 send CAN messages. I have new logger "PCA=
N-USB-Pro"(I've tested also with a CANCaseXL) with two channels which o=
nly receives messages. One logger's channel is connected with can0 and =
one with can1. On one channel I do not see any failure (healthy channel=
), on the second one from time to time (bad channel).

The physical transmission of one CAN message on the bus takes 108+bit s=
tuffing time us =3D ~118us. As you can see in the c-code, in the while-=
loop, first are written 16 messages ("burst") into each peripherals (ca=
n0,can1) and after that it waits 2600us for a next cycle. The periphera=
l itself has message buffers (small extra RAM), in the Linux driver are=
 programmed 16 buffers for TX. So I can write 16 messages into buffers =
and then give enough time to be physically transmitted on the bus - 260=
0us (variable "delayTime_us".  =20

Real one cycle takes 2822 because:  "time of write calls" + "delayTime_=
us" =3D> it seems that "time of 32 write calls" is roughly ~222us.

One additional test: if I physically disconnect a "healthy channel", wh=
ich means physically it does not send any message, the "bad channel" st=
ill have a problem.

Q: What I see in the code that there is writing into peripheral in 16bi=
t steps, could it be related with that?
	File: "c_can.c"
	Function : c_can_setup_tx_object
	...=09
	for (i =3D 0; i < frame->can_dlc; i +=3D 2) {
		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
				frame->data[i] | (frame->data[i + 1] << 8));
	}=20
	...
   Q2: Is it safe to use u8 like this: "(frame->data[i + 1] << 8)"?
=20
Ch.

Richard

-----Urspr=FCngliche Nachricht-----
Von: Thor Thayer [mailto:tthayer@opensource.altera.com]=20
Gesendet: Freitag, 20. Mai 2016 01:01
An: Richard Andrysek <richard.andrysek@gomtec.de>; linux-can@vger.kerne=
l.org
Cc: wg@grandegger.com; mkl@pengutronix.de
Betreff: Re: AW: AW: c_can driver sometimes sends first two bytes fille=
d with zeros

Hi Richard,

On 05/19/2016 09:07 AM, Richard Andrysek wrote:
> Hi Thor,
>
> I am sending my test program and a makefile. The application accept u=
p to 2 arguments:
> ## send 8 messages in 2ms cycle
> # test  8 2000
>
> ## default 16 messages in 2.6ms (the zip file data) # test
>
> In the zip file you can see my logging files (channel 1 and channel=20
> 2), on the channel 2 you can find failures in the "Failure_dump.txt".
>
Yes, I can see the zero bytes in your data.

Am I correct that both can0 and can1 are receiving the same data? If I'=
m understanding, can0 seems to be fine but can1 periodically shows corr=
uption with the first 2 bytes set to 0?

Since the attached program uses a write, I'm confused about who is send=
ing the data? Is that the PCAN USB you referred to in an earlier email?

Also, where is the 2.6ms that you refer to and is in the code? From the=
 data, it seems like the spacing between frames is ~.120ms and ~1msec b=
etween 16 frame bursts.

> Initialization of can channels is done from the shell:
>
> # ip link set can0 up type can bitrate 1000000 # ip link set can1 up=20
> type can bitrate 1000000
>
> The cpu load is max 5%.
>
> Question1:
> I've checked a driver it looks good. Except one line in the function =
:
>
> static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
> 				    struct net_device *dev)
> {
> 	struct can_frame *frame =3D (struct can_frame *)skb->data;
> 	struct c_can_priv *priv =3D netdev_priv(dev);
> 	u32 idx, obj;
>
> 	if (can_dropped_invalid_skb(dev, skb))
> 		return NETDEV_TX_OK;
> 	/*
> 	 * This is not a FIFO. C/D_CAN sends out the buffers
> 	 * prioritized. The lowest buffer number wins.
> 	 */
> 	idx =3D fls(atomic_read(&priv->tx_active));  /*!!!!! Why so !!!! */
> 	...
> 	...
> 	/* Update the active bits */
> 	atomic_add((1 << idx), &priv->tx_active);
>
> Are these atomic operations correct? atomic_add I understand, but sha=
ll not be atomic_read used like this:
>
>               Atomic block start
>               idx =3D fls(read(&priv->tx->active))
>               remove_idx_from(&priv->tx->active, idx)
>               Atomic block stop=09
>
I'm not sure about this. I'm including the maintainers in the CC.

> Question2: What can make corrupted CAN messages on the channel 2?
>
Hmm. I've only worked with the first CAN so I can't speak for the 2nd c=
an device.

> Ch.
>
> Richard
>
>
