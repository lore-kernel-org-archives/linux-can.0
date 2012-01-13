From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: loopback/recv own messages option not working as expected with
 plx_pci (Adlink Technology PCI-7841)
Date: Fri, 13 Jan 2012 09:06:54 +0100
Message-ID: <CAJsOQGMFQsgy3LGGUDjUE7Jhpr8Jv+Voa_+z0hjezh5usibDew@mail.gmail.com>
References: <CAJsOQGNE959CjAJUCQzxqh_zyrLj-Ed=-RDYBvJq9OrtScMkKw@mail.gmail.com>
	<4F0F1109.6090300@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57838 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab2AMIG4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2012 03:06:56 -0500
Received: by wgbds12 with SMTP id ds12so2773357wgb.1
        for <linux-can@vger.kernel.org>; Fri, 13 Jan 2012 00:06:54 -0800 (PST)
In-Reply-To: <4F0F1109.6090300@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On Thu, Jan 12, 2012 at 5:57 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> Has someone seen something similar with that driver? I'd just like to
>> ask before digging into it.
>
> No - i assume you are using a 2.6.30.x (0 <= x < 5) kernel, right?

No, it's a 2.6.38 packaged by Ubuntu - nothing special:

2.6.38-11-generic-pae #49-Ubuntu SMP

> See
>
> http://old.nabble.com/Local-loopback-broken--td24108048.html

Hm. Corresponding to your post this issues was fixed in 2.6.30.5, so
it should be included in my kernel for sure.

I have another machine here, equipped with the same card:

2.6.32-122-rtai #rtai SMP from
http://www.linuxcnc.org/emc2 lucid base emc2.4

Here everything works fine.

I'll try a different kernel on the box that is not working.

Thanks,

Felix
