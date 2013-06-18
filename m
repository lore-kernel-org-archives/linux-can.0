From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH] can: usb_8dev: unregister netdev before free()ing
Date: Tue, 18 Jun 2013 22:20:46 +0200
Message-ID: <51C0C11E.1090705@universalnet.at>
References: <1371560243-24316-1-git-send-email-mkl@pengutronix.de> <51C0A5A2.6010909@universalnet.at> <51C0A820.3010102@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:48130 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933069Ab3FRUVI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 18 Jun 2013 16:21:08 -0400
In-Reply-To: <51C0A820.3010102@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Am 2013-06-18 20:34, schrieb Marc Kleine-Budde:
> On 06/18/2013 08:23 PM, Bernd Krumboeck wrote:
>> Am 2013-06-18 14:57, schrieb Marc Kleine-Budde:
>>> The usb_8dev hardware has problems on some xhci USB hosts. The driver
>>> fails to
>>> read the firmware revision in the probe function. This leads to the
>>> following
>>> Oops:
>>>
>>>       [ 3356.635912] kernel BUG at net/core/dev.c:5701!
>>>
>>> The driver tries to free the netdev, which has already been
>>> registered, without
>>> unregistering it.
>>>
>>> This patch fixes the problem by unregistering the netdev in the error
>>> path.
>>>
>>
>> Thank you for the patch!
>>
>> I've applied it to my source tree:
>> https://github.com/krumboeck/usb2can
>
> Can I have you Acked-by or Reviewed-by?
>
> Marc
>

Yes, of course.

Please add "Reviewed-by: Bernd Krumboeck <krumboeck@universalnet.at>".


regards,
Bernd
