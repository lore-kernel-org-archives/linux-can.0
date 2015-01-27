From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 09:00:09 +0100
Message-ID: <54C74589.9050603@hartkopp.net>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:45415 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbA0IAW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 03:00:22 -0500
In-Reply-To: <54C6ACBD.2020806@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

>> I assume it is better to set the ctrlmode directly in the struct can_priv
>> element in  pcan_usb_fd_init() after retrieving the firmware version.
>
> Even better.
>
>> IMO it doesn't make sense to transport this info through the mechanic above
>> which mostly initialized quasi constant settings for the adapter.
>
> If we check the firmware version, it doesn't make sende to put the
> information into that struct (IMHO)
>

Just to be sure: We stated to have the same opinion here, right?

>> +/* describes the PCAN-USB Pro FD adapter */
>> +struct peak_usb_adapter pcan_usb_pro_fd = {
>>
>> be
>>
>> +/* describes the PCAN-USB Pro FD adapter */
>> +const struct peak_usb_adapter pcan_usb_pro_fd = {
>
> Yes, but it probably needs some more modifications in the driver.

I don't know if this struct is "read-only" all the time.
If so it is easy to change.

I pity you, Stephane - but we will make it :-))

Thanks,
Oliver
