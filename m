From: Brennan Ashton <bashton@brennanashton.com>
Subject: Re: MCP251x bit rate calculations wrong
Date: Mon, 28 Oct 2013 08:50:29 -0700
Message-ID: <CANQdSEHertsyR2Zbs7XrC9W3nqe=D5yQjKE=qJqC7q1wXZtVeQ@mail.gmail.com>
References: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com>
	<CANQdSEHbU1PfoLG4oOK+epKOp-pyn3n9E4xCsHJQMh5Y9znTng@mail.gmail.com>
	<526E214A.9090108@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39908 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004Ab3J1Pua (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 11:50:30 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so4202952wid.9
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2013 08:50:29 -0700 (PDT)
In-Reply-To: <526E214A.9090108@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Mon, Oct 28, 2013 at 1:33 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10/26/2013 07:26 PM, Brennan Ashton wrote:
>> I did not see this line:
>> 1024 >---priv->can.clock.freq = pdata->oscillator_frequency / 2;$
>>
>> So the kernel driver should be fine but in can utils this should still
>> be fixed for the -1
>
> Can I add your Signed-off-by to the patch?
>
> Marc

Sure,
Signed-off-by: Brennan Ashton <bashton@brennanashton.com>

>
>>
>> diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
>> index ecf5cb6..242e1ef 100644
>> --- a/can-calc-bit-timing.c
>> +++ b/can-calc-bit-timing.c
>> @@ -192,7 +192,7 @@ static void printf_btr_mcp251x(struct
>> can_bittiming *bt, int hd
>>         if (hdr) {
>>                 printf("CNF1 CNF2 CNF3");
>>         } else {
>> -               cnf1 = ((bt->sjw - 1) << 6) | bt->brp;
>> +               cnf1 = ((bt->sjw - 1) << 6) | (bt->brp-1);
>>                 cnf2 = 0x80 | ((bt->phase_seg1 - 1) << 3) | (bt->prop_seg - 1);
>>                 cnf3 = bt->phase_seg2 - 1;
>>                 printf("0x%02x 0x%02x 0x%02x", cnf1, cnf2, cnf3);
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
