From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: AW: AW: AW: c_can driver sometimes sends first two bytes filled
 with zeros
Date: Mon, 23 May 2016 09:22:24 -0500
Message-ID: <57431220.3060501@opensource.altera.com>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <573A0E08.4010008@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9C80F@rg-contact.RG.local>
 <573C8BAA.5040200@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9CB60@rg-contact.RG.local>
 <573E459A.1000300@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9CCBA@rg-contact.RG.local>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0067.outbound.protection.outlook.com ([65.55.169.67]:10336
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750900AbcEWOch (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 23 May 2016 10:32:37 -0400
In-Reply-To: <0120733A154AE74CA608A286CE7FFD2621D9CCBA@rg-contact.RG.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@gomtec.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>

Thanks for the explanation of your setup.

On 05/20/2016 07:01 AM, Richard Andrysek wrote:
> Thanks for informing maintainers. If needed we can Skype or phone or =
=2E..
>
> Gateway devices can0 and can1 send CAN messages. I have new logger "P=
CAN-USB-Pro"(I've tested also with a CANCaseXL) with two channels which=
 only receives messages. One logger's channel is connected with can0 an=
d one with can1. On one channel I do not see any failure (healthy chann=
el), on the second one from time to time (bad channel).
>
> The physical transmission of one CAN message on the bus takes 108+bit=
 stuffing time us =3D ~118us. As you can see in the c-code, in the whil=
e-loop, first are written 16 messages ("burst") into each peripherals (=
can0,can1) and after that it waits 2600us for a next cycle. The periphe=
ral itself has message buffers (small extra RAM), in the Linux driver a=
re programmed 16 buffers for TX. So I can write 16 messages into buffer=
s and then give enough time to be physically transmitted on the bus - 2=
600us (variable "delayTime_us".
>
> Real one cycle takes 2822 because:  "time of write calls" + "delayTim=
e_us" =3D> it seems that "time of 32 write calls" is roughly ~222us.
>
> One additional test: if I physically disconnect a "healthy channel", =
which means physically it does not send any message, the "bad channel" =
still have a problem.
>
That is interesting.

> Q: What I see in the code that there is writing into peripheral in 16=
bit steps, could it be related with that?
> 	File: "c_can.c"
> 	Function : c_can_setup_tx_object
> 	...=09
> 	for (i =3D 0; i < frame->can_dlc; i +=3D 2) {
> 		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
> 				frame->data[i] | (frame->data[i + 1] << 8));
> 	}
> 	...
>     Q2: Is it safe to use u8 like this: "(frame->data[i + 1] << 8)"?
>
Good point. According to the C spec, if an int can represent all values=
=20
of the original type, the value is converted to an int.

> Ch.
>
> Richard
>
> -----Urspr=FCngliche Nachricht-----
> Von: Thor Thayer [mailto:tthayer@opensource.altera.com]
> Gesendet: Freitag, 20. Mai 2016 01:01
> An: Richard Andrysek <richard.andrysek@gomtec.de>; linux-can@vger.ker=
nel.org
> Cc: wg@grandegger.com; mkl@pengutronix.de
> Betreff: Re: AW: AW: c_can driver sometimes sends first two bytes fil=
led with zeros
>
> Hi Richard,
>
> On 05/19/2016 09:07 AM, Richard Andrysek wrote:
>> Hi Thor,
>>
>> I am sending my test program and a makefile. The application accept =
up to 2 arguments:
>> ## send 8 messages in 2ms cycle
>> # test  8 2000
>>
>> ## default 16 messages in 2.6ms (the zip file data) # test
>>
>> In the zip file you can see my logging files (channel 1 and channel
>> 2), on the channel 2 you can find failures in the "Failure_dump.txt"=
=2E
>>
> Yes, I can see the zero bytes in your data.
>
> Am I correct that both can0 and can1 are receiving the same data? If =
I'm understanding, can0 seems to be fine but can1 periodically shows co=
rruption with the first 2 bytes set to 0?
>
> Since the attached program uses a write, I'm confused about who is se=
nding the data? Is that the PCAN USB you referred to in an earlier emai=
l?
>
> Also, where is the 2.6ms that you refer to and is in the code? From t=
he data, it seems like the spacing between frames is ~.120ms and ~1msec=
 between 16 frame bursts.
>
>> Initialization of can channels is done from the shell:
>>
>> # ip link set can0 up type can bitrate 1000000 # ip link set can1 up
>> type can bitrate 1000000
>>
>> The cpu load is max 5%.
>>
>> Question1:
>> I've checked a driver it looks good. Except one line in the function=
 :
>>
>> static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>> 				    struct net_device *dev)
>> {
>> 	struct can_frame *frame =3D (struct can_frame *)skb->data;
>> 	struct c_can_priv *priv =3D netdev_priv(dev);
>> 	u32 idx, obj;
>>
>> 	if (can_dropped_invalid_skb(dev, skb))
>> 		return NETDEV_TX_OK;
>> 	/*
>> 	 * This is not a FIFO. C/D_CAN sends out the buffers
>> 	 * prioritized. The lowest buffer number wins.
>> 	 */
>> 	idx =3D fls(atomic_read(&priv->tx_active));  /*!!!!! Why so !!!! */
>> 	...
>> 	...
>> 	/* Update the active bits */
>> 	atomic_add((1 << idx), &priv->tx_active);
>>
>> Are these atomic operations correct? atomic_add I understand, but sh=
all not be atomic_read used like this:
>>
>>                Atomic block start
>>                idx =3D fls(read(&priv->tx->active))
>>                remove_idx_from(&priv->tx->active, idx)
>>                Atomic block stop=09
>>
> I'm not sure about this. I'm including the maintainers in the CC.
>
>> Question2: What can make corrupted CAN messages on the channel 2?
>>
> Hmm. I've only worked with the first CAN so I can't speak for the 2nd=
 can device.
>
>> Ch.
>>
>> Richard
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
