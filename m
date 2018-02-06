From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Tue, 6 Feb 2018 19:06:58 +0100
Message-ID: <4b5862a0-5031-37bc-5228-cd21e93a21be@theobroma-systems.com>
References: <20180202105949.35468-1-jakob.unterwurzacher@theobroma-systems.com>
 <151791829759.10539.108405894622744980@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:48416 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752803AbeBFSaH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Feb 2018 13:30:07 -0500
In-Reply-To: <151791829759.10539.108405894622744980@maxwell>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Andri!

> Great! Where can I buy one?

The product page just went online at
https://www.theobroma-systems.com/communication-modules/seal/overview
but at the moment you can only get one by writing an email to sales.
I'll get back to you off-list.

Thanks for the code review, feedback is noted, issues will be addressed 
in v2.

> Like I said before, this seems like a good idea and I'm looking forward to
> seeing the USB stick on the market, and to see this driver develop further.
> 
> By the way, I'm curious, will it be possible to update the firmware on the USB
> stick via the USB?

Yes! There is a button on the PCB that sends the microcontroller into 
DFU mode, and you can update it using dfu-util.

We had an internal discussion about the unbounded worst-case latency of 
the USB bulk mode and are looking for a way to address this is v2. This 
probably needs changes to the protocol, so it'll take us some time.

Best regards,
Jakob
