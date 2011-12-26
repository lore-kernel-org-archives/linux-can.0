From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: [PATCH] Add support for PEAK System PCAN-USB adapter
Date: Mon, 26 Dec 2011 12:08:36 +0100
Message-ID: <4EF855B4.3090207@peak-system.com>
References: <570511.804984079-sendEmail@ubuntu-i386> <4EF4D8A1.9060206@sebastianhaas.info>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-1d.bbox.fr ([194.158.122.56]:35688 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab1LZLIj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 26 Dec 2011 06:08:39 -0500
In-Reply-To: <4EF4D8A1.9060206@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Linux-can Mailing List <linux-can@vger.kernel.org>

Hi Sebastian,

Le 23/12/2011 20:38, Sebastian Haas a =E9crit :
> Hi St=E9phane,
>
> find a few comments from me below.
>
> Cheers,
>  Sebastian
>
> Am 22.12.2011 14:13, schrieb Stephane Grosjean:
>> +/*
>> + * read serial number from device
>> + */
>> +static int pcan_usb_get_serial(struct peak_usb_device *dev, u32=20
>> *serial_number)
>> +{
>> +    u8 args[PCAN_USB_PARAMETER_LEN];
>> +    int err;
>> +
>> +    err =3D pcan_usb_wait_rsp(dev, 6, 1, args);
>> +    if (err)
>> +        netdev_err(dev->netdev, "getting serial failure: %d\n", err=
);
>> +
> Remove empty line an but the initial if() also in brackets.
Ok.
>> +    else if (serial_number) {
>> +        u32 tmp32;
>> +        memcpy(&tmp32, args, 4);
>> +        *serial_number =3D le32_to_cpu(tmp32);
>> +    }
>> +
>> +    return err;
>> +}
>> +
>> +/*
>> + * read device id from device
>> + */
>> +static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32=20
>> *device_id)
>> +{
>> +    u8 args[PCAN_USB_PARAMETER_LEN];
>> +    int err;
>> +
>> +    err =3D pcan_usb_wait_rsp(dev, 4, 1, args);
>> +    if (err)
>> +        netdev_err(dev->netdev, "getting device id failure: %d\n",=20
>> err);
>> +
> Empty line.
Ok.
>> +    else if (device_id)
>> +        *device_id =3D args[0];
>> +
>> +    return err;
>> +}
>> +
>> +/*
>> + * decode non-data usb message
>> + */
>> +static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
>> +    u8 status_len)
>> +{
>> +    u8 rec_len =3D (status_len&  PCAN_USB_STATUSLEN_DLC);
> Brackets are useless.
Ok.
>> +    struct sk_buff *skb;
>> +    struct can_frame *cf;
>> +    struct timeval tv;
>> +    u8 f, n;
>> +
>> +    /* check whether function and number can be read */
>> +    if ((mc->ptr + 2)>  mc->end)
>> +        return -EINVAL;
>> +
>> +    f =3D mc->ptr[0];
>> +    n =3D mc->ptr[1];
>> +    mc->ptr +=3D 2;
>> +
>> +    if (status_len&  PCAN_USB_STATUSLEN_TIMESTAMP) {
>> +        int err =3D pcan_usb_decode_ts(mc, !mc->rec_idx);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    switch (f) {
>> +    case PCAN_USB_REC_ERROR:
>> +        /* no status flag =3D>  ignore record */
>> +        if (!n)
>> +            break;
>> +
>> +        /* ignore this error until 1st ts received */
>> +        if (n =3D=3D PCAN_USB_ERROR_QOVR)
>> +            if (!mc->pdev->time_ref.tick_count)
>> +                break;
>> +
>> +        /* allocate an skb to store the error frame */
>> +        skb =3D alloc_can_err_skb(mc->netdev,&cf);
>> +        if (!skb)
>> +            return -ENOMEM;
>> +
>> +        if (n&  (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
>> +            cf->can_id |=3D CAN_ERR_CRTL;
>> +            cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
>> +            mc->netdev->stats.rx_over_errors++;
>> +            mc->netdev->stats.rx_errors++;
>> +        }
>> +        if (n&  PCAN_USB_ERROR_BUS_OFF) {
>> +            cf->can_id |=3D CAN_ERR_BUSOFF;
>> +            can_bus_off(mc->netdev);
>> +        }
>> +        if (n&  PCAN_USB_ERROR_BUS_HEAVY) {
>> +            cf->can_id |=3D CAN_ERR_CRTL;
>> +            cf->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
>> +            mc->pdev->dev.can.can_stats.error_passive++;
>> +        }
>> +        if (n&  PCAN_USB_ERROR_BUS_LIGHT) {
>> +            cf->can_id |=3D CAN_ERR_CRTL;
>> +            cf->data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
>> +            mc->pdev->dev.can.can_stats.error_warning++;
>> +        }
>> +
>> +        if (cf->can_id !=3D CAN_ERR_FLAG) {
>> +            if (status_len&  PCAN_USB_STATUSLEN_TIMESTAMP) {
>> +                peak_usb_get_ts_tv(&mc->pdev->time_ref,
>> +                    mc->ts16,&tv);
>> +                skb->tstamp =3D timeval_to_ktime(tv);
>> +            }
>> +            netif_rx(skb);
>> +            mc->netdev->stats.rx_packets++;
>> +        } else {
>> +            kfree_skb(skb);
>> +        }
>> +
>> +        break;
>> +
>> +    case PCAN_USB_REC_ANALOG:
>> +        /* analog values (ignored) */
>> +        rec_len =3D 2;
>> +        break;
>> +
>> +    case PCAN_USB_REC_BUSLOAD:
>> +        /* bus load (ignored) */
>> +        rec_len =3D 1;
>> +        break;
>> +
>> +    case PCAN_USB_REC_TS:
>> +        /* only timestamp */
>> +        if (pcan_usb_update_ts(mc))
>> +            return -EINVAL;
>> +        break;
>> +
>> +    case PCAN_USB_REC_BUSEVT:
>> +        /* error frame/bus event */
>> +        if (n&  PCAN_USB_ERROR_TXQFULL)
>> +            netdev_info(mc->netdev, "device Tx queue full)\n");
>> +        break;
>> +
>> +    case PCAN_USB_REC_EXT:
>> +        /* future... */
>> +        break;
>> +
>> +    default:
>> +        netdev_err(mc->netdev, "unexpected function %u\n", f);
>> +        break;
>> +    }
>> +
>> +    if ((mc->ptr + rec_len)>  mc->end)
>> +        return -EINVAL;
>> +
>> +    mc->ptr +=3D rec_len;
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * process incoming message
>> + */
>> +static int pcan_usb_decode_msg(struct peak_usb_device *dev,
>> +    u8 *ibuf, u32 lbuf)
>> +{
>> +    struct pcan_usb_msg_context mc =3D {
>> +        .rec_cnt =3D ibuf[1],
>> +        .ptr =3D ibuf + PCAN_USB_MSG_HEADER_LEN,
>> +        .end =3D ibuf + lbuf,
>> +        .netdev =3D dev->netdev,
>> +        .pdev =3D (struct pcan_usb *)dev,
>> +    };
>> +    int err;
>> +
>> +    for (err =3D 0; mc.rec_idx<  mc.rec_cnt&&  !err; mc.rec_idx++) =
{
>> +        u8 sl =3D *mc.ptr++;
>> +
>> +        /* handle status and error frames here */
>> +        if (sl&  PCAN_USB_STATUSLEN_INTERNAL) {
>> +            err =3D pcan_usb_decode_status(&mc, sl);
>> +
> Remove empty line.
Ok.
>> +        /* handle normal can frames here */
>> +        } else {
>> +            err =3D pcan_usb_decode_data(&mc, sl);
>> +            mc.rec_data_idx++;
>> +        }
>> +    }
>> +
>> +    return err;
>> +}
>> +
>> +/*
>> + * process any incoming buffer
>> + */
>> +static int pcan_usb_decode_buf(struct peak_usb_device *dev, struct=20
>> urb *urb)
>> +{
>> +    int err =3D 0;
>> +
>> +    if (urb->actual_length>  PCAN_USB_MSG_HEADER_LEN) {
>> +        err =3D pcan_usb_decode_msg(dev, urb->transfer_buffer,
>> +            urb->actual_length);
>> +
> Dito.
>> +    } else if (urb->actual_length>  0) {
>> +        netdev_err(dev->netdev, "usb message length error (%u)\n",
>> +            urb->actual_length);
>> +        err =3D -EINVAL;
>> +    }
>> +
>> +    return err;
>> +}
>> +
>> +/*
>> + * start interface
>> + */
>> +static int pcan_usb_start(struct peak_usb_device *dev)
>> +{
>> +    struct pcan_usb *pdev =3D (struct pcan_usb *)dev;
>> +    int err;
> Initialize err with 0 here.
Why?
>> +
>> +    /* number of bits used in timestamps read from adapter struct *=
/
>> +    peak_usb_init_time_ref(&pdev->time_ref,&pcan_usb);
>> +
>> +    /* if revision greater than 3, can put silent mode on/off */
>> +    if (dev->device_rev>  3) {
>> +        err =3D pcan_usb_set_silent(dev,
>> +            (dev->can.ctrlmode&  CAN_CTRLMODE_LISTENONLY));
> Remove useless brackets for ctrlmode & LISTENONLY are useless.
Ok.
>> +        if (err)
>> +            goto start_failed;
> Return with err.
Ok.
>> +    }
>> +
>> +    err =3D pcan_usb_set_ext_vcc(dev, 0);
>> +    if (err)
>> +        goto start_failed;
>> +
>> +    return 0;
>> +
>> +start_failed:
> Remove the 6 lines above.
Ok.
>> +    return err;
>> +}

So, what do you think about that:

/*
  * start interface
  */
static int pcan_usb_start(struct peak_usb_device *dev)
{
         struct pcan_usb *pdev =3D (struct pcan_usb *)dev;

         /* number of bits used in timestamps read from adapter struct =
*/
         peak_usb_init_time_ref(&pdev->time_ref, &pcan_usb);

         /* if revision greater than 3, can put silent mode on/off */
         if (dev->device_rev > 3) {
                 int err;

                 err =3D pcan_usb_set_silent(dev,
                                 dev->can.ctrlmode &=20
CAN_CTRLMODE_LISTENONLY);
                 if (err)
                         return err;
         }

         return pcan_usb_set_ext_vcc(dev, 0);
}

?

Regards,

St=E9phane
