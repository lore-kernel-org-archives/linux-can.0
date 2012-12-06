From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Thu, 06 Dec 2012 15:31:20 +0100
Message-ID: <50C0AC38.8080405@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com> <4036287.fuKZ6k5idx@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47099 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423543Ab2LFObY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 09:31:24 -0500
In-Reply-To: <4036287.fuKZ6k5idx@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 12/06/2012 02:38 PM, Alexander Stein wrote:
> Hello Wolfgang,
>=20
> On Wednesday 05 December 2012 18:35:25, Wolfgang Grandegger wrote:
>>>> - The messages look still ok (not currupted, I mean)?
>>>
>>> The received frames all look good (despite wrong counter sometimes =
due to=20
>>> wrong order or lost frames).
>>>
>>>>> Even worse, if I use the following patch to check if PCI writes w=
ere=20
>>>>> successfully, I notices that some writes (or the consecutive read=
) don't=20
>>>>> succeed. And I also get lots of I2C timeouts waiting for a xfer c=
omplete.
>>>>
>>>> Be careful, there might be some registers changing their values af=
ter
>>>> writing. Can you show the value read after writing and the registe=
r
>>>> offset? The influence on the I2C bus looks more like an overload o=
r
>>>> hardware problem. What is your CAN interrupt rate?
>>>
>>> I get about 33 interrupts per second on i2c. On a successful run I =
get 366886=20
>>> interrupts for 500000 messages with the c_can driver.
>>
>> In what time? Is the CAN bus highly loaded.
>=20
> Busload is about 14-18% according to canbusload with 1MBit. A complet=
e sucessful run takes about 5 minutes.
>=20
>>> On the second line you can see that the register isn't written at a=
ll (or the=20
>>> read failed for some reason).
>>
>> I assume the latter. Could you please retry reading the register unt=
il
>> the correct value shows up. With some timeout, of course.
>=20
> I notices having all error events printed on serial console using pch=
_uart driver has negative effect (I guess one problem causes another on=
e), so I setup 'dmesg -n1' to reduce serial load before the test.
> Running the test with just one heartbeat triggered LED set using I2C =
the test runs without errors. I only see
> Lots of 'c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c faile=
d. got: 0x2000' at the beginning. It seems this (reserved?) bit is alwa=
ys 1 no matter what we write.

There are reserved bit! From the manual:

 "Reserved: This bit is reserved for future expansion. Only =930=94 is
  accepted as the write data to the reserved bit. When =931=94 is
  written, the operation is not guaranteed."

  When reading the reserved bit of the IFmMASK2 register (m =3D 1), a =93=
1=94
  is read. Write a =931=94 for write.

Well, I don't fully understand but it's clear that we always read "1!.

> But things start to break when running the test while running 'watch =
sensors' (sensors queries several temperature sensors via I2C) in a sec=
onds ssh session.
> First off the driver error messages (omitting the messages as written=
 above):
> [  384.466217] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x2=
4 failed. got: 0xbc


Hm...

> [  384.466630] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x2=
4 failed. got: 0xb8
=2E..
> [  700.646608] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 =
failed. got: 0x28
> [  700.647000] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 =
failed. got: 0x88
>=20
> As you can see, sometimes it needs several write retries to succeed. =
Nevertheless my test application detects also some problems:

OK, obviously the real value needs some time to show up when there is
other activity on the bus. This hardware is really special. We need to
contact the hardware developers.

>> Error on MSG ID 0x252. Got counter 96480 and expected 96466
>> Error on MSG ID 0x251. Got counter 96480 and expected 96466
>> Error on MSG ID 0x252. Got counter 101706 and expected 101696
>> Error on MSG ID 0x251. Got counter 101706 and expected 101696
> Here were messages missed/dropped for both CAN-IDs.

It is interesting that the same number of messages are missing for both
IDs... which come from different CAN nodes, right?

Do you see dropped messages with "ip -d -s link show canX"?
Did you check if the protocol layer did drop messages. You can
use "candump -d" to find that out.

