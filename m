From: Elenita Hinds <ecathinds@gmail.com>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
Date: Thu, 8 Feb 2018 10:26:28 -0600
Message-ID: <CAHChkrsg7x2HRBuSv=jCE7iBrQM1VAR=2V-BPEUjGHWt4zSfZw@mail.gmail.com>
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
 <20180206203752.GG1198@airbook.vandijck-laurijssen.be> <CAHChkrt1jnY64HJNMinLAc-xaT04i=WyyLug+yVpUew7wqoaAQ@mail.gmail.com>
 <6152a755-dcac-e47c-db38-88d709cc5fb2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:46521 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHQ03 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 11:26:29 -0500
Received: by mail-io0-f195.google.com with SMTP id f34so6370501ioi.13
        for <linux-can@vger.kernel.org>; Thu, 08 Feb 2018 08:26:29 -0800 (PST)
In-Reply-To: <6152a755-dcac-e47c-db38-88d709cc5fb2@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Thanks, Marc. It looks like I'm out of date with the latest j1939
branch by a couple of commits. Will be re-syncing.

On Thu, Feb 8, 2018 at 9:08 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/07/2018 05:41 PM, Elenita Hinds wrote:
>> Thanks for the feedback, Kurt. I'll split into separate patches as
>> suggested for clarity. The additional whitespaces were due to linux
>> kernel styles imposed upon in my environment (enabled and won't let me
>> commit unless I align certain lines).
>
> I've manually picked the (maybe not all) whitespace changes manually and
> added them to linux-can-next/j1939. Please send your patches using git
> not via a webinterface, as it makes the patches unusable.
>
>> I found missing changes in the j1939 notifier block which I think can
>> cause the kernel to panic when a CAN bus interface goes down. This is
>> fixed and will post the changes.
>
> As Kurt said, please make this a seperate patch.
>
>> I also figured out how to complete the TODO item and will post these as well.
>>
>> I'm also trying to coordinate these changes with Oleksij (Rempel) but
>> he is out for the moment.
>>
>> To answer your questions above, based on the kernel examples and
>> implied on the info I've seen, I think almost all need duplicating and
>> this includes the /proc and module parameters (see detailed
>> description in http://apprize.info/linux/kernel/15.html). And yes, the
>> ifindex values can be re-used in different namespaces.
>
> In the j1939 branch proc support has been removed for now.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
