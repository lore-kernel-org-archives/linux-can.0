From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Wed, 11 Jan 2012 18:10:18 +0100
Message-ID: <4F0DC27A.70202@peak-system.com>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0C4020.8010304@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-1d.bbox.fr ([194.158.122.56]:40210 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320Ab2AKRKX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 12:10:23 -0500
In-Reply-To: <4F0C4020.8010304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Wolfgang,


Le 10/01/2012 14:41, Wolfgang Grandegger a =E9crit :
> Hi Stephane,
>
> please send a patch using a proper subject line and commit message. A=
lso
> add a CC to the pcmcia linux mailing list. Thanks.

Ok I'll do that for v2.

> +
> +/* PEAK-System PCMCIA driver name */
> +#define DRV_NAME "peak_pccard"
> I find the mix of "peak_pcmcia" and "peak_pccard" and "pcan_pccard" f=
or
> the same hardware confusing. Please use just one name and prefix.

Ok, decision was made: peak_pcmcia, once for all!
Closed.

>> +
>> +/* PEAK-System PCMCIA driver version */
>> +#define DRV_VERSION_MAJOR	0
>> +#define DRV_VERSION_MINOR	2
>> +#define DRV_VERSION_SUBMINOR	0
>> +
>> +#define DRV_VERSION_STRING __stringify(DRV_VERSION_MAJOR)"."\
>> +	__stringify(DRV_VERSION_MINOR)"."\
>> +	__stringify(DRV_VERSION_SUBMINOR)
> As for the USB driver, I would remove this redundant versioning stuff=
=2E
> Also version 0.2.0 does not really sound like like a stable piece of
> software.

Removed from both drivers.
Closed.

> +
> +#define DRV_CHAN_MAX 2
> +
> +#define DRV_CAN_CLOCK (16000000 / 2)
> Hm, the prefix DRV_ here and below does not really make sense. But we=
ll,
> it's a minor issue.

PCC_
Closed.

>> +static int pcan_write_eeprom(struct pcan_pccard *card, u16 addr, u8=
 v)
>> +{
>> +	u8 status;
>> +	int err, i;
>> +
>> +	/* write instruction */
>> +	pcan_write_reg(card, DRV_SPI_INR, 0x06);
> Macro definitons would be nice.

TODO

>> +	/* wait until write enable */
>> +	for (i =3D 0; i<  DRV_WRITE_MAX_LOOP; i++) {
>> +		/* RDSR */
> This comment does not tell me anything.

Ok, what about these one?

/* write command reading the status register */
=2E..
/* get the status register and check write enable bit */

then;

/* write command reading the status register */
=2E..
/* get the status register and check write in progress bit */


> +
> +write_eeprom_err:
> +	dev_info(&card->dev->dev,
> +		"writing 0x%x in eeprom @0x%x failed (err %d)\n",
> +		v, addr, err);
> Info or error. Can this happen? If yes, how often?

It's an error and I never saw it. Moreover, writing in eeprom is (only)=
=20
done to power up/down the can connectors (so first when driver is=20
loaded, second when it is unloaded).
Moved the dev_info() into dev_err().

>> +	return err;
>> +}
>> +
>> +/*
>> + * control the leds
>> + * @led_mask: should be an or made of DRV_LED(x)
>> + * @state: DRV_LED_ON, DRV_LED_OFF, DRV_LED_SLOW or DRV_LED_FAST
>> + */
> Please remove the docbook tags.

Ok.

>> +/*
>> + * interrupt service routine
>> + */
>> +static irqreturn_t pcan_isr(int irq, void *dev_id)
>> +{
>> +	struct pcan_pccard *card =3D dev_id;
>> +	struct net_device *netdev;
>> +	irqreturn_t retval =3D IRQ_NONE;
>> +	int i, again;
>> +
>> +	do {
>> +		again =3D 0;
>> +
>> +		/* Check interrupt for each channel */
>> +		for (i =3D 0; i<  card->chan_count; i++) {
>> +			netdev =3D card->channel[i].netdev;
>> +			if (!netdev)
>> +				continue;
>> +
>> +			if (sja1000_interrupt(irq, netdev) =3D=3D IRQ_HANDLED)
>> +				again =3D 1;
>> +		}
>> +
>> +		/* At least one channel handled the interrupt */
>> +		if (again)
>> +			retval =3D IRQ_HANDLED;
>> +
>> +	} while (again);
> I wonder if it makes sense to limit the loop count.

Had a look to sja1000_interrupt(): you're right, could enter in an=20
infinite loop if one of the sja1000 failed into always sending interrup=
t=20
signals...
On my side, I wonder why entering such a do { } while (again) loop?

>> +
>> +	dev_info(&dev->dev, "new PEAK-System pcmcia card detected:\n");
>> +
>> +	dev_info(&dev->dev, "%s %s\n",
>> +		dev->prod_id[0] ? dev->prod_id[0] : "PEAK-System",
>> +		dev->prod_id[1] ? dev->prod_id[1] : "PCAN-PC Card");
> One line (dev_info) should be enough. Also "dev->dev" is not really
> readable. "dev->p[cmcia_]dev" would be much better.

Since this is the 2nd time this request comes, considering its priority=
=20
as increased: thus, changed into a single dev_info();
dev changed into pdev: Ok.


>> +	card =3D kzalloc(sizeof(struct pcan_pccard), GFP_KERNEL);
>> +	if (!card) {
>> +		dev_err(&dev->dev, "kzalloc() failure\n");
> Please be more specific, e.g.: "couldn't allocated card memory".

As you want, you're (one of) the chief(s) ;-)
Closed.

>> +
>> +	/* sja1000 api uses iomem */
>> +	card->ioport_addr =3D ioport_map(dev->resource[0]->start,
>> +					resource_size(dev->resource[0]));
>> +	if (!card->ioport_addr) {
>> +		err =3D -ENOMEM;
>> +		goto probe_err_3;
>> +	}
>> +
>> +	/* display firware version */
>> +	dev_info(&dev->dev, "firmware %d.%d\n",
>> +		pcan_read_reg(card, DRV_FW_MAJOR),
>> +		pcan_read_reg(card, DRV_FW_MINOR));
>> +
>> +	/* detect available channels */
>> +	pcan_add_channels(card);
>> +	if (!card->chan_count)
>> +		goto probe_err_3;
>> +
>> +	/* init the timer which controls the leds */
>> +	init_timer(&card->led_timer);
>> +	card->led_timer.function =3D pcan_led_timer;
>> +	card->led_timer.data =3D (unsigned long)card;
>> +
>> +	/* request the given irq */
>> +	err =3D request_irq(dev->irq,&pcan_isr, IRQF_SHARED, DRV_NAME, car=
d);
>> +	if (err)
>> +		goto probe_err_4;
>> +
>> +	/* power on the connectors */
>> +	pcan_set_can_power(card, 1);
>> +
>> +	return 0;
>> +
>> +probe_err_4:
>> +	/* unregister can devices from network */
>> +	pcan_free_channels(card);
>> +
>> +probe_err_3:
>> +	kfree(card);
>> +	dev->priv =3D NULL;
>> +
>> +probe_err_2:
>> +	pcmcia_disable_device(dev);
>> +
>> +probe_err_1:
>> +	return err;
> I'm missing ioport_unmap()!

Yes you're perfectly right: in many cases, it will be right called by=20
pcan_free_channels() but not before going to "probe_err_3", when no=20
channel are detected. So changed code above into:

         /* detect available channels */
         pcan_add_channels(card);
         if (!card->chan_count) {
             ioport_unmap(card->ioport_addr);
             goto probe_err_3;
         }

> Thanks for your contribution.
>
> Wolfgang.

You're welcome, thanks for your time.

St=E9phane

