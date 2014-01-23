From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: slcand: tty device name
Date: Thu, 23 Jan 2014 09:18:34 +0100
Message-ID: <CAGm1_kvUnm5ZzKZ28he8uzTpz5RPfX0E-G6bE2LU_vxyn5KjwA@mail.gmail.com>
References: <CAGm1_ks=hrhb4WTs9jiqgViYOmAAC+dnLCc5LpXP8TWMe65Yrw@mail.gmail.com>
 <52E0CFF6.5080701@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44152 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbaAWISz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 03:18:55 -0500
Received: by mail-bk0-f46.google.com with SMTP id r7so232319bkg.33
        for <linux-can@vger.kernel.org>; Thu, 23 Jan 2014 00:18:54 -0800 (PST)
In-Reply-To: <52E0CFF6.5080701@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

On Thu, Jan 23, 2014 at 9:16 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01/23/2014 08:21 AM, Yegor Yefremov wrote:
>> Hi Oliver and Marc,
>>
>> what is the reason for slcand accepting only tty* and not both
>> variants tty* and /dev/tty*?
>
> I don't know, it was added this way to the repository. Ask Robert Haddon
> <robert.haddon@verari.com>, the original author. I think you can
> contribute a patch so that it accepts /dev/tty*, too.

Will contribute.

Yegor
