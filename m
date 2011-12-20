From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
 "
Date: Tue, 20 Dec 2011 21:50:41 +0100
Message-ID: <4EF0F521.1030106@pengutronix.de>
References: <301939.630738588-sendEmail@ubuntu-i386> <4EEB3C66.1020303@pengutronix.de> <4EF07B1F.4040609@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDF239B98F61F9568E3ED0CD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38247 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1LTUuw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Dec 2011 15:50:52 -0500
In-Reply-To: <4EF07B1F.4040609@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDF239B98F61F9568E3ED0CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


On 12/20/2011 01:10 PM, Grosjean Stephane wrote:
> I think so. :-)
>> + * You should have received a copy of the GNU General Public License
>> along
>> + * with this program; if not, write to the Free Software Foundation,
>> Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> please remove the address
>=20
> So I changed the above 3 lines into the two below:
>=20
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, write to the Free Software Foundation, I=
nc..
>=20
> Is it ok?

Just remove completely.

>> +#define PCAN_USB_EP_CMDIN    (PCAN_USB_EP_CMDOUT|USB_DIR_IN)
>> +#define PCAN_USB_EP_MSGOUT   2
>> +#define PCAN_USB_EP_MSGIN    (PCAN_USB_EP_MSGOUT|USB_DIR_IN)
>>                                                    ^^^
>> please add spaces around the |
> Ok.
>=20
>> +#define PCAN_USB_PARAMETER_LEN   14
>> +struct __packed pcan_usb_parameter {
>> +    u8 function;
>> +    u8    number;
>>           ^^^
>> please use one space
> Ok.
>> +#define PCAN_USB_TS_DIV_SHIFTER        20
>> +#define PCAN_USB_TS_US_PER_TICK        44739243
>> If you want to align the #defines please use tab between symbol and va=
lue
> So I put ONE tab in between the symbol and the value, everywhere in the=

> driver (IMHO, using tab(s) here too much relies on editor's tab size.
> Putting white spaces here fixes that... but it's my humble opinion only=
).

For kernel code a tab is 8 spaces, see Documentation/CodingStyle

>                 Chapter 1: Indentation
>=20
> Tabs are 8 characters, and thus indentations are also 8 characters.
> There are heretic movements that try to make indentations 4 (or even 2!=
)
> characters deep, and that is akin to trying to define the value of PI t=
o
> be 3.

[...]

>>> +    printk("btr0=3D0x%02x btr1=3D0x%02x", btr0, btr1);
>> Please use netdev_LEVEL() instead of printk
> I talked about that in my previous e-mail to Sebastian: these printk()s=

> are called in sequence: this one (for example) ISNOT the first one but
> occurs next to a netdev_info() macro (please see function
> "peak_usb_set_bittiming()" in "pcan_usb_core.c") ...
> According to that, if you think that the occurrence of some kernel
> event(s) in between the two messages (which could printk() msgs too) is=

> to be taken into account, I'll think about a new way of putting bitrate=

> info.

+1, You should always end prints with "\n", continuation of print should
be avoided.

>> +
>> +    err =3D pcan_usb_wait_response(dev, 6, 1, args);
>> +    if (err)
>> +        netdev_err(dev->netdev, "getting serial number failure:
>> %d\n", err);
>> +    else {
>> +        if (serial_number) memcpy(serial_number,&args[0], 4);
>> +    }
>> please remove the { }, no command after the if, please.
>>
>> Hmmm that serial number to u32 memcpy looks fishy, I smell endianess
>> problem. Can you test your driver on an big endian machine, like power=
pc?
> Ok no need to test, you're right (not very proud about that ;-)
>>> +            u8 sl =3D *ibuf++;
>>> +            u8 rec_len =3D (sl&  PCAN_USB_STATUSLEN_DLC);
>>> +
>>> +            /* handle error frames here */
>> I suggest to put the error handling in a sub function. If you have
>=20
> Hmmm... I also thought about that, but the amount of contextual
> variables to pass as arguments is quite large (i, ibuf, dts...): for
> that kind of hw, for example, timestamp coding depends on its place
> (rank) in the message. TODO

You can put all these arguments into a struct and just pass the pointer
to the struct.

>> +                switch (f) {
>> +
>> +                case 1:
>> +
>> please reove these two empty lines. I think you should define an enum
>> for the functions.
> Ok.
>>> +                    /* allocate an skb to store the error frame */
>>> +                    skb =3D alloc_can_err_skb(netdev,&cf);
>>> +                    if (skb =3D=3D NULL) {
>> !skb
>>
>> please talk to Wolfgang for the error handling, he is the expert now :=
)
>=20
> ???
> What should I talk about? Is the way errors are handling wrong?

I haven't looked at it, but Wolfgang has really twisted his mind around
error handling, so he's the expert now.

[...]

>>> +
>>> +                for (; d<  8; d++) {
>>> +                    cf->data[d] =3D 0;
>>> +                }
>> memset?
>=20
> memset(cf->data+d, '\0', 8 - d); /* and not memset(&cf->data[d],...;-),=

> even if I personally think that this last syntax is more explicit */

or even:

memset(cf->data, 0x0, sizeof(cf-data) - d);

>>> +
>>> +                peak_usb_get_timestamp_tv(&pdev->time_ref,
>>> ts16+dts,&tv);
>>> +                skb->tstamp =3D timeval_to_ktime(tv);
>>> +                netif_rx(skb);
>>> +
>>> +                stats->rx_packets++;
>>> +                stats->rx_bytes +=3D cf->can_dlc;
>>> +            }
>>> +
>>> +            if ((ibuf - (u8 *)urb->transfer_buffer)>=20
>>> urb->transfer_buffer_length) {
>> What does this check do? You should do bounds checking of ibuf before
>> accessing it.
> Yes you're right... My problem is that the size of the records (in the
> message) to decode is difficult to predict (see timestamp management fo=
r
> example). Well "difficult" is not the good word, but I thought it would=

> cost too much code for checking next ibuf each time.. But ok, I'll fix
> that too..

You know these security guys? They'll modify your mouse so that the
kernel would load the can driver, then send specially prepared messages
and then boom, root exploit.

>>> +                netdev_err(netdev, "usb message format error\n");
>>> +                err =3D -EINVAL;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +    else if (urb->actual_length>  0) {
>>> +        netdev_err(netdev, "usb message length error (%u)\n",
>>> urb->actual_length);
>>> +        err =3D -EINVAL;
>>> +    }
>> I'd move the error checking to the beginning of the function. Return
>> early if you detect an error, so that you can get rid of (at least) on=
e
>> indention level.
> I agree with you but for the indentation argument only: I think current=

> code enables to generally do only a single test  (actual_length >
> PCAN_USB_MSG_HEADER_LEN) than the one you're proposing. Moreover, even
> if I know that gcc does some quite incredible optimizations sometimes, =
I
> always prefer defining strict local variables (I mean, defining variabl=
e
> only in the block where it is used). But once again, if the linux kerne=
l
> coding style strictly requests it (or if any other arg regarding
> optimization comes from the list), I don't see any problem to move thes=
e
> tests where  you propose.



>>> +
>>> +    return err;
>>> +}
>>> +
>>> +static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct
>>> sk_buff *skb, u8 *obuf, size_t *size)
>>> +{
>>> +    struct net_device *netdev =3D dev->netdev;
>>> +    struct net_device_stats *stats =3D&netdev->stats;
>>> +    struct can_frame *cf =3D (struct can_frame *)skb->data;
>>> +    u8 *pc;
>>> +
>>> +    obuf[0] =3D 2;
>>> +    obuf[1] =3D 1;
>>> +
>>> +    pc =3D&obuf[PCAN_USB_MSG_HEADER_LEN];
>>> +
> I think I also have to change the above $obuf[] into:
>=20
> pc =3D obuf + PCAN_USB_MSG_HEADER_LEN;
>=20
> right?

yes, would be consistent.

>=20
>>> +    /* status/len byte */
>>> +    *pc =3D cf->can_dlc;
>>> +    if (cf->can_id&  CAN_RTR_FLAG)
>>> +        *pc |=3D PCAN_USB_STATUSLEN_RTR;
>>> +  =20
>>> +    /* can id */
>>> +    if (cf->can_id&  CAN_EFF_FLAG) {
>>> +        u32 tmp32 =3D cpu_to_le32(cf->can_id&  CAN_ERR_MASK);
>>                  ^^^ should be __le32 then
> Ok.
>>> +        tmp32<<=3D 3;
>>> +        *pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>>> +        memcpy(++pc,&tmp32, 4);
>>> +        pc +=3D 4;
>>> +    }
>>> +    else {
>> } else {
> Ok.
>>> +        u16 tmp16 =3D (u16 )cpu_to_le32(cf->can_id&  CAN_ERR_MASK);
>>                              ^^^^^^^^^^^^^^^^^
>> why convert to le32 and then cast to u16?
> ...because can_id is u32 and I only want to keep the lowest 16 bits . I=
s
> there another way to do that?

there's no need for an explicit cast

>>> +        tmp16<<=3D 5;
>>> +        memcpy(++pc,&tmp16, 2);
>>> +        pc +=3D 2;
>>> +    }
>>> +
>>> +    /* can data */
>>> +    if ((cf->can_id&  CAN_RTR_FLAG) =3D=3D 0) {
>> if (cf->can_id&  CAN_RTR_FLAG)
> Ok, but only if you wanted to say:
>=20
> if (!(cf->can_id&  CAN_RTR_FLAG)) {
>=20
> ;-)

Opps, yes :)

>=20
>>> +        memcpy(pc,&cf->data[0], cf->can_dlc);
>>         memcpy(pc, cf->data, cf->can_dlc);
> Ok.
>> +    /* check endpoint addresses (numbers) and associated max data
>> length */
>> +    /* (only from setting 0) */
>> +    iface_desc =3D&intf->altsetting[0];
>> +
>=20
> What about the above &altsetting[0] ? Should it be also changed into:
>=20
> iface_desc =3D intf->altsetting;

Yes

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFDF239B98F61F9568E3ED0CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7w9SsACgkQjTAFq1RaXHObeACfeH9QkH1vA3097N9Z9R13fIOJ
uxEAn1asqCOYCex2yjuaCoR0BG3uRfeK
=mKCK
-----END PGP SIGNATURE-----

--------------enigFDF239B98F61F9568E3ED0CD--
