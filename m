From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 19:46:41 +0200
Message-ID: <CABkP77c1N_b=xtA_Hz=ZxYNDS6FxJEFhi4yhhpST-kfS4wx2zg@mail.gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
	<4F852161.90706@hartkopp.net>
	<CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
	<4F85D553.2010303@hartkopp.net>
	<CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
	<4F86862C.5020007@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38962 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757847Ab2DLRqn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 13:46:43 -0400
Received: by wejx9 with SMTP id x9so1413968wej.19
        for <linux-can@vger.kernel.org>; Thu, 12 Apr 2012 10:46:42 -0700 (PDT)
In-Reply-To: <4F86862C.5020007@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Thu, Apr 12, 2012 at 9:37 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> It stays on for some time after each frame. Above a certain
>> packet-rate (1/led_off_delay) LED appear to be constantly on. You can
>> tell periodic packets from bursts from it but nothing more.
>
> Concerning the LED control (on. off, blinking), could that not be
> done/configured in the generic LED interface (via sysfs files)? That
> seems the right place for me. Then the CAN LED software just needs to
> send the trigger which would significantly simplify the code (without
> timer).

Of course, that's possible, but I think a kernel implementation with
timers for blinking and some well placed trigger points would be more
effective that, for example, polling interface stats from userspace.
After all many other subsystems have similar triggers in kernel space
(netfilter, ide/ata with timers, mtd, mmc, mac80211 without triggers).

> Furthermore, if I understand your patch correctly, the LEDs with the
> names "canX-rx" and "canX-tx" are directly assigned (hardwired). A more
> flexible method would be appreciated, if it could be realized with just
> a little more code.

Well, they are just sprintf-ed from initial interface name, that's
also how mac80211 implementation works. Can you be more specific on
how should I change it? Like following interface rename or so?

Regards.

-- 
Fabio Baltieri
