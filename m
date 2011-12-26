From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: [PATCH] Add support for PEAK System PCAN-USB adapter
Date: Mon, 26 Dec 2011 15:21:09 +0100
Message-ID: <4EF882D5.2030407@sebastianhaas.info>
References: <570511.804984079-sendEmail@ubuntu-i386> <4EF4D8A1.9060206@sebastianhaas.info> <4EF855B4.3090207@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:42918 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab1LZOVP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Dec 2011 09:21:15 -0500
In-Reply-To: <4EF855B4.3090207@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Linux-can Mailing List <linux-can@vger.kernel.org>

Hi St=E9phane,

Am 26.12.2011 12:08, schrieb Grosjean Stephane:
>>> +/*
>>> + * start interface
>>> + */
>>> +static int pcan_usb_start(struct peak_usb_device *dev)
>>> +{
>>> + struct pcan_usb *pdev =3D (struct pcan_usb *)dev;
>>> + int err;
>> Initialize err with 0 here.
> Why?
You are right. Forget it.
>>> +
>>> + /* number of bits used in timestamps read from adapter struct */
>>> + peak_usb_init_time_ref(&pdev->time_ref,&pcan_usb);
>>> +
>>> + /* if revision greater than 3, can put silent mode on/off */
>>> + if (dev->device_rev> 3) {
>>> + err =3D pcan_usb_set_silent(dev,
>>> + (dev->can.ctrlmode& CAN_CTRLMODE_LISTENONLY));
>> Remove useless brackets for ctrlmode & LISTENONLY are useless.
> Ok.
>>> + if (err)
>>> + goto start_failed;
>> Return with err.
> Ok.
>>> + }
>>> +
>>> + err =3D pcan_usb_set_ext_vcc(dev, 0);
>>> + if (err)
>>> + goto start_failed;
>>> +
>>> + return 0;
>>> +
>>> +start_failed:
>> Remove the 6 lines above.
> Ok.
>>> + return err;
>>> +}
>
> So, what do you think about that:
>
> /*
> * start interface
> */
> static int pcan_usb_start(struct peak_usb_device *dev)
> {
> struct pcan_usb *pdev =3D (struct pcan_usb *)dev;
>
> /* number of bits used in timestamps read from adapter struct */
> peak_usb_init_time_ref(&pdev->time_ref, &pcan_usb);
>
> /* if revision greater than 3, can put silent mode on/off */
> if (dev->device_rev > 3) {
> int err;
>
> err =3D pcan_usb_set_silent(dev,
> dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY);
> if (err)
> return err;
> }
>
> return pcan_usb_set_ext_vcc(dev, 0);
> }
>
> ?
Much more cleaner. Thanks.

Cheers,
  Sebastian
