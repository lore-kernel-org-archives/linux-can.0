From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH] genirq: Sanitize spurious interrupt detection of threaded irqs
Date: Mon, 7 Apr 2014 13:05:13 -0700
Message-ID: <CANGgnMbXSosuUTy02QUuqM2bNomrusJVBN_=f6OE8f+NcAdwmQ@mail.gmail.com>
References: <CANGgnMbszHzYe9pF2C6wag4MY_PfBG2qrMCC=rMmQnb-jyXXXw@mail.gmail.com>
	<52CAB05F.4010303@hartkopp.net>
	<CANGgnMZZu6tX0LyK4mQaYhixY9uhbQYee7XO5_HtNfT0REPghA@mail.gmail.com>
	<alpine.DEB.2.02.1404072040320.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:43374 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbaDGUFO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 16:05:14 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so4973051igc.0
        for <linux-can@vger.kernel.org>; Mon, 07 Apr 2014 13:05:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1404072040320.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 7, 2014 at 11:41 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 7 Apr 2014, Austin Schuh wrote:
>
>> Hi Thomas,
>>
>> Did anything come of this patch?  Both Oliver and I have found that it
>> fixes real problems.  I have multiple machines which have been running
>> with the patch since December with no ill effects.
>
> No, sorry. It fell through the cracks. Care to resend ?
>
> Thanks,
>
>         tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

You originally sent the patch out.  I could send your patch out back
to you, but that feels a bit weird ;)

Austin
