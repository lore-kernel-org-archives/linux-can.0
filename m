From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4 4/5] can: bcm: add support for CAN FD frames
Date: Fri, 17 Jun 2016 12:37:37 +0200
Message-ID: <5763D2F1.5040408@hartkopp.net>
References: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
 <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>
 <d37c690e-d872-cf25-b22c-7a6def80069f@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:50084 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbcFQKiV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 06:38:21 -0400
In-Reply-To: <d37c690e-d872-cf25-b22c-7a6def80069f@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 06/17/2016 12:23 PM, Marc Kleine-Budde wrote:
> On 06/04/2016 09:26 PM, Oliver Hartkopp wrote:

>> -/* easy access to CAN frame payload */
>> -static inline u64 GET_U64(const struct can_frame *cp)
>> +/* easy access to the first 64 bit of can(fd)_frame payload */
>> +static inline u64 GET_U64(const struct canfd_frame *cp, int offset)
>>   {
>> -	return *(u64 *)cp->data;
>> +	return *(u64 *)(cp->data + offset);
>
> Can you ensure that offset is always a multiple of 8?

I would like to put that into a comment, as a check for this helper at 
runtime is too expensive - and the caller is only in this C-file at two 
places.

> Unaligned pointer
> access will be quite slow on some platforms.

cp->data is well aligned.

> Can you please make this
> function lower-case (as it's a function not a macro).

will do.

Tnx,
Oliver

