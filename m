From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Fri, 10 Oct 2014 09:43:49 +0200
Message-ID: <54378E35.6000205@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de> <5436A482.4040001@ep1.ruhr-uni-bochum.de> <5436B443.10606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mi.ruhr-uni-bochum.de ([134.147.64.30]:44646 "HELO
	mx6.rz.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750905AbaJJHnx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 03:43:53 -0400
In-Reply-To: <5436B443.10606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hey,

On 10/09/2014 06:13 PM, Marc Kleine-Budde wrote:
> Hello Florian,
>
> please don't top-post.
>
> On 10/09/2014 05:06 PM, Florian Feldbauer wrote:
>> I now checked everything with a mixed signal scope and
>> one thing came to my eye:
>>
>> After loading the module, I get the error:
>> [   16.806860] sja1000_raspi sja1000_raspi.0: registering sja1000_ra=
spi
>> device (reg_base=3D0xf2200000, irq=3D174)
>> [   16.836560] sja1000_raspi sja1000_raspi.0 (unregistered net_devic=
e):
>> setting SJA1000 into reset mode failed!
>> [   16.871684] sja1000_raspi sja1000_raspi.0: sja1000_raspi device
>> registered (reg_base=3D0xf2200000, irq=3D174)
>>
>> Although I can see at the scope, that reading register 0 of the SJA1=
000
>> returns the value 1 as it should be.
>> Also, it seems that there is some kind of endless loop reading this
>> register.
> No, just a loop of up to 100 :)
Maybe it's correlated with the issue that the message
[  129.210423] sja1000_raspi sja1000_raspi.0 can0: bit-timing not yet
appears over and over again in dmesg, but register 0 is definitely
read more than 100 times...
>
>> static void set_reset_mode(struct net_device *dev)
>> {
>>          struct sja1000_priv *priv =3D netdev_priv(dev);
>>          unsigned char status =3D priv->read_reg(priv, SJA1000_MOD);
>>          int i;
>>                                                                     =
             =20
>>          /* disable interrupts */
>>          priv->write_reg(priv, SJA1000_IER, IRQ_OFF);
>>                                                                     =
             =20
>>          for (i =3D 0; i < 100; i++) {
>>                  /* check reset bit */
>>                  if (status & MOD_RM) {
>>                          priv->can.state =3D CAN_STATE_STOPPED;
>>                          return;
>>                  }
>>                                                                     =
             =20
>>                  /* reset chip */
>>                  priv->write_reg(priv, SJA1000_MOD, MOD_RM);
>>                  udelay(10);
>>                  status =3D priv->read_reg(priv, SJA1000_MOD);
>>          }
>>                                                                     =
             =20
>>          netdev_err(dev, "setting SJA1000 into reset mode failed!\n"=
);
>> }
> Instrument this code to see what's going on.
>
>> Now, what I don't understand at all:
>> Removing the module and loading it again works.
>> I don't get the error that setting the SJA1000 into reset mode faile=
d,
>> the register is only read once after loading the module,
>> and sending/reading CAN frames from the bus after setting a proper
>> bitrate works too....
> Maybe the delay is to small for your big banging io interface.
>
>> Any Ideas why the first initialization of the kernel module doesn't =
work?
>> When is the probe function of the module actually called?
> As soon as there is a matching driver//device combination on a bus.
> Looking at your driver, it's racy. You should not do any hardware set=
up
> in the init function.
Ok...I moved the whole configuration of the GPIOs into the probe=20
function (instead of the init)
and now it works! Thanks!

Now I only have to solve the problem, that bringing the interface down=20
is not possible....
Always need to reboot just to change bitrate is no fun.
Maybe I should consult the Raspberry community, if there is some kind o=
f=20
network manager...

Again, many thanks for your help!!
Regards,
=46lorian
>
>> A completely other question: I wanted to use libsocketcan to check t=
he
>> state of the interface,
>> bringing it up in case it's down, within my C/C++ Program.
>> Is there a way to use this lib as a normal user? Maybe some group th=
e
>> user has to be in?
> IIRC your process needs NET_ADMIN capabilities (CAP_NET_ADMIN). I
> personally never used capabilities, but there are libcap and libcap-n=
g
> (https://people.redhat.com/sgrubb/libcap-ng/), which might help.
>
> Marc
>


--=20
----------------------------------------
| Dr. Florian Feldbauer                |
|                                      |
| Helmholtz-Institut Mainz /           |
| Johannes Gutenberg-Universit=C3=A4t Mainz |
| Johann-Joachim-Becher-Weg 36         |
| D-55128 Mainz                        |
|                                      |
| Office: SB1 / 00-213                 |
| Phone:  (+49)6131 / 39-29605         |
----------------------------------------

