From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: iso-tp: timeout handling for unknown packet size
Date: Wed, 23 Oct 2013 18:50:29 +0200
Message-ID: <CAJA4uhe4VmLKXrk+CrurZLZ-wJGnvxtKr3jUbaiVZ7ZrKQHf4w@mail.gmail.com>
References: <CAJA4uhcj+ySw1j64vz4Ao1t62YzYcZfoNLkjsmFg-Pqf+mjy4g@mail.gmail.com>
 <CABLFF-=Rxi7Gtpr+OD5q5QsjD5fnrcZQaTJFoeT9a8UzuMbSEA@mail.gmail.com> <5267F2B9.2000704@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62039 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3JWQuu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2013 12:50:50 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so1090078obb.3
        for <linux-can@vger.kernel.org>; Wed, 23 Oct 2013 09:50:50 -0700 (PDT)
In-Reply-To: <5267F2B9.2000704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Nathan Conrad <nconrad.mlock@gmail.com>, linux-can <linux-can@vger.kernel.org>, Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>

2013/10/23 Oliver Hartkopp <socketcan@hartkopp.net>:
> On 23.10.2013 16:40, Nathan Conrad wrote:
>> You could also add a filter for the ISO-TP reception ID to a raw
>> protocol socket and monitor the reception of packets that way.  Non
>> ISO-TP packets shouldn't be on that ID.
We thought of that, the problem is we have to wake the process up by
receiving each frame if we don't only want to detect the presence of
an ECU but also if it's still responding or if there have been a
problem during transfer.

>> Nathan Conrad
>
> Yes. This would be an idea.
>
> You could also create a CAN_BCM socket to detect a timeout on a given CAN-ID.
That's a neat idea. We are not familiar with the broadcast manager but
we will look further into it.

> See the BCM documentation(s) at
>
>         http://marc.info/?l=linux-can&m=138217795117288&w=2
>
> or the tst-bcm-*.c examples at
>
>         https://gitorious.org/linux-can/can-tests/
Thanks

> With the BCM you can put the timeout handling completely into the kernel.
That's what we were hoping was possible.


Regards,
-- 
Josselin Costanzi
  Embedded Linux System Engineer
