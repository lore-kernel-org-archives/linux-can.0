From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH] can: usb_8dev: unregister netdev before free()ing
Date: Tue, 18 Jun 2013 20:23:30 +0200
Message-ID: <51C0A5A2.6010909@universalnet.at>
References: <1371560243-24316-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:53239 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932824Ab3FRSaw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 18 Jun 2013 14:30:52 -0400
In-Reply-To: <1371560243-24316-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Am 2013-06-18 14:57, schrieb Marc Kleine-Budde:
> The usb_8dev hardware has problems on some xhci USB hosts. The driver fails to
> read the firmware revision in the probe function. This leads to the following
> Oops:
>
>      [ 3356.635912] kernel BUG at net/core/dev.c:5701!
>
> The driver tries to free the netdev, which has already been registered, without
> unregistering it.
>
> This patch fixes the problem by unregistering the netdev in the error path.
>

Thank you for the patch!

I've applied it to my source tree:
https://github.com/krumboeck/usb2can


regards,
Bernd

