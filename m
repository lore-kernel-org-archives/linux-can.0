From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] peak_pci: fix use after free in netdev teardown
Date: Mon, 19 May 2014 14:06:45 +0200
Message-ID: <5379F3D5.6020909@peak-system.com>
References: <1397072720.22713.19.camel@acrs-z800-1>
 <5379AE8C.9050406@pengutronix.de> <5379CB87.20106@peak-system.com>
 <5379CCDF.90809@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43764 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbaESMGx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 08:06:53 -0400
In-Reply-To: <5379CCDF.90809@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

Hi again,

After having a deeper look to the code, it looks like we don't actually=
=20
need all of these modifications.

It's ok that some pointers have to be saved BEFORE calling=20
free_sja1000dev(), but I checked the other things more deeply:

- peak_pciec_remove() calls don't need to be moved: this function=20
clearly doesn't deal with any netdev neither candev stuff. So, it=20
doesn't actually need to be called before free_sja1000dev().

- IMHO, no need to restore "pci_set_drvdata(pdev,NULL);" before=20
returning an errno status from the _probe() function (neither from=20
peak_pci_remove()): the pci device object won't be used next (AFAIK).

- same in peak_pci_remove(): the prev link has to be saved before=20
freeing the current candev object.

So I assume that Christopher's fix could be summarized to:

--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -551,7 +551,7 @@ static int peak_pci_probe(struct pci_dev *pdev,=20
const struct
  {
         struct sja1000_priv *priv;
         struct peak_pci_chan *chan;
-       struct net_device *dev;
+       struct net_device *dev, *prev_dev;
         void __iomem *cfg_base, *reg_base;
         u16 sub_sys_id, icr;
         int i, err, channels;
@@ -688,11 +688,13 @@ failure_remove_channels:
         writew(0x0, cfg_base + PITA_ICR + 2);

         chan =3D NULL;
-       for (dev =3D pci_get_drvdata(pdev); dev; dev =3D chan->prev_dev=
) {
-               unregister_sja1000dev(dev);
-               free_sja1000dev(dev);
+       for (dev =3D pci_get_drvdata(pdev); dev; dev =3D prev_dev) {
                 priv =3D netdev_priv(dev);
                 chan =3D priv->priv;
+               prev_dev =3D chan->prev_dev;
+
+               unregister_sja1000dev(dev);
+               free_sja1000dev(dev);
         }

         /* free any PCIeC resources too */
@@ -726,10 +728,12 @@ static void peak_pci_remove(struct pci_dev *pdev)

         /* Loop over all registered devices */
         while (1) {
+               struct net_device *prev_dev =3D chan->prev_dev;
+
                 dev_info(&pdev->dev, "removing device %s\n", dev->name=
);
                 unregister_sja1000dev(dev);
                 free_sja1000dev(dev);
-               dev =3D chan->prev_dev;
+               dev =3D prev_dev;

                 if (!dev) {
                         /* do that only for first channel */

If ok, I'll push a well formatted patch asap, as soon as I have finishe=
d=20
with building my local linux-can-next and have tested these changes.

Regards,

St=C3=A9phane

Le 19/05/2014 11:20, Marc Kleine-Budde a =C3=A9crit :
> On 05/19/2014 11:14 AM, Stephane Grosjean wrote:
>> Hi All,
>>
>> So I finally had a look to the diff file. It clearly does what
>> Christopher says, that is, it fixes some memory access order issues =
when
>> the CAN devices have to be removed from the system, either when prob=
ing
>> has failed or when the driver is unloaded from the system.
>>
>> The diff file has to be re-written into a Linux-coding style patch, =
and
>> yes, maybe all this removing stuff could be put into a (new) single
>> function made for that.
>>
>> So, how do we proceed, please ?
> Make it so.
>
> Marc
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
--
