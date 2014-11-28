From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 3/3] can/peak_usb: CAN-FD: driver's core modifications
Date: Fri, 28 Nov 2014 11:03:11 +0100
Message-ID: <5478485F.2000809@peak-system.com>
References: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com>
 <1417084329-8997-4-git-send-email-s.grosjean@peak-system.com>
 <54770E77.8080108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:46720 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaK1KMN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Nov 2014 05:12:13 -0500
In-Reply-To: <54770E77.8080108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Oliver,

Le 27/11/2014 12:43, Oliver Hartkopp a =E9crit :
> Hello Stephane,
>
> I have two more questions:
>
> On 27.11.2014 11:32, Stephane Grosjean wrote:
>
>> @@ -322,7 +341,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struc=
t=20
>> sk_buff *skb,
>>       }
>>
>>       context->echo_index =3D i;
>> -    context->dlc =3D cf->can_dlc;
>> +
>> +    /* Note: this works with CANFD frames too */
>> +    context->data_len =3D cf->can_dlc;
>>
>>       usb_anchor_urb(urb, &dev->tx_submitted);
>>
>
> Even with this comment the assignment looks fishy.
>
> What about defining
>
>     struct canfd_frame *cfd =3D (struct can_frame *)skb->data;
>
> instead of
>
>     struct can_frame *cf =3D (struct can_frame *)skb->data;
>
> at the top of the function and assign
>
>     context->data_len =3D cfd->len;
>
> ??
>

Simply because I always think in terms of being compatible with (very)=20
older versions of the Kernel, for example <=3D 3.5, which is obviously =
not=20
the right (TM) way of thinking when pushing code into the mainline=20
Kernel ;-) !
So I agree with you and will do the changes accordingly.

>
>> @@ -679,19 +700,43 @@ static int peak_usb_set_mode(struct net_device=
=20
>> *netdev, enum can_mode mode)
>>   }
>>
>>   /*
>> - * candev callback used to set device bitrate.
>> + * candev callback used to set device nominal bitrate.
>
> Is this the nominal bitrate or the arbitration bitrate ?
>
> What about stating both:
> candev callback used to set device nominal/arbitration bitrate.

Okay!

>
>
>> @@ -735,7 +780,7 @@ static int peak_usb_create_dev(struct=20
>> peak_usb_adapter *peak_usb_adapter,
>>       dev->cmd_buf =3D kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
>>       if (!dev->cmd_buf) {
>>           err =3D -ENOMEM;
>> -        goto lbl_set_intf_data;
>> +        goto lbl_free_candev;
>
> These label changes
>
>>       }
>>
>>       dev->udev =3D usb_dev;
>> @@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct=20
>> peak_usb_adapter *peak_usb_adapter,
>>       dev->can.clock =3D peak_usb_adapter->clock;
>>       dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_cons=
t;
>>       dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
>> +    dev->can.data_bittiming_const =3D=20
>> &peak_usb_adapter->data_bittiming_const;
>> +    dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>>       dev->can.do_set_mode =3D peak_usb_set_mode;
>> -    dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>> -                      CAN_CTRLMODE_LISTENONLY;
>> +    dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_supp=
orted;
>>
>>       netdev->netdev_ops =3D &peak_usb_netdev_ops;
>>
>> @@ -770,12 +816,11 @@ static int peak_usb_create_dev(struct=20
>> peak_usb_adapter *peak_usb_adapter,
>>       usb_set_intfdata(intf, dev);
>>
>>       SET_NETDEV_DEV(netdev, &intf->dev);
>> -    netdev->dev_id =3D ctrl_idx;
>>
>>       err =3D register_candev(netdev);
>>       if (err) {
>>           dev_err(&intf->dev, "couldn't register CAN device: %d\n",=20
>> err);
>> -        goto lbl_free_cmd_buf;
>> +        goto lbl_set_intf_data;
>
> here
>
>>       }
>>
>>       if (dev->prev_siblings)
>> @@ -788,14 +833,14 @@ static int peak_usb_create_dev(struct=20
>> peak_usb_adapter *peak_usb_adapter,
>>       if (dev->adapter->dev_init) {
>>           err =3D dev->adapter->dev_init(dev);
>>           if (err)
>> -            goto lbl_free_cmd_buf;
>> +            goto lbl_unregister;
>
> here
>
>>       }
>>
>>       /* set bus off */
>>       if (dev->adapter->dev_set_bus) {
>>           err =3D dev->adapter->dev_set_bus(dev, 0);
>>           if (err)
>> -            goto lbl_free_cmd_buf;
>> +            goto lbl_unregister;
>
> here
>
>>       }
>>
>>       /* get device number early */
>> @@ -807,11 +852,14 @@ static int peak_usb_create_dev(struct=20
>> peak_usb_adapter *peak_usb_adapter,
>>
>>       return 0;
>>
>> -lbl_free_cmd_buf:
>> -    kfree(dev->cmd_buf);
>> +lbl_unregister:
>> +    unregister_netdev(netdev);
>>
>>   lbl_set_intf_data:
>>       usb_set_intfdata(intf, dev->prev_siblings);
>> +    kfree(dev->cmd_buf);
>> +
>> +lbl_free_candev:
>>       free_candev(netdev);
>
> and here ...
>
> Are these changes necessary for the current PCAN USB driver too?
> Should they go into the stable tree with a separate patch?
>
> If so this separate patch should be the first in the series to be pic=
ked.
>
> There's something like this in patch 1/3 too - will send it after thi=
s=20
> mail.

Ok! I will prepare a single patch for these changes.

>
> Regards,
> Oliver

Regards,

St=E9phane

> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
