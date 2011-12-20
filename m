From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
 "
Date: Tue, 20 Dec 2011 13:10:07 +0100
Message-ID: <4EF07B1F.4040609@peak-system.com>
References: <301939.630738588-sendEmail@ubuntu-i386> <4EEB3C66.1020303@pengutronix.de>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-3d.bbox.fr ([194.158.122.58]:47226 "EHLO mail-3d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab1LTMKL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 07:10:11 -0500
In-Reply-To: <4EEB3C66.1020303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

Thanks for your review. Please, find my answers and comments below...

Le 16/12/2011 13:41, Marc Kleine-Budde a =E9crit :
> On 12/16/2011 11:19 AM, s.grosjean@peak-system.com wrote:
>>  From 1cee3be3875f27a2ee3942b00d611450f4369325 Mon Sep 17 00:00:00 2=
001
>> From: Stephane Grosjean<s.grosjean@peak-system.com>
>> Date: Fri, 16 Dec 2011 11:11:37 +0100
>> Subject: [PATCH] Add support for PEAK-System GmbH CAN USB adapters (=
v2)
> The driver has some unusal coding style, please use checkpatch and do
> sparse checking (compile the drivers with C=3D2). Make use of C99
> initialisers. Use foo->bar not&foo->bar[0] to get the pointer for the
> first array element
Ok, I did use the C99 style and removed my &foo->bar[0] too, everywhere=
=20
in the driver.
> +
> +ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
>   ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
>
> ^^^^^^^^^^
>
> one ccflag should be enough :)

I think so. :-)
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> please remove the address

So I changed the above 3 lines into the two below:

+ * You should have received a copy of the GNU General Public License a=
long
+ * with this program; if not, write to the Free Software Foundation, I=
nc..

Is it ok?

> +#define PCAN_USB_EP_CMDIN    (PCAN_USB_EP_CMDOUT|USB_DIR_IN)
> +#define PCAN_USB_EP_MSGOUT   2
> +#define PCAN_USB_EP_MSGIN    (PCAN_USB_EP_MSGOUT|USB_DIR_IN)
>                                                    ^^^
> please add spaces around the |
Ok.

