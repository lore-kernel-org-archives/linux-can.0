From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2) "
Date: Mon, 19 Dec 2011 18:03:34 +0100
Message-ID: <1324314214625714500@peak-system.com>
References: <301939.630738588-sendEmail@ubuntu-i386>
 <4EEC9674.2010307@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:50346 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1LSRJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Dec 2011 12:09:42 -0500
In-Reply-To: <4EEC9674.2010307@sebastianhaas.info>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: linux-can@vger.kernel.org

Le Sam, 12/17/2011 02:17 PM, @{sender } a =C3=A9crit:
> Hi,
>=20

Hi,

> some annotations also from me. ;-)=20

Many thanks for these.

> Since Marc already did the coding=20
> style nitpicking I've tried to focus on logical stuff. I hope it is h=
elpful.
>=20
> Cheers,
>   Sebastian
>=20

My responses and explanations below. I'm working on a new version which=
 should take into account a lot (all?) of your comments.

> Am 16.12.2011 11:19, schrieb s.grosjean@peak-system.com:
> > +static int pcan_usb_wait_response(struct peak_usb_device *dev, u8 =
f, u8 n, u8 *p)
> > +{
> > +    int actual_length;
> > +    struct pcan_usb_parameter cmd;
> > +    int err;
> > +
> > +    /* usb device unregistered? */
> > +    if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> > +
> > +    /* first, send command */
> > +    err =3D pcan_usb_send_command(dev, f, n, NULL);
> > +    if (err) {
> > +        return err;
> > +    }
> > +
> > +    cmd.function =3D f;
> > +    cmd.number =3D n;
> > +    memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);
> > +
> > +    /* then, wait for the response */
> > +    mdelay(5);
> A delay to wait for a response? What happens if the device takes a=20
> little bit longer. This looks to be not really robust.
>=20

Historical reason I mean... Seems working without the mdelay(), so I'll=
 remove it.

> > +    err =3D usb_bulk_msg(dev->udev,
> > +                       usb_rcvbulkpipe(dev->udev, PCAN_USB_EP_CMDI=
N),
> > +    &cmd, sizeof(struct pcan_usb_parameter),
> > +    &actual_length, PCAN_USB_COMMAND_TIMEOUT);
> > +    if (err)
> > +        netdev_err(dev->netdev,
> > +                   "waiting response function=3D0x%x number=3D0x%x=
 failure: %d\n",
> > +                   f, n, err);
> > +    else if (p) memcpy(p,&cmd.parameters[0], PCAN_USB_PARAMETER_LE=
N);
> > +
> > +    return err;
> > +}
> > +
> > +
> > +/*
> > + * Start interface
> > + */
> > +static int peak_usb_start(struct peak_usb_device *dev)
> > +{
> > +    struct net_device *netdev =3D dev->netdev;
> > +    int err, i;
> > +
> > +    for (i =3D 0; i<  PCAN_USB_MAX_RX_URBS; i++) {
> > +        struct urb *urb =3D NULL;
> > +        u8 *buf =3D NULL;
> > +
> > +        /* create a URB, and a buffer for it, to receive usb messa=
ges */
> > +        urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +        if (!urb) {
> > +            netdev_err(netdev, "No memory left for URBs\n");
> > +            return -ENOMEM;
> > +        }
> > +
> > +        buf =3D usb_alloc_coherent(dev->udev, dev->adapter->rx_buf=
fer_size,
> > +                                 GFP_KERNEL,&urb->transfer_dma);
> > +        if (!buf) {
> > +            netdev_err(netdev, "No memory left for USB buffer\n");
> > +            usb_free_urb(urb);
> > +            return -ENOMEM;
> > +        }
> > +
> > +        usb_fill_bulk_urb(urb, dev->udev,
> > +                          usb_rcvbulkpipe(dev->udev, dev->ep_msg_i=
n),
> > +                          buf, dev->adapter->rx_buffer_size,
> > +                          peak_usb_read_bulk_callback, dev);
> > +        urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> > +        usb_anchor_urb(urb,&dev->rx_submitted);
> > +
> > +        err =3D usb_submit_urb(urb, GFP_KERNEL);
> > +        if (err) {
> > +            if (err =3D=3D -ENODEV)
> > +                netif_device_detach(dev->netdev);
> > +
> > +            usb_unanchor_urb(urb);
> > +            usb_free_coherent(dev->udev, dev->adapter->rx_buffer_s=
ize, buf,
> > +                      urb->transfer_dma);
> How about the URB?

Seems you're right, "usb_free_urb()" is missing here... (Please have a =
look to ems_usb.c too)

> > +            break;
> > +        }
> > +
> > +        /* Drop reference, USB core will take care of freeing it *=
/
> > +        usb_free_urb(urb);
> > +    }
> > +
> > +    /* Did we submit any URBs */
> > +    if (i =3D=3D 0) {
> > +        netdev_warn(netdev, "couldn't setup read URBs\n");
> > +        return err;
> > +    }
> > +
> > +    /* Warn if we've couldn't transmit all the URBs */
> > +    if (i<  PCAN_USB_MAX_RX_URBS)
> > +        netdev_warn(netdev, "rx performance may be slow\n");
> > +
> > +    /* Pre-alloc tx buffers and corresponding urbs */
> > +    for (i =3D 0; i<  PCAN_USB_MAX_TX_URBS; i++) {
> > +         struct peak_tx_urb_context *context;
> > +        struct urb *urb =3D NULL;
> > +        u8 *buf =3D NULL;
> > +
> > +        /* create a URB, and a buffer for it, to trsmit usb messag=
es */
> > +        urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +        if (!urb) {
> > +            netdev_err(netdev, "No memory left for URBs\n");
> > +            return -ENOMEM;
> What happens with the URBs and buffers allocated before?

I changed that in the two _RX/_TX loops: if urb or buffer allocation fa=
ils, break the loop after warning into logs.=20
Next, check loop variable against 0 and PCAN_USB_MAX_xX_URBS: returns e=
rror if 0, warns about slow path but continue if lower than its max.

> > +        }
> > +
> > +        buf =3D usb_alloc_coherent(dev->udev, dev->adapter->tx_buf=
fer_size,
> > +                                 GFP_KERNEL,&urb->transfer_dma);
> > +        if (!buf) {
> > +            netdev_err(netdev, "No memory left for USB buffer\n");
> > +            usb_free_urb(urb);
> > +            return -ENOMEM;
> Dito.

Ok.

> > +        }
> > +
> > +        context =3D&dev->tx_contexts[i];
> > +        context->dev =3D dev;
> > +        context->urb =3D urb;
> > +
> > +        usb_fill_bulk_urb(urb, dev->udev,
> > +                          usb_sndbulkpipe(dev->udev, dev->ep_msg_o=
ut),
> > +                          buf, dev->adapter->tx_buffer_size,
> > +                          peak_usb_write_bulk_callback, context);
> > +        urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> > +    }
> > +
> > +    /* Warn if we've couldn't transmit all the URBs */
> > +    if (i<  PCAN_USB_MAX_TX_URBS)
> This will never happen since the loop above will always return from t=
his=20
> function in error case (return -ENOMEM).
>

Ok, now this could happen ;-)

