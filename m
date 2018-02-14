From: Elenita Hinds <ecathinds@gmail.com>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
Date: Wed, 14 Feb 2018 15:20:40 -0600
Message-ID: <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:43967 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVUl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 16:20:41 -0500
Received: by mail-io0-f196.google.com with SMTP id 72so26691282iom.10
        for <linux-can@vger.kernel.org>; Wed, 14 Feb 2018 13:20:41 -0800 (PST)
In-Reply-To: <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de

Thanks, Kurt and Oliver, for the feedback. The newest bcm changes look better.

Marc:  I'm sorry ... forgot to sign the patch. Hope re-attaching below is ok:

Signed-off-by: Elenita Hinds <ecathinds@gmail.com>


On Wed, Feb 14, 2018 at 2:33 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/14/2018 06:45 PM, Elenita Hinds wrote:
>> Hi all.
>>
>> I was seeing the kernel panic when receiving J1939 packets
>> promiscuously over both can0 and can1
>> (with multi-frame messages). The panic is due to the following line in
>> kernel/softirq.c (line 518):
>>
>> if (!test_and_clear_bit(TASKLET_STATE_SCHED,
>>         &t->state))
>>     BUG();  <=== panic here!!
>>
>> The issue seems similar to a previous patch in can/bcm.c
>> (see commit https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=a06393ed03167771246c4c43192d9c264bc48412),
>> wherein a race condition can occur while the tasklets are being or
>> have terminated and the soft irq is checking the flag at the same
>> time. I mimicked the bcm fix and the panic went away.
>>
>> Below is a proposed fix. Please review.
>
> Can I have your S-o-b?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