> +#define PCAN_USB_PARAMETER_LEN   14
> +struct __packed pcan_usb_parameter {
> +	u8 function;
> +	u8	number;
>           ^^^
> please use one space
Ok.
> +#define PCAN_USB_TS_DIV_SHIFTER        20
> +#define PCAN_USB_TS_US_PER_TICK        44739243
> If you want to align the #defines please use tab between symbol and v=
alue
So I put ONE tab in between the symbol and the value, everywhere in the=
=20
driver (IMHO, using tab(s) here too much relies on editor's tab size.=20
Putting white spaces here fixes that... but it's my humble opinion only=
).
> +
> +	cmd.function =3D f;
> +	cmd.number =3D n;
> you can use C99 initialisers instead:
>
> 	struct pcan_usb_parameter cmd =3D {
> 		.function =3D f,
> 		.number =3D n,
> 	};
>
> then parameters in automatically set with 0x0....
Ok.
>> +
>> +	if (p !=3D NULL)
> if (p)
Ok.
>> +		memcpy(&cmd.parameters[0], p, PCAN_USB_PARAMETER_LEN);
> I'd write memcpy(cmd.parameters, p, ARRAY_SIZE(cmd.parameters))
So did I...
>> +	else
>> +		memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);
> ...and you can remove the memset here.
Ok.
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> please put the return in a seperate line.
Ok (done everywhere in the driver too).
> +	err =3D pcan_usb_send_command(dev, f, n, NULL);
> +	if (err) {
> +		return err;
> +	}
> please remove the { }
Ok (done everywhere in the driver too).
>
> the array can be initializes in C99 style, too:
>
> 	u8 args[PCAN_USB_PARAMETER_LEN] =3D {
> 		[0] =3D 0,
> 		[1] =3D mode,
> 	};
>
> The [0] can be skipped, by you might want to include it for
> documentation purpose.
No, I don't... So I removed the [0] =3D 0 too...
> Please add a newline in before return
Ok
> dito
>
> I see some magic numbers for the command here, does it make sense to
> define an enum for them?
TODO...
>> +}
>> +
>> +/*
>> + * This routine was stolen from drivers/net/can/sja1000/sja1000.c
>> + */
> Nice for crediting this, but IMHO no need to write it into the code.
Ok, removed now (FYI it's not so nice to steal something which was=20
already stolen ;-)
>> +static int pcan_usb_set_bittiming(struct peak_usb_device *dev, stru=
ct can_bittiming *bt)
>> +{
>> +	u8 args[PCAN_USB_PARAMETER_LEN];
>> +	u8 btr0, btr1;
>> +
>> +	btr0 =3D ((bt->brp - 1)&  0x3f) | (((bt->sjw - 1)&  0x3)<<  6);
>> +	btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1)&  0xf) \
>> +	     | (((bt->phase_seg2 - 1)&  0x7)<<  4);
>> +	if (dev->can.ctrlmode&  CAN_CTRLMODE_3_SAMPLES)
>> +		btr1 |=3D 0x80;
>> +
>> +	args[0] =3D btr1;
>> +	args[1] =3D btr0;
>> +
>> +	printk("btr0=3D0x%02x btr1=3D0x%02x", btr0, btr1);
> Please use netdev_LEVEL() instead of printk
I talked about that in my previous e-mail to Sebastian: these printk()s=
=20
are called in sequence: this one (for example) ISNOT the first one but=20
occurs next to a netdev_info() macro (please see function=20
"peak_usb_set_bittiming()" in "pcan_usb_core.c") ...
According to that, if you think that the occurrence of some kernel=20
event(s) in between the two messages (which could printk() msgs too) is=
=20
to be taken into account, I'll think about a new way of putting bitrate=
=20
info.
> +
> +	err =3D pcan_usb_wait_response(dev, 6, 1, args);
> +	if (err)
> +		netdev_err(dev->netdev, "getting serial number failure: %d\n", err=
);
> +	else {
> +		if (serial_number) memcpy(serial_number,&args[0], 4);
> +	}
> please remove the { }, no command after the if, please.
>
> Hmmm that serial number to u32 memcpy looks fishy, I smell endianess
> problem. Can you test your driver on an big endian machine, like powe=
rpc?
Ok no need to test, you're right (not very proud about that ;-)
>> +			u8 sl =3D *ibuf++;
>> +			u8 rec_len =3D (sl&  PCAN_USB_STATUSLEN_DLC);
>> +
>> +			/* handle error frames here */
> I suggest to put the error handling in a sub function. If you have

