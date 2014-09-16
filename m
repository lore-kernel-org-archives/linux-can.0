From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: RFC: Improve and consolidate error state change
Date: Tue, 16 Sep 2014 14:36:16 +0000
Message-ID: <54184AE0.6050100@marel.com>
References: <5411F360.4020103@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0064.outbound.protection.outlook.com ([65.55.169.64]:45710
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753356AbaIPPIz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 16 Sep 2014 11:08:55 -0400
In-Reply-To: <5411F360.4020103@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org


On fim 11.sep 2014 19:09, Andri Yngvason wrote:
> Hello,
>
> As we've discussed in a recent thread, error state changes are 
> inconsistent
> between platforms. Wolfgang had already done some work on this a 
> couple of
> years ago, but it never made it into the kernel.
> See: http://thread.gmane.org/gmane.linux.can/201

...
>
> I've also edited the mscan, flexcan and sja1000 drivers to use this 
> function,
> but I actually don't have hardware to test this on any other platforms.
>
> Is anyone willing to test this on other platforms?
>
> I'll post patches, when there's been feedback on this.
>

Ping?
