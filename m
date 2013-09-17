From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v3] slcand: add slcan_attach and UART settings
Date: Tue, 17 Sep 2013 14:08:52 +0200
Message-ID: <CAGm1_ktuqnHg3miwuONk+N8LrvHvHdKdr=yq+soA6kqfqWHLTg@mail.gmail.com>
References: <1379067102-27741-1-git-send-email-yegorslists@googlemail.com>
 <5232F733.2040707@i2se.com> <5236147D.8020200@hartkopp.net>
 <5236AFCC.1090909@hartkopp.net> <52380342.5060408@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:48780 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3IQMJO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Sep 2013 08:09:14 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so2142227bkb.31
        for <linux-can@vger.kernel.org>; Tue, 17 Sep 2013 05:09:12 -0700 (PDT)
In-Reply-To: <52380342.5060408@i2se.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Tue, Sep 17, 2013 at 9:22 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 16.09.2013 09:14, schrieb Oliver Hartkopp:
>
>> On 15.09.2013 22:11, Oliver Hartkopp wrote:
>>
>>> There's still one warning left:
>>>
>>> slcand.c: In function 'daemonize':
>>> slcand.c:180:8: warning: variable 'dummyFile' set but not used
>>> [-Wunused-but-set-variable]
>>>    FILE *dummyFile;
>>>          ^
>>>
>> Fixed :-)
>>
>> BR,
>> Oliver
>>
>
> Thank you Oliver.

We did it! Thank you Oliver and Stefan.

By the way Buildroot has the newest can-utils version already.

Yegor