Hmmm... I also thought about that, but the amount of contextual=20
variables to pass as arguments is quite large (i, ibuf, dts...): for=20
that kind of hw, for example, timestamp coding depends on its place=20
(rank) in the message. TODO
> +				switch (f) {
> +
> +				case 1:
> +
> please reove these two empty lines. I think you should define an enum
> for the functions.
Ok.
>> +					/* allocate an skb to store the error frame */
>> +					skb =3D alloc_can_err_skb(netdev,&cf);
>> +					if (skb =3D=3D NULL) {
> !skb
>
> please talk to Wolfgang for the error handling, he is the expert now =
:)

???
What should I talk about? Is the way errors are handling wrong?

> +
> +			/* handle normal can frames here */
> please use an extra fucntion for normal frames

Same answer than error handling (see above): not so easy nor so obvious=
=2E..
>> +				}
>> +				else {
> the preferred coding style is
> } else {
Ok (tried to change the whole driver files)
>> +					u8 ts8 =3D *ibuf++;
>> +
>> +					if (dts) {
>> +						dts&=3D 0xff00;
>> +						if (ts8<  prev_ts8)
>> +							dts +=3D 0x100;
>> +					}
>> +
>> +					dts |=3D ts8;
>> +					prev_ts8 =3D ts8;
> I think I've seen this code before, please add a function for it.
Ok, this is done now.

>
>> +				else {
> } else { - or better get remove the { }
>
>> +					for (; d<  rec_len; d++)
>> +						cf->data[d] =3D *ibuf++;
>> +				}
Ok ({} removed)

>> +
>> +				for (; d<  8; d++) {
>> +					cf->data[d] =3D 0;
>> +				}
> memset?

memset(cf->data+d, '\0', 8 - d); /* and not memset(&cf->data[d],...;-),=
=20
even if I personally think that this last syntax is more explicit */

>> +
>> +				peak_usb_get_timestamp_tv(&pdev->time_ref, ts16+dts,&tv);
>> +				skb->tstamp =3D timeval_to_ktime(tv);
>> +				netif_rx(skb);
>> +
>> +				stats->rx_packets++;
>> +				stats->rx_bytes +=3D cf->can_dlc;
>> +			}
>> +
>> +			if ((ibuf - (u8 *)urb->transfer_buffer)>  urb->transfer_buffer_l=
ength) {
> What does this check do? You should do bounds checking of ibuf before
> accessing it.
Yes you're right... My problem is that the size of the records (in the=20
message) to decode is difficult to predict (see timestamp management fo=
r=20
example). Well "difficult" is not the good word, but I thought it would=
=20
cost too much code for checking next ibuf each time.. But ok, I'll fix=20
that too..
>> +				netdev_err(netdev, "usb message format error\n");
>> +				err =3D -EINVAL;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	else if (urb->actual_length>  0) {
>> +		netdev_err(netdev, "usb message length error (%u)\n", urb->actual=
_length);
>> +		err =3D -EINVAL;
>> +	}
> I'd move the error checking to the beginning of the function. Return
> early if you detect an error, so that you can get rid of (at least) o=
ne
> indention level.
I agree with you but for the indentation argument only: I think current=
=20
code enables to generally do only a single test  (actual_length >=20
PCAN_USB_MSG_HEADER_LEN) than the one you're proposing. Moreover, even=20
if I know that gcc does some quite incredible optimizations sometimes, =
I=20
always prefer defining strict local variables (I mean, defining variabl=
e=20
only in the block where it is used). But once again, if the linux kerne=
l=20
coding style strictly requests it (or if any other arg regarding=20
optimization comes from the list), I don't see any problem to move thes=
e=20
tests where  you propose.
>> +
>> +	return err;
>> +}
>> +
>> +static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct =
sk_buff *skb, u8 *obuf, size_t *size)
>> +{
>> +	struct net_device *netdev =3D dev->netdev;
>> +	struct net_device_stats *stats =3D&netdev->stats;
>> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
>> +	u8 *pc;
>> +
>> +	obuf[0] =3D 2;
>> +	obuf[1] =3D 1;
>> +
>> +	pc =3D&obuf[PCAN_USB_MSG_HEADER_LEN];
>> +
I think I also have to change the above $obuf[] into:

pc =3D obuf + PCAN_USB_MSG_HEADER_LEN;

right?

>> +	/* status/len byte */
>> +	*pc =3D cf->can_dlc;
>> +	if (cf->can_id&  CAN_RTR_FLAG)
>> +		*pc |=3D PCAN_USB_STATUSLEN_RTR;
>> +=09
>> +	/* can id */
>> +	if (cf->can_id&  CAN_EFF_FLAG) {
>> +		u32 tmp32 =3D cpu_to_le32(cf->can_id&  CAN_ERR_MASK);
>                  ^^^ should be __le32 then
Ok.
>> +		tmp32<<=3D 3;
>> +		*pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>> +		memcpy(++pc,&tmp32, 4);
>> +		pc +=3D 4;
>> +	}
>> +	else {
> } else {
Ok.
>> +		u16 tmp16 =3D (u16 )cpu_to_le32(cf->can_id&  CAN_ERR_MASK);
>                              ^^^^^^^^^^^^^^^^^
> why convert to le32 and then cast to u16?
=2E..because can_id is u32 and I only want to keep the lowest 16 bits .=
 Is=20
there another way to do that?
>> +		tmp16<<=3D 5;
>> +		memcpy(++pc,&tmp16, 2);
>> +		pc +=3D 2;
>> +	}
>> +
>> +	/* can data */
>> +	if ((cf->can_id&  CAN_RTR_FLAG) =3D=3D 0) {
> if (cf->can_id&  CAN_RTR_FLAG)
Ok, but only if you wanted to say:

if (!(cf->can_id&  CAN_RTR_FLAG)) {

;-)

>> +		memcpy(pc,&cf->data[0], cf->can_dlc);
> 		memcpy(pc, cf->data, cf->can_dlc);
Ok.
> +	/* check endpoint addresses (numbers) and associated max data lengt=
h */
> +	/* (only from setting 0) */
> +	iface_desc =3D&intf->altsetting[0];
> +

What about the above &altsetting[0] ? Should it be also changed into:

iface_desc =3D intf->altsetting;


?

>
> that's it for now
>
> Marc
>
Many thanks for all of your work, Marc.

St=E9phane
