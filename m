From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Mon, 13 Feb 2012 11:14:12 +0100
Message-ID: <4F38E274.4050304@grandegger.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47580 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2BMKOW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 05:14:22 -0500
In-Reply-To: <4F38DF75.3040000@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/13/2012 11:01 AM, Stephane Grosjean wrote:
> Hello all,
>=20
> I copied&pasted everything in this single mail to simplify...
>=20
> Le 13/02/2012 10:14, Marc Kleine-Budde a =E9crit :
>> On 02/06/2012 04:56 PM, Stephane Grosjean wrote:
>>> This patch adds the support of the PCAN-PC Card (PCMCIA) card from
>>> PEAK-System Technik (http://www.peak-system.com). The PCAN-PC Card =
is
>>> sja1000 based and exists in 1 or 2 channels.
>>>
>>> Signed-off-by: Stephane Grosjean<s.grosjean@peak-system.com>
>> What's the status of this patch?
>>
>=20
> See below please...
>=20
>> diff --git a/drivers/net/can/sja1000/sja1000.c
>> b/drivers/net/can/sja1000/sja1000.c
>> index ebbcfca..f7526a7 100644
>> --- a/drivers/net/can/sja1000/sja1000.c
>> +++ b/drivers/net/can/sja1000/sja1000.c
>> @@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void *de=
v_id)
>>                  n++;
>>                  status =3D priv->read_reg(priv, REG_SR);
>>
>> +               /* check for absent controller due to hw unplug */
>> +               if (status =3D=3D 0xFF)
>> +                       break;
>> +
>>                  if (isrc&  IRQ_WUI)
>>                          netdev_warn(dev, "wakeup interrupt\n");
>>
>> @@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev=
_id)
>>                          netif_wake_queue(dev);
>>                  }
>>                  if (isrc&  IRQ_RI) {
>> -                       /* receive interrupt */
>> -                       while (status&  SR_RBS) {
>> +                       /* receive interrupt / check for absent
>> controller */
>> +                       while (status&  SR_RBS&&  status !=3D 0xFF) =
{
>>                                  sja1000_rx(dev);
>>                                  status =3D priv->read_reg(priv, REG=
_SR);
>>                          }
>>
>> @Stephane: Can you check that patch? I'm out of hw right now.
>=20
> I confirm that this patch works too...
> So I think I should be able to post a new version of the peak_pcmcia
> during that day (the previous should work but some calls to
> pcmcia_dev_present() are no more useful...)

But that fix should not go to the common interrupt handler, if possible=
=2E

Wolfgang.


