From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux kernel
 into include/linux
Date: Tue, 21 Jan 2014 12:51:17 +0100
Message-ID: <52DE5F35.2040905@hartkopp.net>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de> <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de> <52D85910.8000200@pengutronix.de> <20140117133709.GD25911@pengutronix.de> <52D93885.5040109@pengutronix.de> <20140117203605.GF25911@pengutronix.de> <52DA7106.5000300@hartkopp.net> <20140121095337.GR25911@pengutronix.de> <52DE5B3F.3010900@hartkopp.net> <52DE5C12.70503@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:52081 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbaAULvW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 06:51:22 -0500
In-Reply-To: <52DE5C12.70503@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7Zu?= =?UTF-8?B?aWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 21.01.2014 12:37, Marc Kleine-Budde wrote:
> On 01/21/2014 12:34 PM, Oliver Hartkopp wrote:
> 
>>> @Marc or Oliver: Can you please give me a ping as soon as the headers
>>> hit your public repo. Thanks.
>>
>> Indeed I would vote for your latest patch set (v5) as the only missing thing
>> there would be to move isotp.h from include/socketcan/can/isotp.h to
>> include/linux/can/isotp.h and delete the socketcan directory then.
>>
>> In Marcs patch set (v6) the license updates got lost at some point.
> 
> Uwe's patchs never included the actual import of the kernel headers,
> which bring the license information. I'll post a follow up patch v7,
> that import the kernel headers, too.

ok tnx!