> > +        netdev_warn(netdev, "tx performance may be slow\n");
> > +
> > +    if (dev->adapter->device_start) {
> > +        err =3D dev->adapter->device_start(dev);
> > +        if (err)
> > +            goto failed;
> > +    }
> > +
> > +    /* can set bus on now */
> > +    if (dev->adapter->device_set_bus) {
> > +        err =3D dev->adapter->device_set_bus(dev, 1);
> > +        if (err)
> > +            goto failed;
> > +    }
> > +
> > +    dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +
> > +    return 0;
> > +
> > +failed:
> > +    if (err =3D=3D -ENODEV)
> > +        netif_device_detach(dev->netdev);
> > +
> > +    netdev_warn(netdev, "couldn't submit control: %d\n", err);
> > +
> > +    return err;
> > +}
> > +
> > +
> > +static int peak_usb_ndo_open(struct net_device *netdev)
> > +{
> > +    struct peak_usb_device *dev =3D netdev_priv(netdev);
> > +    int err;
> > +
> > +    /* common open */
> > +    err =3D open_candev(netdev);
> > +    if (err)
> > +        return err;
> > +
> > +    /* finally start device */
> > +    err =3D peak_usb_start(dev);
> > +    if (err) {
> > +        if (err =3D=3D -ENODEV)
> > +            netif_device_detach(dev->netdev);
> This is already done in peak_usb_start() on -ENODEV.

Ok (Great!) That's right! Think about changing ems_usb.c too.

> > +
> > +        netdev_warn(netdev, "couldn't start device: %d\n", err);
> > +
> > +        close_candev(netdev);
> > +
> > +        return err;
> > +    }
> > +
> > +    dev->open_time =3D jiffies;
> > +
> > +    netif_start_queue(netdev);
> > +
> > +    return 0;
> > +}
> > +
> > +static int peak_usb_set_bittiming(struct net_device *netdev)
> > +{
> > +    struct peak_usb_device *dev =3D netdev_priv(netdev);
> > +    struct can_bittiming *bt =3D&dev->can.bittiming;
> > +    int err;
> > +
> > +    netdev_info(netdev, "set bitrate %u Kbps [sam=3D%d, phase_seg2=
=3D%d phase_seg1=3D%d prop_seg=3D%d sjw=3D%d brp=3D%d] ",
> > +                bt->bitrate, bt->sample_point, bt->phase_seg2, bt-=
>phase_seg1, bt->prop_seg, bt->sjw, bt->brp);
> > +
> > +    if (dev->adapter->device_set_bittiming)
> > +        err =3D dev->adapter->device_set_bittiming(dev, bt);
> > +
> > +    else {
> > +        printk("not supported");
> Use e.g. dev_warn or whatever.

Not sure: this "printk()" occurs next to above "netdev_info()" which fo=
rmat string doesn't end with any trailing '\n'

> > +        err =3D 0;
> > +    }
> > +
> > +    if (err)
> > +        printk(" failure (err %d)", err);
> > +    printk("\n");
> > +
> > +    return err;
> I would generally recommend to fix up the whole function. Dedicated e=
rr=20
> variable looks a bit too much cause it is only used to print error va=
lue=20
> for dev_set_bittiming.

