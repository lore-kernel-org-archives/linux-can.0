From: Abdul Khan <akhan@symboticware.com>
Subject: Re: Strange error with jspy utility
Date: Thu, 24 May 2012 15:52:59 -0400
Message-ID: <CA+cPUuTFWk85r2Ukd9Lm=Gz95229WXT3uJZzPzDRATbNggPF+w@mail.gmail.com>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
	<20120519051517.GA416@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34274 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab2EXTxA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 May 2012 15:53:00 -0400
Received: by pbbrp8 with SMTP id rp8so708080pbb.19
        for <linux-can@vger.kernel.org>; Thu, 24 May 2012 12:53:00 -0700 (PDT)
In-Reply-To: <20120519051517.GA416@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt

Thanks for your response, I was away for few days. Please see below my
findings in-line.

> From your story, I assume you connected can0 & can1 together?

Yes, can0 and can1 are connected together.
can0 hi   <--> can1 hi
can0 lo   <--> can1 lo
can0 grd <--> can1 grd

> I cannot look on your CAN bus. I'd need a raw CAN dump too
> if I want to really debug this remotely.

./cansend can0 123#1122334455667788

./candump can1

Output:
=====
can1 123 [8] 11 22 33 44 55 66 77 88

> $ ./jsr can0:20,feda &
> $ echo "hello" | ./jsr can1:40,feda

I did try with this.

> Then, you will see the seond instance of jsr terminating
> quite soon, after having sent 1 packet.

Yes, second instance of jsr terminating, after having sent 1 packet.

> The first instance of jsr will receive that (via CAN) and print
> on stdout.
>
> $ jspy
> should then show 1 packet.
>

./jspy -P -v

Output:
=====
can0:40, 0feda - !6 [6] 68656c6c 6f0a
                      - !6 [6] 68656c6c 6f0a

Thanks
Abdul.
