From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: ti_hecc: canfdtest rx freeze
Date: Tue, 21 Feb 2017 16:03:52 +0100
Message-ID: <CAGm1_kvh0dZ__4vCdHi36Y+8krD+DH9xk_MxJ=4UU3oXEDV0Vg@mail.gmail.com>
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
 <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de> <CAGm1_ksvsQWPUriKv=zyjW_JR7GNMt=43tOnphuE=ayNT6TH0g@mail.gmail.com>
 <bb8046f4-efad-cb65-29da-8542daacc961@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35868 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753498AbdBUPEP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2017 10:04:15 -0500
Received: by mail-wr0-f195.google.com with SMTP id z61so14763760wrc.3
        for <linux-can@vger.kernel.org>; Tue, 21 Feb 2017 07:04:15 -0800 (PST)
In-Reply-To: <bb8046f4-efad-cb65-29da-8542daacc961@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, "Grim, Dennis" <Dennis.Grim@teejet.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>

On Mon, Feb 20, 2017 at 11:28 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/20/2017 11:04 AM, Yegor Yefremov wrote:
>>> Does the ti_hecc core have a RX timestamp per mailbox? Then you can make
>>> use of the rx_offload helper.
>>
>> Yes, it does. See Section "23.10.2.2 Message Object Time Stamp
>> Registers (CANMOTS)". What drivers use such a feature? Only PEAK so
>> far?
>>
>>         /* convert timestamp into kernel time */
>>         peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
>>         hwts = skb_hwtstamps(skb);
>>         hwts->hwtstamp = timeval_to_ktime(tv);
>>
>> Why should this help to resolve freezing issue?
>
> David Jander and me created the rx-offload helper, which abstracts the
> reading of the mailboxes for controllers with real fifos or mailboxes
> which are filled in a particular order. The timestamp of the mailbox is
> used to sort the CAN frames into chronological order.
>
> The flexcan driver has been ported to that helper, see:
>
> 30164759db1b can: flexcan: make use of rx-offload's irq_offload_fifo
> b3cf53e988ce can: flexcan: add support for timestamp based rx-offload

Thanks. I'll take a look at this.

Yegor
