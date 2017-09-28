From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Implement new Kvaser USB driver, where to start?
Date: Thu, 28 Sep 2017 19:39:06 +0200
Message-ID: <76194977-f3a6-25ab-59c3-b8c66f0a35e3@hartkopp.net>
References: <4a46b81e-1073-8a33-e674-d43c8579985a@kvaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:22428 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdI1RjO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Sep 2017 13:39:14 -0400
In-Reply-To: <4a46b81e-1073-8a33-e674-d43c8579985a@kvaser.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org

Hi Jimmy,

On 09/27/2017 03:54 PM, Jimmy Assarsson wrote:
> We are in the planning stage of writing a new SocketCAN driver for our latest
> generation USB based CAN interface platform (minihydra). Currently we try to
> estimate the work effort for implementing the driver.

Nice to see that Kvaser becomes a direct driver contributor for their hardware ;-)

> The communication protocol is slightly different to our former platform, leaf
> (which is already supported by SocketCAN).

Does 'slightly' different mean, that some of the messages need to be
'extended' and some new messages need to be added - or is it a different USB
protocol paradigm?

> The minihydra platform also utilizes
> CAN FD. I assume that it is preferable to extend the current driver, kvaser_usb,
> rather than implementing a second?

The PEAK guys had a similar problem when they lauched their 'ucan' IP core
which is integrated into their recent USB & PCI products.

Just a raw guess:
When its about 30% increase in source code -> add it to the existing driver.

Maybe it makes sense to create a new directory in drivers/net/can/usb/kvaser
and split the driver into several c- and h-files to group the usb
communication and the two different IP core specific routines.

Best regards,
Oliver

