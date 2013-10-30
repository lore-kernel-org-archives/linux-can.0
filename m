From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: kvaser_usb: fix usb endpoints detection
Date: Wed, 30 Oct 2013 19:43:44 +0100
Message-ID: <52715360.2030900@hartkopp.net>
References: <1382963081-11012-1-git-send-email-mkl@pengutronix.de> <20131028132959.GA19808@hposo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:36124 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3J3Snr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Oct 2013 14:43:47 -0400
In-Reply-To: <20131028132959.GA19808@hposo>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

do you plan to add my BCM documentation patch from October 19th when you push
this fix to Dave?

Regards,
Oliver


On 28.10.2013 14:29, Olivier Sobrie wrote:
> On Mon, Oct 28, 2013 at 01:24:41PM +0100, Marc Kleine-Budde wrote:
>> From: Olivier Sobrie <olivier@sobrie.be>
>>
>> Some devices, like the Kvaser Memorator Professional, have several bulk in
>> endpoints. Only the first one found must be used by the driver. The same holds
>> for the bulk out endpoint. The official Kvaser driver (leaf) was used as
>> reference.
>>
>> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>
>> changes since v2:
>> - let kvaser_usb_get_endpoints() return 0 on success, -ENODEV otherwise
> 
> Perfect !
> Thank you,

