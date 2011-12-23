From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Fri, 23 Dec 2011 10:33:48 +0100
Message-ID: <4EF44AFC.60400@peak-system.com>
References: <871799.098418222-sendEmail@ubuntu-i386> <4EF3A40E.4080206@sebastianhaas.info>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-1d.bbox.fr ([194.158.122.56]:61973 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab1LWJdz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 23 Dec 2011 04:33:55 -0500
In-Reply-To: <4EF3A40E.4080206@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

Hi Sebastian,

Le 22/12/2011 22:41, Sebastian Haas a =E9crit :
> Hi again,
>
> some nitpicking this time. ;-)
>
=2E.. I certainly agree with you! But it's good news anyway.

Generally speaking:

- ok for the two missing ending \n
- ok for strncpy instead of strcpy()
- but what about the followings?

> +    struct can_bittiming *bt =3D&dev->can.bittiming;
                                  ^^^ remove whitespace
=2E..

> +    if (sizeof_candev<  sizeof(struct peak_usb_device))
                         ^^^^^^ cleanup

=2E..

> +    netdev->netdev_ops =3D&peak_usb_netdev_ops;
                            ^^^^ whitespace
=2E..

>> +
>> +    SET_NETDEV_DEV(netdev,&intf->dev);
>                              ^^^
>> +
>> +        dev->state&=3D ~PCAN_USB_STATE_CONNECTED;
>                          ^^^^
>> +            if (*pc<  32 || *pc>  127)
>                               ^^^^         ^^
It looks like missing whitespaces sometimes, and sometimes there were=20
too in your text... which is different from the patch I sent yesterday.=
=20
Or do I misunderstand your comments?

>> +
>> +    /* Last chance do send some synchronous commands here */
>> +    err =3D driver_for_each_device(&peak_usb_driver.drvwrap.driver,=
 NULL,
>> +        NULL, peak_usb_do_device_exit);
>> +    if (err)
>> +        err =3D 0;
> \err\ is neither checked nor printed, why not removing it?
>

Because of that (see <linux/device.h>):

extern int __must_check driver_for_each_device(struct device_driver *dr=
v,
            ~~~~~~~~~~~~

=2E.. Is there any other way to get around that?

> You are mixing pr_*, dev_* and netdev_* please check if it is possibl=
e=20
> to harmonize the usage.
>
Ok I'll try do that, whenever it is possible.

> Cheers,
>  Sebastian +

Thanks and regards,

St=E9phane

> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
