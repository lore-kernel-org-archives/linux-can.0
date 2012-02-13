From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Mon, 13 Feb 2012 12:06:21 +0100
Message-ID: <4F38EEAD.3060607@pengutronix.de>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig894F933EA6C16D68669795AF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33702 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab2BMLG0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 06:06:26 -0500
In-Reply-To: <4F38EDB1.7080209@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig894F933EA6C16D68669795AF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/13/2012 12:02 PM, Wolfgang Grandegger wrote:
> On 02/13/2012 11:41 AM, Oliver Hartkopp wrote:
>> On 13.02.2012 11:14, Wolfgang Grandegger wrote:
>>
>>
>>>>> diff --git a/drivers/net/can/sja1000/sja1000.c
>>>>> b/drivers/net/can/sja1000/sja1000.c
>>>>> index ebbcfca..f7526a7 100644
>>>>> --- a/drivers/net/can/sja1000/sja1000.c
>>>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>>>> @@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void *d=
ev_id)
>>>>>                  n++;
>>>>>                  status =3D priv->read_reg(priv, REG_SR);
>>>>>
>>>>> +               /* check for absent controller due to hw unplug */
>>>>> +               if (status =3D=3D 0xFF)
>>>>> +                       break;
>>>>> +
>>>>>                  if (isrc&  IRQ_WUI)
>>>>>                          netdev_warn(dev, "wakeup interrupt\n");
>>>>>
>>>>> @@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void *de=
v_id)
>>>>>                          netif_wake_queue(dev);
>>>>>                  }
>>>>>                  if (isrc&  IRQ_RI) {
>>>>> -                       /* receive interrupt */
>>>>> -                       while (status&  SR_RBS) {
>>>>> +                       /* receive interrupt / check for absent con=
troller */
>>>>> +                       while (status&  SR_RBS&&  status !=3D 0xFF)=
 {
>>>>>                                  sja1000_rx(dev);
>>>>>                                  status =3D priv->read_reg(priv, RE=
G_SR);
>>>>>                          }
>>>>>
>>>>> @Stephane: Can you check that patch? I'm out of hw right now.
>>>>
>>>> I confirm that this patch works too...
>>>> So I think I should be able to post a new version of the peak_pcmcia=

>>>> during that day (the previous should work but some calls to
>>>> pcmcia_dev_present() are no more useful...)
>>>
>>> But that fix should not go to the common interrupt handler, if possib=
le.
>>
>>
>> Do you have an idea how to handle the while() statement without copyin=
g the
>> entire interrupt handler code for the devices that might be unplugged?=

>>
>> IMHO this patch is pretty cheap.
>=20
> I think it's enough to add a read in the custom pcmcia isr before
> calling sja1000_interrupt(). Maybe the race window is a bit lower but w=
e
> are not able to react when the unplug happens anyway.

It's not about reacting when an unlug happens, it's about not having the
interrupt handler to loop forever. At least we must limit the inner
while loop.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig894F933EA6C16D68669795AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk847rAACgkQjTAFq1RaXHPZFwCgjJg6plok1XnlaUe6B521gGdr
9EMAn3FTtzdZ7smPXl2PB1wWa6HlJRnb
=8TvC
-----END PGP SIGNATURE-----

--------------enig894F933EA6C16D68669795AF--
