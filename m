From: Martin Gysel <m.gysel@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 13:07:08 +0200
Message-ID: <4F86B75C.2040006@gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>	<4F852161.90706@hartkopp.net>	<CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>	<4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com> <4F86862C.5020007@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64546 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab2DLLHM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 07:07:12 -0400
Received: by bkcik5 with SMTP id ik5so1403271bkc.19
        for <linux-can@vger.kernel.org>; Thu, 12 Apr 2012 04:07:11 -0700 (PDT)
In-Reply-To: <4F86862C.5020007@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Am 12.04.2012 09:37, schrieb Wolfgang Grandegger:
> Concerning the LED control (on. off, blinking), could that not be
> done/configured in the generic LED interface (via sysfs files)? That
> seems the right place for me. Then the CAN LED software just needs to
> send the trigger which would significantly simplify the code (without
> timer).
> 
> Furthermore, if I understand your patch correctly, the LEDs with the
> names "canX-rx" and "canX-tx" are directly assigned (hardwired). A more
> flexible method would be appreciated, if it could be realized with just
> a little more code.

maybe something familiar to the led netdev trigger (which is afaik
'still' not mainline...)

https://dev.openwrt.org/ticket/2776

/martin
