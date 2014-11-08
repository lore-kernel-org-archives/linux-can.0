From: Paul Lever <svjeorgia@gmail.com>
Subject: Re: candump error flags
Date: Sat, 8 Nov 2014 10:47:17 -0400
Message-ID: <CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
	<545CD775.1030200@pengutronix.de>
	<545CDD93.1080600@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:50291 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaKHOrS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 09:47:18 -0500
Received: by mail-yk0-f180.google.com with SMTP id 142so2348153ykq.39
        for <linux-can@vger.kernel.org>; Sat, 08 Nov 2014 06:47:17 -0800 (PST)
In-Reply-To: <545CDD93.1080600@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

>> Make sure you're running a recent new kernel (v3.15 or better) as a lot
>> of fixes went into the driver.
>>
>
> E.g. the dropcount functionality emerged in Linux 2.6.33
> So a Debian Squeeze with 2.6.32 won't make it here ...
I am running the c_can driver with the updates to late June.

> ps. additionally "candump -r 16000 -l can0 &" would be better :-)
I need the timestamps.

With berr-reporting enabled I still don't see any messages generated
by the -e and -d options to candump. Looking at my received data I can
see that there are missing sequential packets.

Regards
Paul
