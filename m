From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Wed, 11 Jan 2012 16:13:39 +0100
Message-ID: <4F0DA723.4030005@peak-system.com>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0B76FF.3060107@pengutronix.de>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-2d.bbox.fr ([194.158.122.57]:51326 "EHLO mail-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757096Ab2AKPNn (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 10:13:43 -0500
In-Reply-To: <4F0B76FF.3060107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Marc,

Please see my comments/notes below.

Le 10/01/2012 00:23, Marc Kleine-Budde a =E9crit :
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Found=
ation,
> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> Please remove the address. The FSF sometimes relocates it's office.

Done.

> +
> +/* PEAK-System PCMCIA driver name */
> +#define DRV_NAME "peak_pccard"
> Can you use the same name for the driver and the .c file?

Ok (peak_pccard)

>> +
>> +/* PEAK-System PCMCIA driver version */
>> +#define DRV_VERSION_MAJOR	0
>> +#define DRV_VERSION_MINOR	2
>> +#define DRV_VERSION_SUBMINOR	0
>> +
>> +#define DRV_VERSION_STRING __stringify(DRV_VERSION_MAJOR)"."\
>> +	__stringify(DRV_VERSION_MINOR)"."\
>> +	__stringify(DRV_VERSION_SUBMINOR)
> please add whitespace before "\"

This (obsolete) version string is now removed from the driver

> +
> +#define DRV_CHAN_SIZE	0x20
> +#define DRV_CHAN_OFF(c)	((c)*DRV_CHAN_SIZE)
> please add whitespace before and after "*"

Ok.

>> +#define DRV_CDR (CDR_CBP | CDR_CLKOUT_MASK)
> Can you please properly align all the defines above (or don't align a=
t
> all). I personally prefer a common prefix for all functions and defin=
es
> used in a driver, maybe use PCAN_ instead of DRV_

Ok (PCC_)

> +
> +/*
> + * write a sja1000 register
> + */
> +static void pcan_write_canreg(const struct sja1000_priv *priv, int p=
ort, u8 v)
> In the functions below port is always u8, here an int.

Well, the sja1000 api defines an "int" arg as port value, while the=20
other (static) functions "know" that this value will never exceed 255..=
=2E=20
But I agree with you, to be consistent, I changed all "u8" port defs=20
into "int" one.

>> +{
>> +	struct pcan_pccard *card =3D priv->priv;
>> +	int c =3D (priv->reg_base - card->ioport_addr) / DRV_CHAN_SIZE;
>> +
>> +	/* sja1000 register changes control the leds state */
>> +	switch (port) {
>> +	case REG_MOD:
> I would use:
> if (port =3D=3D REG_MOD), instead of the outer switch.

Ok, this is a remainder of some other "catches" I did at the beginning.=
=20
This is changed as you suggested now.

>> +		switch (v) {
>> +		case MOD_RM:
>> +			/* Reset Mode: set led on */
>> +			pcan_set_leds(card, DRV_LED(c), DRV_LED_ON);
>> +			break;
>> +		case 0x00:
> is there a defefine for 0x0, too?

Unfortunately, I didn't find any #define of the "normal mode" into=20
drivers/net/can/sja1000/sja1000.h, so...

> +
> +/*
> + * wait for SPI engine while it is busy
> + */
> +static int pcan_wait_spi_busy(struct pcan_pccard *card)
> +{
> +	int i;
> +
> +	for (i =3D 0; i<  DRV_SPI_MAX_WAIT_LOOP; i++) {
> +		if (!(pcan_read_reg(card, DRV_CSR)&  DRV_CSR_SPI_BUSY))
> +			break;
> +		schedule();
> How long does it take? Can you use msleep or usleep_range here?

TODO
>> +	}
>> +
>> +	if (i>=3D DRV_SPI_MAX_WAIT_LOOP) {
>> +		dev_err(&card->dev->dev, "failure: spi engine busy\n");
> please use netdev_err()

Hmmm... Dealing with SPI engine doesn't' concern any "canx" netdev=20
interface. The board handles two (or more) channels. At that moment,=20
which "canx" interface should be chosen? I'd prefer some prefix dealing=
=20
with the bus in the output msg, rather than one dealing with "canx"=20
interface... What is your opinion?

>> +/*
>> + * write data in device eeprom
>> + */
>> +static int pcan_write_eeprom(struct pcan_pccard *card, u16 addr, u8=
 v)
>> +{
>> +	u8 status;
>> +	int err, i;
>> +
>> +	/* write instruction */
>> +	pcan_write_reg(card, DRV_SPI_INR, 0x06);
> Can you define some macros for this and the following constants?

TODO

>
>> +=09
>> +
>> +	/* set address and data */
>> +	pcan_write_reg(card, DRV_SPI_ADR, addr&  0xff);
> The 3rd argument of pcan_write_reg() is u8, so the 0xff is not needed=
=2E

So it is (now, "ports" are int args ;-)

>> +
>> +write_eeprom_err:
>> +	dev_info(&card->dev->dev,
>> +		"writing 0x%x in eeprom @0x%x failed (err %d)\n",
>> +		v, addr, err);
> netdev_info()

Same answer as above (doesn't deal with canx interface here). Which one=
=20
should I choose?

> +/*
> + * set leds state according to channel activity
> + */
> +static void pcan_led_timer(unsigned long arg)
> +{
> +	struct pcan_pccard *card =3D (struct pcan_pccard *)arg;
> +	struct net_device *netdev;
> +	u8 ccr =3D card->ccr;
> +	int i, up_count;
> +
> +	for (i =3D up_count =3D 0; i<  card->chan_count; i++) {
> Personally I would not initialize up_count in the for() loop, as it i=
s
> unrelated to it.

Ok, init moved in above variable declaration.

> +/*
> + * free all resources used by the channels and switch off leds and c=
an power
> + */
> +static void pcan_free_channels(struct pcan_pccard *card)
> +{
> +	int i;
> +	u8 led_mask =3D 0;
> +
> +	for (i =3D 0; i<  card->chan_count; i++) {
> +		struct net_device *netdev;
> +		char name[IFNAMSIZ];
> +
> +		led_mask |=3D DRV_LED(i);
> +
> +		netdev =3D card->channel[i].netdev;
> +		if (!netdev)
> +			continue;
> +
> +		strncpy(name, netdev->name, IFNAMSIZ);
> +		unregister_sja1000dev(netdev);
> +		free_sja1000dev(netdev);
> +
> +		dev_info(&card->dev->dev, "%s removed\n", name);
> netdev_info()...maybe remove altogether

Hmm... At that time, the netdev pointer is no more valid, isn't it? And=
=20
personally, I prefer a msg prefixed by a bus notification telling that=20
one of its "children" doesn't exist anymore... (never good for a dead=20
thing to talk, you know ;-) But once again, what is the=20
general/linux-can rule?

> +static int pcan_add_channels(struct pcan_pccard *card)
> +{
> +	struct pcmcia_device *dev =3D card->dev;
> +	int i, err;
> +	u8 ccr =3D DRV_CCR_INIT;
> +	unsigned long rst_time;
>                        ^^^^^^^^
>
> this var is used write only, please remove.

Ok, you're right, I forgot it. It is removed now.

> +	/* create one network device per channel detected */
> +	for (i =3D 0; i<  DRV_CHAN_MAX; i++) {
> For documentation reasons I suggest to use
> ARRAY_SIZE(card->channel) instead of DRV_CHAN_MAX.

Yes, ok. I think the ems_pcmcia.c file should be updated too.

>> +		struct net_device *netdev;
>> +		struct sja1000_priv *priv;
>> +
>> +		netdev =3D alloc_sja1000dev(0);
>> +		if (!netdev) {
>> +			err =3D -ENOMEM;
>> +			break;
> please do a proper cleanup if this fails with i !=3D 0.

The cleaning is done after the call to "pcan_add_channels()" in=20
"pcan_probe()", when the count of detected channels is 0.

>> +		if (!pcan_check_channel(priv)) {
>> +			dev_err(&dev->dev, "channel %d not present\n", i);
>> +			free_sja1000dev(netdev);
> same here

See above

>> +		/* register SJA1000 device */
>> +		err =3D register_sja1000dev(netdev);
>> +		if (err) {
>> +			free_sja1000dev(netdev);
> dito

See above

>> +
>> +/*
>> + * free all resources used by the device
>> + */
>> +static void pcan_free(struct pcmcia_device *dev)
>> +{
>> +	if (!dev->priv)
>> +		return;
> Can this happen?

Mainly to protect from multiple calls...

>> +/*
>> + * setup PCMCIA socket and probe for PEAK-System PC-CARD
>> + */
>> +static int __devinit pcan_probe(struct pcmcia_device *dev)
>> +{
>> +	struct pcan_pccard *card;
>> +	int err;
>> +
>> +	dev->config_flags |=3D CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
>> +
>> +	err =3D pcmcia_loop_config(dev, pcan_conf_check, NULL);
>> +	if (err) {
>> +		dev_err(&dev->dev, "pcmcia_loop_config() error %d\n", err);
>> +		goto probe_err_1;
>> +	}
>> +
>> +	dev_info(&dev->dev, "new PEAK-System pcmcia card detected:\n");
>> +
>> +	dev_info(&dev->dev, "%s %s\n",
>> +		dev->prod_id[0] ? dev->prod_id[0] : "PEAK-System",
>> +		dev->prod_id[1] ? dev->prod_id[1] : "PCAN-PC Card");
> better make it only one dev_info(); there might be other printks
> interfering...

Yes ok, but I'm not sure whether the line won't be too large for a 80=20
columns screen.

> cheers, Marc

Thanks for your time.

Best regards,

St=E9phane