>> Error on MSG ID 0x251. Got counter 108673 and expected 108672
>> Error on MSG ID 0x251. Got counter 108672 and expected 108674
>> Error on MSG ID 0x251. Got counter 108674 and expected 108673
>                                      ^^^^^^
> Here you can see the CAN frame with counter 108673 is read before 108=
672.

You could add some offset/mask to the counter data of MSG ID 0x252 to
see if they get mixed up.

>> Error on MSG ID 0x251. Got counter 117488 and expected 117487
>> Error on MSG ID 0x251. Got counter 117487 and expected 117489
>> Error on MSG ID 0x251. Got counter 117489 and expected 117488
>                                      ^^^^^^
> Here you can see the CAN frame with counter 117488 is read before 117=
487.
>> Error on MSG ID 0x251. Got counter 142297 and expected 142296
>> Error on MSG ID 0x251. Got counter 142296 and expected 142298
>> Error on MSG ID 0x251. Got counter 142298 and expected 142297
> Same again.
>> Error on MSG ID 0x251. Got counter 147932 and expected 147924
>> Error on MSG ID 0x251. Got counter 147936 and expected 147933
>> Error on MSG ID 0x252. Got counter 147936 and expected 147924
>> Error on MSG ID 0x251. Got counter 165268 and expected 165267
>> Error on MSG ID 0x251. Got counter 218560 and expected 218558
>> Error on MSG ID 0x252. Got counter 218560 and expected 218558
>> Error on MSG ID 0x252. Got counter 231076 and expected 231075
>> Error on MSG ID 0x251. Got counter 231077 and expected 231076
>> Error on MSG ID 0x251. Got counter 241959 and expected 241958
> Messages missed/dropped again.
>=20
> Below is the patch for c_can.
>=20
> Best regards,
> Alexander
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_=
can.c
> index d63aaa3..da9bbc0 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -1186,6 +1186,7 @@ struct net_device *alloc_c_can_dev(void)
>                                         CAN_CTRLMODE_BERR_REPORTING;
> =20
>         spin_lock_init(&priv->lock);
> +       spin_lock_init(&priv->testlock);
> =20
>         return dev;
>  }
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_=
can.h
> index 3487d5e..2b58b75 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -173,6 +173,7 @@ struct c_can_priv {
>         unsigned int instance;
>         void (*init) (const struct c_can_priv *priv, bool enable);
>         spinlock_t lock;        /* to protect tx and rx message objec=
ts */
> +       spinlock_t testlock;    /* to protect tx and rx message objec=
ts */
>  };
> =20
>  struct net_device *alloc_c_can_dev(void);
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_ca=
n/c_can_pci.c
> index 2516ea9..0ac4d43 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -74,13 +74,37 @@ static void c_can_pci_write_reg_aligned_to_32bit(=
struct c_can_priv *priv,
>  static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
>                                     enum reg index)
>  {
> -       return (u16)ioread32(priv->base + 2 * priv->regs[index]);
> +       unsigned long flags;
> +       u16 reg;
> +
> +       spin_lock_irqsave(&priv->testlock, flags);
> +       reg =3D (u16)ioread32(priv->base + 2 * priv->regs[index]);
> +       spin_unlock_irqrestore(&priv->testlock, flags);
> +
> +       return reg;
>  }
> =20
>  static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
>                                       enum reg index, u16 val)
>  {
> -       iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
> +       u16 reg;
> +       unsigned long flags;
> +       int retries;
> +
> +       retries =3D 0;
> +
> +       spin_lock_irqsave(&priv->testlock, flags);
> +
> +       do
> +       {
> +               iowrite32((u32)val, priv->base + 2 * priv->regs[index=
]);

I think it's enough to write the message once.

> +               reg =3D (u16)ioread32(priv->base + 2 * priv->regs[ind=
ex]);
> +               if (reg !=3D val)
> +               {
> +                       netdev_err(priv->dev, "write 0x%x to offset 0=
x%x failed. got: 0x%x\n", val, 2 * priv->regs[index], reg);
> +               }
> +       } while ((reg !=3D val) && (retries++ < 20));
> +       spin_unlock_irqrestore(&priv->testlock, flags);
>  }
> =20
>  static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool =
enable)

Wolfgang.

