From: Amr Bekhit <amrbekhit@gmail.com>
Subject: Re: Flooding AT91_CAN peripheral with messages causes it to stop
 receiving any more messages
Date: Fri, 10 Jun 2016 14:34:52 +0100
Message-ID: <CAOLz05p2BjO3aH-_4600YK+GuprLcNXCz74Y60rbh79+v35T5w@mail.gmail.com>
References: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
 <1834894.mYn6oCiL2x@ws-stein> <57275BE6.5060905@grandegger.com>
 <CAOLz05qzdyPk2CoUZH4F0-b5syJDQehN6rEBoVo-7fpngQgxPw@mail.gmail.com>
 <CAOLz05qKWrDK2f6tg9wyY6HsQp1m=jvN+KF4v5z2u0xUakSQCw@mail.gmail.com>
 <57513038.2080107@grandegger.com> <CAOLz05oGGuXA+R=rFkk1uP0fpqPdq4JKx3L_-cowpj1h2gAC6A@mail.gmail.com>
 <5757D94A.4090802@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35349 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbcFJNfT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2016 09:35:19 -0400
Received: by mail-wm0-f47.google.com with SMTP id v199so149189121wmv.0
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2016 06:35:18 -0700 (PDT)
In-Reply-To: <5757D94A.4090802@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, mkl@pengutronix.de, linux-can@vger.kernel.org

> Good news. I'm going to prepare a patch for mainline inclusion. Can I add
> your "Tested-by: Amr Bekhit <amrbekhit@gmail.com>" ?

Yes, that's fine.

> BTW, did you realize message overflows (with "ip -d -s link show") or
> related out-of-order messages in the kernel log ("dmesg").

Not sure what you mean - I have seen the "out-of-order" messages
before. Basically, I'm using a PCAN-USB to send messages continuously
to my unit using the packaged Windows software. After the unit has
been running for a while, the TX buffer gets full. I can press Esc to
clear it and then I get a "order of packets cannot be guaranteed"
message on my unit. I haven't used the ip -d -s link show command
before, I'll check it out, thanks.
