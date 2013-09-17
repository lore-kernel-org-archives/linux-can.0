From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v3] slcand: add slcan_attach and UART settings
Date: Tue, 17 Sep 2013 09:22:42 +0200
Message-ID: <52380342.5060408@i2se.com>
References: <1379067102-27741-1-git-send-email-yegorslists@googlemail.com> <5232F733.2040707@i2se.com> <5236147D.8020200@hartkopp.net> <5236AFCC.1090909@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55653 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3IQHXK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Sep 2013 03:23:10 -0400
In-Reply-To: <5236AFCC.1090909@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: yegorslists@googlemail.com, linux-can@vger.kernel.org, mkl@pengutronix.de

Am 16.09.2013 09:14, schrieb Oliver Hartkopp:
> On 15.09.2013 22:11, Oliver Hartkopp wrote:
>
>> There's still one warning left:
>>
>> slcand.c: In function 'daemonize':
>> slcand.c:180:8: warning: variable 'dummyFile' set but not used [-Wunused-but-set-variable]
>>    FILE *dummyFile;
>>          ^
>>
> Fixed :-)
>
> BR,
> Oliver
>

Thank you Oliver.

Best Regards

Stefan
