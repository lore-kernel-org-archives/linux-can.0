From: Michal Sojka <michal.sojka@cvut.cz>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
Date: Fri, 03 Apr 2020 15:53:07 +0200
Message-ID: <871rp4he0s.fsf@steelpick.2x.cz>
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com> <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:33017 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCN6S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 09:58:18 -0400
In-Reply-To: <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Andrejus =?utf-8?Q?Fal=C4=8Di?= =?utf-8?Q?kas?= <andrejus.f@8devices.com>, socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org

Hello Wolfgang,

On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
> Hello Andrejus,
>
> please do not remove the history of this conversation! It's very
> difficult to follow what you are speaking about...
>
> Am 03.04.20 um 15:04 schrieb Andrejus Falčikas:
>> Hello Mr. Oliver Hartkopp,
>> 
>> I would like to notify you that the case described as the issue is
>> caused by non-standard use of the device and protocol.

[...]

>
> I observe a similar problem with the GS_USB CAN controller and I have
> posted a patch recently here:
>
>   https://marc.info/?l=linux-can&m=158504888512764&w=2
>
> Could you please give the patch for your device below a try:

It would be great if Andrejus can try the patch. If not, I'll try it
after I get back to work where I have the device. Unfortunately, due to
current situation, I'm not sure when it will happen.

Thanks.
-Michal