=2E.. because of nested printk() (see pcan_usb_set_bittiming() and pcan=
_usb_pro_set_bittiming() functions in their resp. source files), I'm ob=
liged to follow the sequence of that code, except if having a local var=
iable for the handling of dev_set_bittiming() status is worse than seve=
ral calls to printk("\n")...

> > +}
> > +
> > +static int pcan_usb_pro_wait_response(struct peak_usb_device *dev,
> > +                                      struct pcan_usb_pro_msg_t *p=
um)
> > +{
> > +    u8 req_data_type, req_channel;
> > +    int actual_length;
> > +    int i, err =3D 0;
> > +
> > +    /* usb device unregistered? */
> > +    if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> > +
> > +    /* first, keep in memory the request type and the eventual cha=
nnel */
> > +    /* to filter received message */
> > +    req_data_type =3D pum->u.rec_buffer[4];
> > +    req_channel =3D pum->u.rec_buffer[5];
> > +
> > +    /* then, clear number of records to be sure to receive a real =
response */
> > +    /* from the device */
> > +    *pum->u.rec_counter =3D 0;
> > +    mdelay(5);
> I wonder if this delay is really necessary as usb_bulk_msg is waits a=
=20
> finite time to finish.
>=20

I removed it, then checked that it wasn't, thanks!

> > +    for (i =3D 0; !err&&  i<  PCAN_USBPRO_RSP_SUBMIT_MAX; i++) {
> > +        struct pcan_usb_pro_msg_t rsp;
> > +        u32 r, rec_counter;
> > +        u8 *pc;
> > +
> > +        err =3D usb_bulk_msg(dev->udev,
> > +                           usb_rcvbulkpipe(dev->udev, PCAN_USBPRO_=
EP_CMDIN),
> > +        &pum->u.rec_buffer[0], pum->rec_buffer_len,
> > +        &actual_length, PCAN_USBPRO_COMMAND_TIMEOUT);
> > +        if (err) {
> > +            netdev_err(dev->netdev, "waiting response failure: %d\=
n", err);
> > +            break;
> > +        }
> > +
> > +        if (actual_length =3D=3D 0) {
> > +            continue;
> > +        }
> > +
> > +        if (actual_length<  PCAN_USB_PRO_MSG_HEADER_LEN) {
> > +            netdev_err(dev->netdev, "got abnormal too small respon=
se (len=3D%d)\n",
> > +                       actual_length);
> > +            err =3D -EBADMSG;
> > +            break;
> > +        }
> > +   =20
> > +        pc =3D pcan_usb_pro_msg_init(&rsp,&pum->u.rec_buffer[0], a=
ctual_length);
> > +
> > +        rec_counter =3D le32_to_cpu(*rsp.u.rec_counter);
> > +
> > +        for (r =3D 0; r<  rec_counter; r++) {
> > +            union pcan_usb_pro_rec_t *pr =3D (union pcan_usb_pro_r=
ec_t *)pc;
> > +            int rec_size =3D pcan_usb_pro_sizeof_rec(pr->data_type=
);
> > +            if (rec_size<=3D 0) {
> > +                netdev_err(dev->netdev, "got unprocessed record in=
 msg\n");
> > +                dump_mem("received response msg",
> > +                &pum->u.rec_buffer[0], actual_length);
> > +                err =3D -EBADMSG;
> > +                break;
> > +            }
> > +
> > +            /* check if the response corresponds to the request */
> > +            if (pr->data_type !=3D req_data_type) {
> Empty statement.
> > +            }
> > +
> > +            /* check if the channel in the response corresponds to=
 the request */
> > +            else if ((req_channel !=3D 0xff)&&  (pr->bus_activity.=
channel !=3D req_channel)) {
> Dito.
> > +            }
> > +
> > +            /* got the response */
> > +            else return 0;
> Optimize the if/else if/else statement to also ge rid of the empty=20
> statements.

Sorry for that... These empty statements come from an unifdef pass whic=
h removes some DEBUG #ifdef/#endif... Now, the if statement has been in=
cluded into the block or  #ifdef/#endif have been removed.

> > +
> > +            /* otherwise, go on with next record in message */
> > +            pc +=3D rec_size;   =20
> > +        }
> > +
> > +        if (r>=3D rec_counter) {
> Empty statement. Remove it.

See above.

> > +        }
> > +    }
> > +
> > +    return (i>=3D PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
> > +}
> > +
> > +static int pcan_usb_pro_request(struct peak_usb_device *dev, int r=
eq_id, int req_value, void *req_addr, int req_size)
> > +{
> > +    int err;
> > +    u8 req_type;
> > +    unsigned int p;
> > +
> > +    /* usb device unregistered? */
> > +    if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> > +
> > +    memset(req_addr, '\0', req_size);
> > +
> > +    req_type =3D USB_TYPE_VENDOR | USB_RECIP_OTHER;
> > +    switch (req_id) {
> > +    case USB_VENDOR_REQUEST_FKT:
> > +        /* Host to device */
> > +        p =3D usb_sndctrlpipe(dev->udev, 0);
> > +        break;
> > +
> > +    case USB_VENDOR_REQUEST_INFO:
> > +    default:
> > +        /* Device to host */
> > +        p =3D usb_rcvctrlpipe(dev->udev, 0);
> > +        req_type |=3D USB_DIR_IN;
> Missing break.

Ok.

> > +    }
> > +
> > +    err =3D usb_control_msg(dev->udev,
> > +                          p,
> > +                          req_id,
> > +                          req_type,
> > +                          req_value,
> > +                          0, req_addr, req_size,
> > +                          2*USB_CTRL_GET_TIMEOUT);
> > +    if (err<  0)
> > +        netdev_info(dev->netdev,
> > +                    "unable to request usb[type=3D%d value=3D%d] e=
rr=3D%d\n",
> > +                    req_id, req_value, err);
> > +    else {
> > +        //dump_mem("request content", req_addr, req_size);
> > +        err =3D 0;
> > +    }
> > +
> > +    return err;
> > +}
> > +
> > +
> > +/*
> > + * called when driver module is being unloaded:
> > + *
> > + * rmmod when plugged  =3D>  module_exit =3D>  device_exit, then
> > + *                                       usb_deregister(), then
> > + *                                       device_stop, then
> > + *                        module_disconnect =3D>  device_free
> > + * rmmod but unplugged =3D>  module_exit
> > + * unplug              =3D>  module_disconnect =3D>  device_free
> > + *
> > + * (last change to send something on usb)
> > + */
> > +static void pcan_usb_pro_exit(struct peak_usb_device *dev)
> > +{
> > +    struct pcan_usb_pro_device *pdev =3D (struct pcan_usb_pro_devi=
ce *)dev;
> > +
> > +    /* when rmmod called before unplug and ifconfig down, MUST res=
et things */
> > +    /* before leaving */
> > +    if (dev->can.state !=3D CAN_STATE_STOPPED) {
> > +
> > +        /* set bus off on the corresponding channel */
> > +        pcan_usb_pro_set_bus(dev, 0);
> > +    }
> > +
> > +    /* if channel #0 (only) =3D>  tell PCAN-USB-PRO the can driver=
 is being */
> > +    /* unloaded */
> > +    if (dev->ctrl_index =3D=3D 0) {
> > +
> > +        /* turn off calibration message if any device were opened =
*/
> > +        if (pdev->usb_if->dev_opened_count>  0)
> > +            pcan_usb_pro_set_calibration_msgs(dev, 0);
> > +
> > +        /* tell the PCAN-USB-PRO device that drive is being unload=
ed */
> > +        pcan_usb_pro_driver_loaded(dev, 0, 0);
> > +
> > +        /* this device needs also to be resetted when driver is un=
loaded */
> > +        /* TODO hangs when rmmod */
> Then fix it. ;-)

=2E.. or remove the comment ;-))

So, comment is in fact to be removed since the issue didn't exist at al=
l.

> > +        //if (dev->udev)
> > +        //    usb_reset_device(dev->udev);
> > +    }
> > +}
> > +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
Geschaeftsleitung: A.Gach/U.Wilhelm, HRB 9183 Darmstadt, Ust.IdNr.:DE 2=
02 220 078=20
St.Nr.:007/241/13586 FA Darmstadt, WEE-Reg.-Nr.: DE39305391
Tel.:+49 (0)6151 8173-20 - Fax:+49 (0)6151 8173-29=20
E-mail: info@peak-system.com - http://www.peak-system.com 