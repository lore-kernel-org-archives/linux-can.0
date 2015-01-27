From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 14:10:37 +0100
Message-ID: <54C78E4D.9060601@hartkopp.net>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net> <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:26835 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbbA0NKw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 08:10:52 -0500
In-Reply-To: <54C78C6E.3070705@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi Stephane, Marc,

On 27.01.2015 14:02, Stephane Grosjean wrote:

> But putting "const" here leads to several other changes in pcan_usb_core.h and
> pcan_usb_core.c (as well as in older pcan_usb.c and pcan_usb_pro.c files,
> where same struct peak_adapter static objects are used to define the
> corresponding USB adapter).
>
> Do you need another patch which does this, once for all?

I would suggest the following:

1. Send a new patch set where the CAN_CTRLMODE_FD_NON_ISO is set as discussed
2. Marc: Please put these patches into peak-next branch as it was
3. Plan the conversion to constify the struct for 3.21

IMO it makes more sense to make this in the next next-net cycle.

Regards,
Oliver

