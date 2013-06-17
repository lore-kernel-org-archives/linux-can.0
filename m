From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PCAN drivers?
Date: Mon, 17 Jun 2013 15:45:49 +0100
Message-ID: <51BF211D.7030404@mlbassoc.com>
References: <51BF1C74.5030506@mlbassoc.com> <51BF1FDF.2060003@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.analogue-micro.com ([217.144.149.242]:42990 "EHLO
	mail.analogue-micro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3FQOpv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 10:45:51 -0400
In-Reply-To: <51BF1FDF.2060003@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 2013-06-17 15:40, Marc Kleine-Budde wrote:
> On 06/17/2013 04:25 PM, Gary Thomas wrote:
>> What's the best driver for the Peak PCAN PCI board?
>>    PEAK-System Technik GmbH PCAN-PCI CAN-Bus controller
>> I'm interested in linux-3.5.2 on Fedora 17
>
> The PEAK PCI  should work out-of-the box with kernel version v3.2. The
> PCI Express Cards shoud work with v3.4.

Thanks.  What driver module do I need for this (none seem to come
packaged with the Fedora kernel)?

What about the CAN utils (cansend, candump, etc)?

Sorry for the barrage of questions; I used this stuff years ago
and time seems to have marched on whilst I had to do other things...

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
