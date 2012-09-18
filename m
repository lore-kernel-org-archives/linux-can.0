From: Andrew Bell <andrew.bell.ia@gmail.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 08:36:44 -0500
Message-ID: <CACJ51z2=T1M065ubm6sLt=utWo3ndZAL9YJNdeGQuS=2uR8EZA@mail.gmail.com>
References: <2478881.znSzbTXnK5@uschi>
	<505777BC.3000705@hartkopp.net>
	<CACJ51z1g+A2Hy5SXU=1AmwyDYRuxv=MzsyVjAwiRWaOSRn+h7A@mail.gmail.com>
	<50577B03.60105@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61707 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab2IRNgr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:36:47 -0400
Received: by ieak13 with SMTP id k13so2236787iea.19
        for <linux-can@vger.kernel.org>; Tue, 18 Sep 2012 06:36:44 -0700 (PDT)
In-Reply-To: <50577B03.60105@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Sep 17, 2012 at 2:33 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 17.09.2012 21:26, Andrew Bell wrote:
>
> The TX timeout functionality has been removed a long time ago. There was a
> discussion about that topic that days.
>
> So what kind of driver do you have there? A PEAK PCAN driver?

We're using an old mscan driver.

So, what's supposed to happen?  Does the hardware just attempt to send
once and then drop the packet if no acknowledgement is received?  Is
an error frame generated?  Is the issue being discussed just one where
the application writes faster than the frames can be put onto the bus,
rather than the condition of the bus being bad?

-- 
Andrew Bell
andrew.bell.ia@gmail.com
