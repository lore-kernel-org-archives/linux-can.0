From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: ti_hecc: canfdtest rx freeze
Date: Mon, 20 Feb 2017 11:04:40 +0100
Message-ID: <CAGm1_ksvsQWPUriKv=zyjW_JR7GNMt=43tOnphuE=ayNT6TH0g@mail.gmail.com>
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
 <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33365 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbdBTKFD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 05:05:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so13400491wmv.0
        for <linux-can@vger.kernel.org>; Mon, 20 Feb 2017 02:05:02 -0800 (PST)
In-Reply-To: <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, "Grim, Dennis" <Dennis.Grim@teejet.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>

On Mon, Feb 20, 2017 at 10:21 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/20/2017 10:08 AM, Yegor Yefremov wrote:
>> I have a trouble with ti_hecc driver. When doing tx I have no
>> problems, but rx path freezes after about 18 frames.
>>
>> The problem is that in ti_hecc_rx_poll() the while loop will be left
>> when we flip the mailboxes:
>>
>>                 } else if (priv->rx_next == HECC_MAX_TX_MBOX - 1) {
>>                         priv->rx_next = HECC_RX_FIRST_MBOX;
>>                         break;
>>                 }
>>
>> but, if there are still unhandled packets we leave the routine without
>> enabling RX mailbox interrupts. So if we don't receive any other
>> interrupts CAN interface "freezes". So removing break fixes this
>> issue.
>>
>> But when running canfdtest -vv can0 for example against PEAK's USB-CAN
>> ti_hecc stops to receive frames after about 1 minute. Invoking "ip
>> link set can0 down" freezes the system.
>>
>> I've applied Wolfgang's patch from 12.12.2016 with multiple spin_lock
>> fixes, but it didn't improve the situation.
>>
>> Any idea?
>
> Does the ti_hecc core have a RX timestamp per mailbox? Then you can make
> use of the rx_offload helper.

Yes, it does. See Section "23.10.2.2 Message Object Time Stamp
Registers (CANMOTS)". What drivers use such a feature? Only PEAK so
far?

        /* convert timestamp into kernel time */
        peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
        hwts = skb_hwtstamps(skb);
        hwts->hwtstamp = timeval_to_ktime(tv);

Why should this help to resolve freezing issue?

Yegor
